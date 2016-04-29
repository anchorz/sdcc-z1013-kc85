#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#define DEBUG_MSG 1

#include "z1013font.h"

/*(Farbdefinitionen vom EC1834 Emulator
 * für den Moment brauchen wir nur Schwarz und Weiss
 * muss noch für den KC85 angepasst werden*/
#define C_black 0
#define C_maroon 1
#define C_green 2
#define C_olive 3
#define C_navy 4
#define C_purple 5
#define C_teal 6
#define C_silver 7
#define C_gray 8
#define C_red 9
#define C_lime 10
#define C_yellow 11
#define C_blue 12
#define C_fuchsia 13
#define C_aqua 14
#define C_white 15

#define TYPE(X) __STRING(X)

void gfx_init();

const char *emu_window_name = "Z1013 32x32";

#define WIDTH  32
#define HEIGHT 32
#define PIXEL_WIDTH_MIN 256
#define PIXEL_HEIGHT_MIN 256
#define INITIAL_SCALE 2
int scale = INITIAL_SCALE;
int emu_window_width = INITIAL_SCALE * PIXEL_WIDTH_MIN;
int emu_window_height = INITIAL_SCALE * PIXEL_HEIGHT_MIN;

static Display *display;
static Visual *visual;
static int screen;
static int depth;
/* static Pixmap pixmap; später für double buffering */

#define ZOOM_MAX 5
static Pixmap font[ZOOM_MAX];
static Window win;
static GC gc;
static GC gcInvers;
static Colormap cmap;

unsigned char bws[WIDTH * HEIGHT];
unsigned char cutBuffer[WIDTH * HEIGHT + HEIGHT];
unsigned int cursorPos = 0;
unsigned char cursorContent;

#define STATIC_COLOR_COUNT 16
/* Farbtabelle für C_xxx */
static unsigned long cmap24[STATIC_COLOR_COUNT] = { 0, 0x800000, 0x008000,
        0x808000, 0x000080, 0x800080, 0x008080, 0xc0c0c0, 0x808080, 0xFF0000,
        0x00ff00, 0xffff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xffffff };

static void create_colormap_lookup_table() {
    int i;
    XColor xc;

    xc.flags = DoRed | DoGreen | DoBlue;
    cmap = DefaultColormap(display, screen);
    for (i = 0; i < STATIC_COLOR_COUNT; i++) {

        xc.red = (cmap24[i] & 0xff) << 8;
        xc.blue = (cmap24[i] & 0xff00);
        xc.green = ((cmap24[i] >> 8) & 0xff00);

        XAllocColor(display, cmap, &xc);
    }
}

#if DEBUG_MSG
static void dbg_print_event(XEvent *event) {
    char msg[128];
    switch (event->type) {
    case KeyPress: /* 2 */
        sprintf(msg, "KeyPress");
        break;
    case KeyRelease: /* 3 */
        sprintf(msg, "KeyRelease");
        break;
    case ButtonPress:/* 4 */
        sprintf(msg, "ButtonPress");
        break;
    case ButtonRelease:/* 5 */
        sprintf(msg, "ButtonRelease");
        break;
    case MotionNotify:/* 6 */
        sprintf(msg, "MotionNotify");
        break;
    case ReparentNotify:
        sprintf(msg, "ReparentNotify");
        break;
    case ConfigureNotify:
        sprintf(msg, "ConfigureNotify:x=%3d,y=%3d,w=%3d,h=%3d,b=%d",
                event->xconfigurerequest.x, event->xconfigurerequest.y,
                event->xconfigurerequest.width, event->xconfigurerequest.height,
                event->xconfigurerequest.border_width);
        break;
    case MapNotify:
        sprintf(msg, "MapNotify");
        break;
    case ClientMessage:
        sprintf(msg, "ClientMessage");
        break;
    case NoExpose:
        /* sprintf(msg,"NoExpose"); stört */
        return;
        break;
    case Expose:
        sprintf(msg, "Expose:x=%3d,y=%3d,w=%3d,h=%3d,cnt=%d,sev=%s",
                event->xexpose.x, event->xexpose.y, event->xexpose.width,
                event->xexpose.height, event->xexpose.count,
                event->xexpose.send_event ? "true" : "false");
        break;
    case SelectionClear:/* 29 */
        sprintf(msg, "SelectionClear");
        break;
    case SelectionRequest:/* 30 */
        sprintf(msg, "SelectionRequest");
        break;
    case PropertyNotify:
        sprintf(msg, "PropertyNotify state=%d name=%s", event->xproperty.state,
                XGetAtomName(display, event->xproperty.atom));
        break;
    default:
        sprintf(msg, "XEvent(Unknown[%d])", event->type);
        break;
    }
    printf("XEvent(%s)\n", msg);
}
#endif

