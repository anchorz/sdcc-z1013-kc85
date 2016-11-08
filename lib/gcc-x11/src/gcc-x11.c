#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>
#include <X11/keysymdef.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#define DEBUG_MSG 0

#include <conio.h>
#include "z1013font.h"

/*(Farbdefinitionen vom EC1834 Emulator
 * für den Moment brauchen wir nur Schwarz und Weiss
 * muss noch für den KC85 angepasst werden*/
#define COLOR_BG_BLACK   0x00
#define COLOR_BG_RED     0x01
#define COLOR_BG_GREEN   0x02
#define COLOR_BG_YELLOW  0x03
#define COLOR_BG_BLUE    0x04
#define COLOR_BG_MAGENTA 0x05
#define COLOR_BG_CYAN    0x06
#define COLOR_BG_WHITE   0x07

#define COLOR_FG_BLACK   0x00
#define COLOR_FG_RED     0x10
#define COLOR_FG_GREEN   0x20
#define COLOR_FG_YELLOW  0x30
#define COLOR_FG_BLUE    0x40
#define COLOR_FG_MAGENTA 0x50
#define COLOR_FG_CYAN    0x60
#define COLOR_FG_WHITE   0x70

#define C_black 0
#define C_red 1
#define C_green 2
#define C_yellow 3
#define C_blue 4
#define C_magenta 5
#define C_cyan 6
#define C_white 7
#define C_gray 8

#define TYPE(X) __STRING(X)

void gfx_init();

typedef struct {
    const char *title;
    const int pixel_width;
    const int pixel_height;
    const int text_width;
    const int text_height;
} GraphicModel;

#define MODEL_Z1013 0
#define MODEL_Z9001 1

const GraphicModel models[] = { { "Z1013 32x32", 256, 256, 32, 32 }, {
        "Z9001 40x24", 320, 192, 40, 24 } };
const GraphicModel *selected_model = &models[1];

//#define WIDTH  32
//#define HEIGHT 32
//#define PIXEL_WIDTH_MIN 256
//#define PIXEL_HEIGHT_MIN 256
#define INITIAL_SCALE 2
int scale;
int emu_window_width;
int emu_window_height;

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

unsigned char *bws;
unsigned char *pixelRam;
unsigned int pixelRamSize;
unsigned int lineWidth;
unsigned int lines;

unsigned char *colorRam;
unsigned int colorRamSize;

unsigned char *cutBuffer; //[WIDTH * HEIGHT + HEIGHT];
unsigned int cursorPos = 0;
unsigned char cursorContent;

#define STATIC_COLOR_COUNT 16
/* Farbtabelle für C_xxx */
static unsigned long cmap24[STATIC_COLOR_COUNT] = { 0, 0xFF0000, 0x00FF00,
        0xFFFF00, //
        0x0000FF, 0xFF00FF, 0x00FFFF, 0xFFFFFF, //
        0x808080, 0xFF0000, 0x00FF00,
        0xFFFF00, 0, 0xFF0000, 0x00FF00, 0xFFFF00, };

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
        sprintf(msg, "KeyPress %x", event->xkey.keycode);
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

static int krtOn = 0;

void gfx_setKrtEnabled(int arg) {
    krtOn = arg;
}

