#include <conio.h>
#include <z1013.h>

#define FALSE   (1 == 0)
#define TRUE    (1 == 1)

/*
    return values for joystick_get_*
    0001    joy 1 left
    0002    joy 1 right
    0004    joy 1 down
    0008    joy 1 up
    0010    joy 1 fire
    0100    joy 2 left
    0200    joy 2 right
    0400    joy 2 down
    0800    joy 2 up
    1000    joy 2 fire
*/

void joystick_initialize_practic_1_88()
{
    __asm__("ld a,#0xcf"); //bitwise io
    __asm__("out (0x1),a"); //PIOA-CONTROL
    __asm__("ld a,#0x1f"); //bit 0..4 input
    __asm__("out (0x1),a"); //PIOA-CONTROL
    __asm__("ld a,#0x00"); //JOYSTICK 1&2 - both active by default
    __asm__("out (0x0),a"); //PIOA-DATA
}

int joystick_get_practic_1_88() __naked
{
    __asm__("ld c,#0x1f"); //bitmask ...FOURL
    __asm__("ld a,#0x20"); //select JOYSTICK 2
    __asm__("out (0x0),a"); //PIOA-DATA
    __asm__("in a,(0x0)"); //PIOA-DATA
    __asm__("and c"); 
    __asm__("scf");
    __asm__("ld l,a");
    __asm__("ld h,a");
    __asm__("ret z"); 
    __asm__("cpl"); 
    __asm__("and c"); 
    __asm__("ld h,a"); 
    __asm__("ld a,#0x40"); //select JOYSTICK 1
    __asm__("out (0x0),a"); //PIOA-DATA
    __asm__("in a,(0x0)"); //PIOA-DATA
    __asm__("cpl"); 
    __asm__("and c"); 
    __asm__("ld l,a"); 
    __asm__("ret");
}


char in_pio_a() __naked
{
    __asm__("ld a,#0x00"); 
    __asm__("ld h,a"); 
    __asm__("in a,(0x00)"); //PIOA-DATA
    __asm__("ld l,a"); 
    __asm__("ret");
}


void joystick_initialize_jute_6_87()
{
    __asm__("ld a,#0xcf"); //mode 3, bitwise io
    __asm__("out (0x1),a"); //PIOA-CONTROL
    __asm__("ld a,#0xfe"); //bit 1..7 input
    __asm__("out (0x1),a"); //PIOA-CONTROL
}

int joystick_get_jute_6_87()
{
    // original no fire
    // but jkcemu use all bits as fire
    // bit 0 is sound out
    unsigned char value;
    unsigned char result;
    result = 0;
    value = in_pio_a();

    if(( value & 0x10) == 0x00) result += 0x04; // down
    if(( value & 0x20) == 0x00) result += 0x01; // left
    if(( value & 0x40) == 0x00) result += 0x02; // right
    if(( value & 0x80) == 0x00) result += 0x08; // up
    if(( value & 0xf0) == 0x00) result  = 0x10; // fire

    return result;
}


void joystick_initialize_practic_4_87()
{
    __asm__("ld a,#0xcf"); //mode 3, bitwise io
    __asm__("out (0x1),a"); //PIOA-CONTROL
    __asm__("ld a,#0xff"); //bit 0..7 input
    __asm__("out (0x1),a"); //PIOA-CONTROL
}

int joystick_get_practic_4_87()
{
    // all bits as fire
    // no sound out
    unsigned char value;
    int result1;
    int result2;
    result1 = 0;
    result2 = 0;
    value = in_pio_a();

    if(( value & 0x80) == 0x00) result1 += 0x02; // right
    if(( value & 0x40) == 0x00) result1 += 0x04; // down
    if(( value & 0x20) == 0x00) result1 += 0x01; // left
    if(( value & 0x10) == 0x00) result1 += 0x08; // up
    if(( value & 0xf0) == 0x00) result1  = 0x10; // fire

    if(( value & 0x08) == 0x00) result2 += 0x0200; // right
    if(( value & 0x04) == 0x00) result2 += 0x0400; // down
    if(( value & 0x02) == 0x00) result2 += 0x0100; // left
    if(( value & 0x01) == 0x00) result2 += 0x0800; // up
    if(( value & 0x0f) == 0x00) result2  = 0x1000; // fire

    return result1 + result2;
}