static int start_x = 0;
static int start_y = 0;

static int getCharacterWidth() {
    return scale * 8;
}

static int getCharacterHeight() {
    return scale * 8;
}

static int selectText = 0;
static int cursorFromX;
static int cursorFromY;
static int cursorToX;
static int cursorToY;
/* sortiere Version der Werte cursorFrom.. und cursorTo.. */
static int cx1, cy1, cx2, cy2;

/* TODO avoid flickering - use pixmap instead */
static void sortSelectionCorners() {
    if (cursorFromX > cursorToX) {
        cx1 = cursorToX;
        cx2 = cursorFromX;
    } else {
        cx2 = cursorToX;
        cx1 = cursorFromX;
    }

    if (cursorFromY > cursorToY) {
        cy1 = cursorToY;
        cy2 = cursorFromY;
    } else {
        cy2 = cursorToY;
        cy1 = cursorFromY;
    }
}

static void redraw() {
    int x, y;

    sortSelectionCorners();

    XSetForeground(display, gcInvers, cmap24[C_blue]);
    for (y = 0; y < HEIGHT; y++) {
        for (x = 0; x < WIDTH; x++) {
            XCopyArea(display, font[scale - 1], win, gc,
                    bws[y * WIDTH + x] * getCharacterWidth(), 0,
                    getCharacterWidth(), getCharacterHeight(),
                    start_x + x * getCharacterWidth(),
                    start_y + y * getCharacterHeight());
            if (selectText && x >= cx1 && y >= cy1 && x <= cx2 && y <= cy2) {
                XFillRectangle(display, win, gcInvers,
                        start_x + x * getCharacterWidth(),
                        start_y + y * getCharacterHeight(), getCharacterWidth(),
                        getCharacterHeight());
            }
        }
    }
}

static volatile int update = 0;
static volatile int initialized = 0;

static void handleSelectionRequest(XSelectionRequestEvent ev) {
    static long chunk_size;
    static Atom targets;
    int sel_len = 0;
    int x, y;
    unsigned char *dst = cutBuffer;

    XEvent res;

    sortSelectionCorners();
    printf("cx1=%d\n", cx1);
    for (y = cy1; y <= cy2; y++) {
        for (x = cx1; x <= cx2; x++) {
            *dst++ = bws[y * WIDTH + x];
            sel_len++;
        }
        *dst++ = 0x0a;
        sel_len++;
    }

    if (!targets) {
        targets = XInternAtom(display, "TARGETS", False);
    }
    if (!chunk_size) {
        chunk_size = XExtendedMaxRequestSize(display) / 4;
        if (!chunk_size) {
            chunk_size = XMaxRequestSize(display) / 4;
        }
    }
    sel_len = sel_len > chunk_size ? chunk_size : sel_len;

    XChangeProperty(display, ev.requestor, ev.property, XA_STRING, 8,
    PropModeReplace, cutBuffer, sel_len);

    res.xselection.property = ev.property;
    res.xselection.type = SelectionNotify;
    res.xselection.display = ev.display;
    res.xselection.requestor = ev.requestor;
    res.xselection.selection = ev.selection;
    res.xselection.target = ev.target;
    res.xselection.time = ev.time;

    XSendEvent(display, ev.requestor, 0, 0, &res);
    XFlush(display);
}