static void redrawText() {
    int x, y;

    XSetForeground(display, gcInvers, cmap24[C_blue]);
    for (y = 0; y < selected_model->text_height; y++) {
        for (x = 0; x < selected_model->text_width; x++) {
            XCopyArea(display, font[scale - 1], win, gc,
                    bws[y * selected_model->text_width + x]
                            * getCharacterWidth(), 0, getCharacterWidth(),
                    getCharacterHeight(), start_x + x * getCharacterWidth(),
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

static void redrawKrt() {
    int i, x, y;

    XSetForeground(display, gcInvers, cmap24[C_white]);

    unsigned char *ptr = pixelRam;

    unsigned int segmentSize=(lines/8)*lineWidth;
    for (y = 0; y < selected_model->pixel_height; y++) {
        unsigned int segment=y%8;
        unsigned char *ptrLine=ptr+segment*segmentSize+y/8*lineWidth;
        for (x = 0; x < selected_model->pixel_width;) {
            unsigned char c = ptrLine[x/8];
            unsigned char colorByte = colorRam[y / 8
                    * selected_model->text_width + x / 8];
            unsigned char backgroundColor = colorByte & 0x7;
            XSetForeground(display, gc, cmap24[backgroundColor]);
            unsigned char foregroundColor = (colorByte/16)& 0x7;
            XSetForeground(display, gcInvers, cmap24[foregroundColor]);

            for (i = 0; i < 8; i++) {

                XFillRectangle(display, win, c & 0x80 ? gcInvers : gc,
                        start_x + x * scale, start_y + y * scale, scale, scale);
                x++;
                c *= 2;
            }
        }
    }
}

static void redraw() {

    sortSelectionCorners();
    if (krtOn) {
        redrawKrt();
    } else {
        redrawText();
    }

}

volatile int update = 0;
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
            *dst++ = bws[y * selected_model->text_width + x];
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

/*TODO better to use a kind of buffer: lets assume 4 keys will be pressed and only 3 released
 what would the value of lastKeyStroke be?*/
unsigned char lastKeyStroke = 0;

unsigned char gfx_get_keystroke() {
    return lastKeyStroke;
}

char kbhit()
{
    if (lastKeyStroke) return -1;
    return 0;
}

char getch()
{
    while(!lastKeyStroke);
    return lastKeyStroke;
}


static void handle_event() {
    XEvent event;
    KeySym key; /* a dealie-bob to handle KeyPress Events */
    char text[255]; /* a char buffer for KeyPress Events */

    while (1) {

        while (!XPending(display)) {
            if (update) {
                printf("update\n");
                XClearArea(display, win, 0, 0, emu_window_width, emu_window_height, 1);

                //redraw();
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
        if (event.type == KeyRelease) {
            lastKeyStroke = 0;
        }

        if (event.type == KeyPress) {
            int len = XLookupString(&event.xkey, text, 255, &key, 0);
            if (len > 0) {
                lastKeyStroke = text[0];
            } else {
                /*TODO use mapping table*/
                switch (key) {
                case XK_Left:
                    lastKeyStroke = 0x08;
                    break;
                case XK_Right:
                    lastKeyStroke = 0x09;
                    break;
                case XK_Up:
                    lastKeyStroke = 0x0b;
                    break;
                case XK_Down:
                    lastKeyStroke = 0x0a;
                    break;
                default:
                    printf("umpapped key %lx->0x%x\n", key, lastKeyStroke);
                    lastKeyStroke = 0;
                    break;
                }
            }
            /*if (text[0] == 'q' || text[0] == 0x3) {
             break;*/
        }
        if (event.type == ConfigureNotify) {
            int scaleX = event.xconfigurerequest.width
                    / selected_model->pixel_width;
            int scaleY = event.xconfigurerequest.height
                    / selected_model->pixel_height;
            int tmpScale = scaleX > scaleY ? scaleY : scaleX;
            scale = tmpScale ? tmpScale : 1;
            scale = scale > ZOOM_MAX ? ZOOM_MAX : scale;
            emu_window_width = selected_model->pixel_width * scale;
            emu_window_height = selected_model->pixel_height * scale;
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

            cursorToX =
                    cursorToX >= selected_model->text_width ?
                            selected_model->text_width : cursorToX;
            cursorToY =
                    cursorToY >= selected_model->text_height ?
                            selected_model->text_height - 1 : cursorToY;

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
    hints.min_width = selected_model->pixel_width;
    hints.min_height = selected_model->pixel_height;
    hints.width_inc = 16;
    hints.height_inc = 16;

    attr.background_pixel = cmap24[C_gray]; /* TODO customize */
    win = XCreateWindow(display, DefaultRootWindow(display), 0, 0,
            emu_window_width + WINDOW_FRAME, emu_window_height + WINDOW_FRAME,
            0,
            CopyFromParent,
            CopyFromParent, CopyFromParent, CWBackPixel, &attr);

    WM_DELETE_WINDOW = XInternAtom(display, "WM_DELETE_WINDOW", False);
    XSetWMProtocols(display, win, &WM_DELETE_WINDOW, 1);
    XSetWMNormalHints(display, win, &hints);

    XSetStandardProperties(display, win, selected_model->title,
            selected_model->title,
            None,
            NULL, 0, NULL);

    XSelectInput(display, win,
            ExposureMask | ButtonPressMask | ButtonReleaseMask
                    | PropertyChangeMask | KeyPressMask | KeyReleaseMask
                    | Button1MotionMask | StructureNotifyMask);
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

void gfx_set_char(unsigned int index, unsigned char c) {
    bws[index] = c;
    update = 1;
}

unsigned char gfx_get_char(unsigned int index) {
    return bws[index];
}

unsigned char gfx_get_screen_width() {
    return selected_model->text_width;
}

unsigned char gfx_get_screen_height() {
    return selected_model->text_height;
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
        if (cursorPos
                >= selected_model->text_width * selected_model->text_height) {
            memmove(bws, bws + selected_model->text_width,
                    selected_model->text_width * selected_model->text_height
                            - selected_model->text_width);
            memset(
                    bws
                            + selected_model->text_width
                                    * selected_model->text_height
                            - selected_model->text_width, ' ',
                    selected_model->text_width);
            cursorPos -= selected_model->text_width;
            cursorPos /= selected_model->text_width;
            cursorPos *= selected_model->text_width;
        }
        cursorPos++;
        break;
    case 0x0c:
        memset(bws, ' ',
                selected_model->text_width * selected_model->text_height);
        cursorPos = 0;
        break;
    case 0x0d:
        cursorPos += selected_model->text_width;
        cursorPos /= selected_model->text_width;
        cursorPos *= selected_model->text_width;
        if (cursorPos
                >= selected_model->text_width * selected_model->text_height) {
            memmove(bws, bws + selected_model->text_width,
                    selected_model->text_width * selected_model->text_height
                            - selected_model->text_width);
            memset(
                    bws
                            + selected_model->text_width
                                    * selected_model->text_height
                            - selected_model->text_width, ' ',
                    selected_model->text_width);
            cursorPos -= selected_model->text_width;
        }
        break;
    default:
        if (cursorPos
                >= selected_model->text_width * selected_model->text_height) {
            memmove(bws, bws + selected_model->text_width,
                    selected_model->text_width * selected_model->text_height
                            - selected_model->text_width);
            memset(
                    bws
                            + selected_model->text_width
                                    * selected_model->text_height
                            - selected_model->text_width, ' ',
                    selected_model->text_width);
            cursorPos -= selected_model->text_width;
            cursorPos /= selected_model->text_width;
            cursorPos *= selected_model->text_width;
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

/* TODO use type CURSOR TYPE - 8 bit for special platforms */
void gfx_setcursortype(int type) {
    if (type == _NOCURSOR) {
        bws[cursorPos] = cursorContent;
        update = 1;
    }
}

static int gfxInitialized;

void gfx_init() {
    int cnt, err;

    if (gfxInitialized)
        return;
    gfxInitialized = 1;

    scale = INITIAL_SCALE;
    emu_window_width = INITIAL_SCALE * selected_model->pixel_width;
    emu_window_height = INITIAL_SCALE * selected_model->pixel_height;
    bws = malloc(selected_model->text_width * selected_model->text_height);
    lineWidth=selected_model->pixel_width / 8;
    lines=selected_model->pixel_height;
    pixelRamSize=lineWidth*lines;
    pixelRam = malloc(pixelRamSize);

    colorRamSize=selected_model->text_width * selected_model->text_height;
    colorRam = malloc(colorRamSize);
    cutBuffer = malloc(
            selected_model->text_width * selected_model->text_height
                    + selected_model->text_height);

    for (cnt = 0;
            cnt < selected_model->text_width * selected_model->text_height;
            cnt++) {
        bws[cnt] = rand() & 0xff;
        colorRam[cnt] = rand() & 0xff;
    }
    for (cnt = 0;
            cnt < selected_model->pixel_width / 8 * selected_model->pixel_height;
            cnt++) {
        pixelRam[cnt] = rand() & 0xff;
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