int joystick_get_erf_soft()
{
    // one joystick
    unsigned char value;
    unsigned char result;
    result = 0;
    value = in_pio_a();

    // 0 0 0 fire  up      down  right left   // ist practic 88
    // 0 0 0 fire  left    up    right down   // soll nach erf
    if(( value & 0x08) == 0x00) result += 0x01; // left
    if(( value & 0x02) == 0x00) result += 0x02; // right
    if(( value & 0x04) == 0x00) result += 0x08; // up
    if(( value & 0x01) == 0x00) result += 0x04; // down
    if(( value & 0x10) == 0x00) result += 0x10; // fire

    return result;
}


void clear_window(char x,char y,char w,char h) {
    for (;h--;) {
        char _w=w;
        gotoxy(x,y++);
        for (;_w--;) {
            cputs("\xc7");      
        }
    }
}

void copy_window(const char *src,char x,char y,char w,char h) {
    for (;h--;) {
        char _w=w;
        gotoxy(x,y++);
        for (;_w--;) {
          putch(*src++);      
        }
    }
}

void rahmen(char x,char y,char w, char h)
{

    char _w=w;
    h=h;
    gotoxy(x,y++);
    putch('\xa8');
    for (;_w--;) {
        putch('\xa0');
    }
    putch('\xa9');

    for (;h--;) {
        _w=w;
        gotoxy(x,y++);
        putch('\xa1');
        for (;_w--;) {
            putch(' ');
        }
        putch('\xa1');
    }
    gotoxy(x,y);
    putch('\xa7');
    _w=w;
    for (;_w--;) {
        putch('\xa0');
    }
    putch('\xaa');
}

const char tl[]="\xff\xff\x8e\xff\xff\x8f\x8e\xbf\x8e";
const char to[]="\x20\xbe\x8f\x20\xbe\xff\xff\x8f\x20\xff\xff\x20";
const char tr[]="\xbf\xff\xff\xbe\xff\xff\xbf\x8e\xbf";

void draw_top_left(char ox,char on) {
    if (on)         
        copy_window(tl,ox,1,3,3);
    else
        clear_window(ox,1,3,3);
}

void draw_up(char ox,char on) {
    if (on)
        copy_window(to,ox+4,1,4,3);
    else
        clear_window(ox+4,1,4,3);
}

void draw_top_right(char ox,char on)
{
    if (on)
        copy_window(tr,ox+9,1,3,3);
    else 
        clear_window(ox+9,1,3,3);
}

const char le[]="\x20\xbe\x20\xbe\xff\xff\xbf\xff\xff\x20\xbf\x20";
const char fi[]="\xbe\xff\xff\x8f\xff\x8e\xbf\xff\xff\x8f\xbe\xff\xbf\xff\xff\x8e";
const char ri[]="\x20\x8f\x20\xff\xff\x8f\xff\xff\x8e\x20\x8e\x20";

void draw_left(char ox,char on)
{
    if (on)
        copy_window(le,ox+0,5,3,4);
    else
        clear_window(ox+0,5,3,4);
}


void draw_fire(char ox,char on)
{
    if (on)
        copy_window(fi,ox+4,5,4,4);
    else
        clear_window(ox+4,5,4,4);
}

void draw_right(char ox,char on)
{
    if (on)
        copy_window(ri,ox+9,5,3,4);
    else
        clear_window(ox+9,5,3,4);
}


const char dr[]="\xbe\x8f\xbe\xbf\xff\xff\xbe\xff\xff";
const char dw[]="\x20\xff\xff\x20\xbf\xff\xff\x8e\x20\xbf\x8e\x20";
const char dl[]="\x8f\xbe\x8f\xff\xff\x8e\xff\xff\x8f";

void draw_down_left(char ox,char on) {
    if (on)
        copy_window(dl,ox+0,10,3,3);
    else
        clear_window(ox+0,10,3,3);
}

void draw_down(char ox,char on)
{
    char pos=4;
    if (on)
        copy_window(dw,ox+4,10,4,3);
    else
        clear_window(ox+4,10,4,3);
}