static void handle_event() {
    XEvent event;
    KeySym key; /* a dealie-bob to handle KeyPress Events */
    char text[255]; /* a char buffer for KeyPress Events */

    while (1) {

        while (!XPending(display)) {
            if (update) {
                redraw();
                update = 0;
                usleep(0x20000);
            }
        }
        XNextEvent(display, &event);
#if DEBUG_MSG
        dbg_print_event(&event);
#endif 	
        if (event.type == Expose && event.xexpose.count == 0) {
            redraw();
        }
        if (event.type == KeyPress
                && XLookupString(&event.xkey, text, 255, &key, 0) == 1) {
            if (text[0] == 'q' || text[0] == 0x3) {
                break;
            }
        }
        if (event.type == ConfigureNotify) {
            int scaleX = event.xconfigurerequest.width / PIXEL_WIDTH_MIN;
            int scaleY = event.xconfigurerequest.height / PIXEL_HEIGHT_MIN;
            int tmpScale = scaleX > scaleY ? scaleY : scaleX;
            scale = tmpScale ? tmpScale : 1;
            scale = scale > ZOOM_MAX ? ZOOM_MAX : scale;
            emu_window_width = PIXEL_WIDTH_MIN * scale;
            emu_window_height = PIXEL_HEIGHT_MIN * scale;
            start_x = (event.xconfigurerequest.width - emu_window_width) / 2;
            start_y = (event.xconfigurerequest.height - emu_window_height) / 2;
        }

        if (event.type == ClientMessage) {
            /* TODO erledigen wir später, test ob auch wirklich das Fester geschlossen werden soll
             * if (event.xclient.data.l[0] == wmDeleteWindow) { global.done = 1; } */
            break;
        }

        if (event.type == ButtonPress) {
            cursorFromX = (event.xbutton.x - start_x) / getCharacterWidth();
            cursorFromY = (event.xbutton.y - start_y) / getCharacterHeight();
            selectText = 1;
        }
        if (event.type == ButtonRelease) {
            selectText = 0;
            XSetSelectionOwner(display, XA_PRIMARY, win, CurrentTime);
            redraw();
        }
        if (event.type == MotionNotify) {
            cursorToX = (event.xmotion.x - start_x) / getCharacterWidth();
            cursorToY = (event.xmotion.y - start_y) / getCharacterHeight();
            cursorToX = cursorToX < 0 ? 0 : cursorToX;
            cursorToY = cursorToY < 0 ? 0 : cursorToY;

            cursorToX = cursorToX >= WIDTH ? WIDTH - 1 : cursorToX;
            cursorToY = cursorToY >= HEIGHT ? HEIGHT - 1 : cursorToY;

            printf("mark (%d,%d) (%d,%d)\n", cursorFromX, cursorFromY,
                    cursorToX, cursorToY);
            redraw();
        }
        if (event.type == SelectionRequest) {
            handleSelectionRequest(event.xselectionrequest);
        }

    }
}

static void generateFonts() {
    int i, j, cnt, f;

    for (f = 0; f < ZOOM_MAX; f++) {
        int scale = f + 1;
        int fontWidth = 256 * 8 * scale;
        int characterSize = 8 * scale;
        font[f] = XCreatePixmap(display, win, fontWidth, characterSize, depth);
        XSetForeground(display, gc, cmap24[C_black]);
        XFillRectangle(display, font[scale - 1], gc, 0, 0, fontWidth,
                characterSize);
        XSetForeground(display, gc, cmap24[C_white]);

        for (cnt = 0; cnt < 256; cnt++) {
            for (j = 0; j < 8; j++) {
                char c = z1013font[cnt * 8 + j];
                for (i = 0; i < 8; i++) {
                    if (c & 0x80) {
                        XFillRectangle(display, font[f], gc,
                                cnt * characterSize + i * scale, j * scale,
                                scale, scale);
                    }
                    c *= 2;
                }
            }
        }
    }
}

