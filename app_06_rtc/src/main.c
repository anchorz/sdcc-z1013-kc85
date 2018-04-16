#include <conio.h>
#include <delay.h>
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

int inkey() __naked
{
    __asm__("xor a"); 
    __asm__("ld (0x0004),a"); 
    __asm__("rst 0x20"); 
    __asm__(".db 0x04");
    __asm__("ld l,a");
    __asm__("ret");
}

unsigned char show_text;
unsigned char show_cnt;
unsigned char key;
unsigned int  *ptr=0xec00;
int main()
{
    clrscr();
    gotoxy(0,0);
    cputs("RTC Einstellungen");
    gotoxy(0,1);
    cputs("=================");
    
    gotoxy(2,3);
    cputs("A) GIDE mit RTC, PORT=040h+5");
    gotoxy(2,5);
    cputs("B) MP 04/90    , PORT=070h");
    gotoxy(2,6);
    cputs("     bzw. Practic 11/90");
    gotoxy(2,8);
    cputs("C) RTC initialisieren");
    gotoxy(2,10);
    cputs("D) RTC Zeit setzen");    
    
    gotoxy(0,12);
    cputs("AENDERN MIT A) ODER B)");
    gotoxy(3,14);
    cputs("START mit <ENTER>");
    
    rahmen((31-19)/2-1,14-1,19,1);
    gotoxy((31-19)/2,14);
    cputs("xxxx-xx-xx xx:xx:xx");

    mdelay(200);//Warte nach dem Kommando "J 100" noch ein bisschen
                //  nicht sofort wieder die Tastatur abfragen.
                //Manchmal in <ENTER> immernoch gedrückt.
    while(1) {
         //inkey() ist eine schlechte Wahl um eine Warteschleife zu programmieren
         //bei den Z1013 Versionen 2.02 und RB ist der Laufzeitunterschied, dank 
         //der verbesserten Tastatureingaberoutine, sehr groß. 
         //Also lieber 10x pro Sekunde abfragen und dann etwas warten
         if (key=inkey()) {
             if (key==0x0d) {
               break;
             }
             if (key=='A') {
               break;
             }
             if (key=='B') {
               break;
             }
         }
         if (show_cnt==0) {
          gotoxy(13,9);
             show_text=!show_text;
             show_text?cputs("<ENTER>"):cputs("       ");
             show_cnt=4;
         } else {
             show_cnt--;
         }
         mdelay(100);
    }
    gotoxy(0,16);
    return 0;
}