void draw_down_right(char ox,char on)
{
    if (on)
        copy_window(dr,ox+9,10,3,3);
    else 
        clear_window(ox+9,10,3,3);
}

enum { practic_1_88, jute_6_87, practic_4_87, erf_soft};

unsigned int ret;
char device;
unsigned char   mode      = practic_1_88;
char            value;
unsigned char   new_joy   = FALSE;

int main()
{
    while( 1)
    {
        clrscr();

        switch( mode)
        {
            case practic_1_88:  joystick_initialize_practic_1_88(); break;
            case jute_6_87:     joystick_initialize_jute_6_87();    break;
            case practic_4_87:  joystick_initialize_practic_4_87(); break;
            case erf_soft:      joystick_initialize_practic_1_88(); break;
        } // switch( mode)

        rahmen(0,0,12,12);
        rahmen(18,0,12,12);
        gotoxy(14,1);
        cputs("#1");
        gotoxy(14,2);
        cputs("<--");

        gotoxy(16,6);
        cputs("#2");
        gotoxy(15,7);
        cputs("-->");

        gotoxy(0,16);
        cputs("Beispiel fuer die Verwendung");
        gotoxy(0,17);
        switch( mode)
        {
            case practic_1_88:
            case practic_4_87:  cputs("zweier Joysticks nach"); break;
            case jute_6_87:
            case erf_soft:      cputs("eines Joysticks nach");  break;
        }
        gotoxy(0,18);
        switch( mode)
        {
            case practic_1_88:  cputs("practic 1/88."); break;
            case jute_6_87:     cputs("Ju+Te 6/87.");   break;
            case practic_4_87:  cputs("practic 4/87."); break;
            case erf_soft:      cputs("ERF-soft.");     break;
        }
        gotoxy(0,21);
        cputs("Bewege den oder die Joysticks"); 
        gotoxy(0,22);
        cputs("  und teste den Feuer-Knopf."); 

        gotoxy(0,25);
        cputs("Auswahl");
        gotoxy(0,27);
        cputs("1: practic 1/88");
        gotoxy(0,28);
        cputs("2: Ju+Te 6/87");
        gotoxy(0,29);
        cputs("3: practic 4/87");
        gotoxy(0,30);
        cputs("4: ERF-soft"); 

        while( !new_joy)
        {
            switch( mode)
            {
                case practic_1_88:  ret=joystick_get_practic_1_88();    break;
                case jute_6_87:     ret=joystick_get_jute_6_87();       break;
                case practic_4_87:  ret=joystick_get_practic_4_87();    break;
                case erf_soft:      ret=joystick_get_erf_soft();        break;
            } // switch( mode)
            device=ret&0x0f;

            gotoxy(0,14);
            cputs("Status: ");
            OUTHL(ret);

            draw_top_left(1,device==0x09);
            draw_up(1,device==0x08);
            draw_top_right(1,device==0x0a);

            draw_left(1,device==0x01);
            draw_fire(1,ret&0x0010);
            draw_right(1,device==0x02);

            draw_down_left(1,device==0x05);
            draw_down(1,device==0x04);
            draw_down_right(1,device==0x06);

            ret/=256;
            device=ret&0x0f;

            draw_top_left(19,device==0x09);
            draw_up(19,device==0x08);
            draw_top_right(19,device==0x0a);

            draw_left(19,device==0x01);
            draw_fire(19,ret&0x0010);
            draw_right(19,device==0x02);

            draw_down_left(19,device==0x05);
            draw_down(19,device==0x04);
            draw_down_right(19,device==0x06);
            
            if( kbhit())
            {
                value = getch();
                switch( value)
                {
                    case '1':
                        mode = practic_1_88;
                        new_joy = TRUE;
                        break;

                    case '2':
                        mode = jute_6_87;
                        new_joy = TRUE;
                        break;

                    case '3':
                        mode = practic_4_87;
                        new_joy = TRUE;
                        break;

                    case '4':
                        mode = erf_soft;
                        new_joy = TRUE;
                        break;
                } // switch( value)
            } // kbhit()
            
        } // while( not (new_joy))
        new_joy = FALSE;
    } // while( 1)
}