static void gfx_exit() {
    int f;
    for (f = 0; f < ZOOM_MAX; f++) {
        XFreePixmap(display, font[f]);
    }
    XFreeGC(display, gc);
    XFreeGC(display, gcInvers);
    XDestroyWindow(display, win);
    XCloseDisplay(display);
}

/* TODO hier is ein Fehler, wenn das Fenster einen Rand hat, teste Wert 32 */
#define WINDOW_FRAME 0
void gfx_init_x11() {
    XSetWindowAttributes attr;
    XSizeHints hints;
    Atom WM_DELETE_WINDOW;
    XGCValues gcValues;

    display = XOpenDisplay(NULL);
    screen = DefaultScreen(display);
    visual = DefaultVisual(display, screen);
    depth = DefaultDepth(display, screen);

    create_colormap_lookup_table();

    /* hints.flags=PResizeInc|PMinSize|PMaxSize; */
    hints.flags = PMinSize;
    hints.max_width = 2 * emu_window_width;
    hints.max_height = 2 * emu_window_height;
    hints.min_width = PIXEL_WIDTH_MIN;
    hints.min_height = PIXEL_HEIGHT_MIN;
    hints.width_inc = 16;
    hints.height_inc = 16;

    attr.background_pixel = cmap24[C_gray]; /* TODO customize */
    win = XCreateWindow(display, DefaultRootWindow(display), 0, 0,
            emu_window_width + WINDOW_FRAME, emu_window_height + WINDOW_FRAME,
            0, CopyFromParent,
            CopyFromParent, CopyFromParent, CWBackPixel, &attr);

    WM_DELETE_WINDOW = XInternAtom(display, "WM_DELETE_WINDOW", False);
    XSetWMProtocols(display, win, &WM_DELETE_WINDOW, 1);
    XSetWMNormalHints(display, win, &hints);

    XSetStandardProperties(display, win, emu_window_name, emu_window_name,
    None,
    NULL, 0, NULL);

    XSelectInput(display, win,
            ExposureMask | ButtonPressMask | ButtonReleaseMask
                    | PropertyChangeMask | KeyPressMask | Button1MotionMask
                    | StructureNotifyMask);
    gc = XCreateGC(display, win, 0, 0);
    gcValues.function = GXor;
    gcInvers = XCreateGC(display, win, GCFunction, &gcValues);
    XClearWindow(display, win);

    generateFonts();
    initialized = 1; /* so jetzt läuft unser Main-Thread weiter */

    XMapRaised(display, win);
    XFlush(display);

    handle_event();
    gfx_exit();
}

pthread_t tid;

void* doSomeThing(void *arg) {
    gfx_init_x11();
    printf("application closed from UI-Thread\n");
    exit(1);
    return NULL;
}

void gfx_putchar(unsigned char c) {
    bws[cursorPos] = cursorContent;
    switch (c) {
    case 0x08:
        if (cursorPos > 0) {
            cursorPos--;
        } else {
            printf("cursorPos=0 and runs left\n");
        }
        break;
    case 0x09:
        if (cursorPos >= WIDTH * HEIGHT) {
            memmove(bws, bws + WIDTH, WIDTH * HEIGHT - WIDTH);
            memset(bws + WIDTH * HEIGHT - WIDTH, ' ', WIDTH);
            cursorPos -= WIDTH;
            cursorPos /= WIDTH;
            cursorPos *= WIDTH;
        }
        cursorPos++;
        break;
    case 0x0c:
        memset(bws, ' ', WIDTH * HEIGHT);
        cursorPos = 0;
        break;
    case 0x0d:
        cursorPos += WIDTH;
        cursorPos /= WIDTH;
        cursorPos *= WIDTH;
        if (cursorPos >= WIDTH * HEIGHT) {
            memmove(bws, bws + WIDTH, WIDTH * HEIGHT - WIDTH);
            memset(bws + WIDTH * HEIGHT - WIDTH, ' ', WIDTH);
            cursorPos -= WIDTH;
        }
        break;
    default:
        if (cursorPos >= WIDTH * HEIGHT) {
            memmove(bws, bws + WIDTH, WIDTH * HEIGHT - WIDTH);
            memset(bws + WIDTH * HEIGHT - WIDTH, ' ', WIDTH);
            cursorPos -= WIDTH;
            cursorPos /= WIDTH;
            cursorPos *= WIDTH;
        }
        bws[cursorPos++] = c;
    }
    cursorContent = bws[cursorPos];
    bws[cursorPos] = 0xff;
    update = 1;
}

void gfx_puts(char *s) {
    unsigned char c;
    while ((c = *s++)) {
        gfx_putchar(c);
    }
}

/* demo code für ein Menu
 static void makeframe() {
 gfx_puts(
 "\xa8\xa0\xa0\xa0\xa4\xa0\xa0\xa0\xa0\xa0\xa4\xa0\xa0\xa0\xa0\xa0\xa0\xa9\xd");
 gfx_puts("\xa1Neu\xa1Liste\xa1Konten\xa1\xd");
 gfx_puts(
 "\xa2\xa0\xa0\xa0\xa2\xa0\xa0\xa0\xa0\xa0\xa2\xa0\xa0\xa0\xa0\xa0\xa0\xa2\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xd");

 gfx_puts(
 "\xc1\x9e\x9e\x9e\x89\x9e\x9e\x9e\x9e\x9e\x9e\x89\x9e\x9e\x9e\x9e\x9e\x9e\x9e\x89\xd");
 gfx_puts("\x9fNeu\xc0 Liste\xc0 Konten\xc0\xd");
 gfx_puts(
 "\x88\xf8\xf8\xf8\xc8\xf8\xf8\xf8\xf8\xf8\xf8\xc8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xc8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xd");

 gfx_puts(
 "\xc1\x9e\x9e\x9e\x9a\x9e\x9e\x9e\x9e\x9e\x9a\x9e\x9e\x9e\x9e\x9e\x9e\x89\xd");
 gfx_puts("\x9fNeu Liste Konten\xc0\xd");
 gfx_puts(
 "\x88\xf8\xf8\xf8\x9d\xf8\xf8\xf8\xf8\xf8\x9d\xf8\xf8\xf8\xf8\xf8\xf8\xc8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xf8\xd");

 gfx_puts("2016-03\xd\xd");
 gfx_puts("01\x9f" "500.000,00\x9fGehalt Maerz 2016\xd");
 gfx_puts("  \x9f          \x9fplus Sonderzahlung");
 gfx_puts("02\x9f  1.500,30\x9fGehalt Maerz 2016\xd");
 } */

void gfx_init() {
    int cnt, err;

    for (cnt = 0; cnt < WIDTH * HEIGHT; cnt++) {
        bws[cnt] = rand() & 0xff;
    }

    err = pthread_create(&(tid), NULL, &doSomeThing, NULL);
    if (err != 0) {
        printf("can't create thread :[%s]\n", strerror(err));
    } else {
        printf("UI-Thread created successfully\n");
    }

    while (!initialized) {
    }
    printf("UI-Thread initialized\n");

    gfx_putchar(0x0c);
    gfx_putchar(0x0d);
    gfx_putchar(0x0d);
    gfx_puts("Z1013+K7659/2.028 RB");
    gfx_putchar(0x0d);
    gfx_puts(" # J 100");
    gfx_putchar(0x0d);

}

