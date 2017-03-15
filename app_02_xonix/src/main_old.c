#include <stdio.h>
#include <conio.h>
#include <z1013.h>

#define CHAR_HORIZONTAL_BAR 0xa0
#define CHAR_VERTICAL_BAR 0xa1
#define CHAR_CORNER_TOP_LEFT 0xa8
#define CHAR_CORNER_TOP_RIGHT 0xa9
#define CHAR_CORNER_BOTTOM_RIGHT 0xaa
#define CHAR_CORNER_BOTTOM_LEFT 0xa7
#define CHAR_MAN  0xc4

unsigned char lastInput;

void print()
{
    //cursoradresse ist 0x2b
    unsigned int *ptr=(unsigned int *)0x2b;
    *ptr=0xec00;
}

void border()
{
    unsigned char x; 

    ScreenPointer ptr=SCR_PTR;
    ptr+=SCR_WIDTH;

    SET_SCREEN(ptr++,CHAR_CORNER_TOP_LEFT);

    x=30;
    while (x)
    {
        SET_SCREEN(ptr,CHAR_HORIZONTAL_BAR);
        ptr++;
        x--;
    }
    SET_SCREEN(ptr++,CHAR_CORNER_TOP_RIGHT);
    SET_SCREEN(ptr,CHAR_VERTICAL_BAR);
    ptr+=SCR_WIDTH-1;
    x=SCR_HEIGHT-4;
    while(x)
    {
        SET_SCREEN(ptr,CHAR_VERTICAL_BAR);
        ptr++;
        SET_SCREEN(ptr,CHAR_VERTICAL_BAR);
        ptr+=SCR_WIDTH-1;
        x--;
    }
    SET_SCREEN(ptr++,CHAR_VERTICAL_BAR);
    SET_SCREEN(ptr++,CHAR_CORNER_BOTTOM_LEFT);
    x=30;
    while (x)
    {
        SET_SCREEN(ptr,CHAR_HORIZONTAL_BAR);
        ptr++;
        x--;
    }
    SET_SCREEN(ptr,CHAR_CORNER_BOTTOM_RIGHT);
}

signed char ex,ey;
signed char vx,vy;

unsigned char *scrPtr;

void DELAY()
{
#ifdef __SDCC__
__asm
    
    ld c,#0x80
m2:
    ld b,#0
m1: 
    djnz m1
    dec c
    jr nz,m2

__endasm;
#endif
}

#ifndef __SDCC__
    #define __naked
#endif

unsigned char quickKey() __naked
{
#ifdef __SDCC__
 __asm
    xor a,a
    ld (0x4),a
    call 0xfffa
    ld l,a
    ret

__endasm;
#endif
}

void ball_init()
{
   signed char bx=2,by=1;
   ex=0;ey=0;
   vx=16;vy=16;
   scrPtr=SCR_PTR+by*SCR_WIDTH+bx+SCR_WIDTH;
    *scrPtr=0x8c;
}

#define IS_FREE(PTR) (*PTR==' ' || *PTR=='a' || *PTR=='A')

void check_free(unsigned char *ptr)
{
    //OUTHX(*scrPtr);
    if (IS_FREE(ptr))
    {
        *scrPtr=0x8c;
    } else
    {
            //vx=-vx;
    }
}

void ball_move()
{
    unsigned char *oldScrPtr=scrPtr;
    signed char tx=ex,ty=ey;
    char flag=0;    

    print();

    ex+=vx;
    ey+=vy;

    OUTHX(ex);
    OUTHX(ey);

    if (vx<0)
    {
       if (ex<0)
       {
            ex+=0x80;
            scrPtr--; 
            flag=1;
       } 
    } else
    {
       //overflow test
       if (ex<0)
       {
            ex-=0x80;
            scrPtr++; 
            flag=1;
       }   
    }

    if (vy<0)
    {
       if (ey<0)
       {
            ey+=0x80;
            scrPtr-=SCR_WIDTH; 
            flag=1;
       } 
    } else
    {
       //overflow test
       if (ey<0)
       {
            ey-=0x80;
            scrPtr+=SCR_WIDTH; 
            flag=1;
       }   
    }

    /*OUTHX(130);
      t-=5;
    OUTHX(t-0x80);
    if (ex<0)
    {
       if (vx>0) {
            ex-=0x80;
            scrPtr++; 
        } else { 
            scrPtr--;
       }
       flag|=1;
    } 
    if (ey<0)
    {
       if (vy>0) {
            ey-=0x80;
            scrPtr+=SCR_WIDTH; 
        } else { 
            scrPtr-=SCR_WIDTH; 
        }
       flag|=2;
    }
*/
    if (flag)
    {
        if (IS_FREE(scrPtr))
        {
            *oldScrPtr='A';
            *scrPtr=0x8c;
        } else
        {
            switch(*scrPtr&0xf)
            {
                case 0:
                case 2:
                case 4:
                    vy=-vy;
                    break;
                case 1:
                case 3:
                case 5:
                    vx=-vx;
                    break;
                case 6:                
                case 7:
                case 8:
                case 9:
                case 0xa:
                    vy=-vy;
                    vx=-vx;
                    break;        
            }
           //*oldScrPtr='a';
            //*scrPtr=0x8c;
            //*oldScrPtr=' ';
            //*scrPtr=0x8c;
            scrPtr=oldScrPtr;
            ex=tx;
            ey=ty;
        }
    }
    DELAY();
}

ScreenPointer manPtr;

void man_set()
{
    ScreenPointer ptr=SCR_PTR;
    ptr=SCR_PTR+SCR_WIDTH;
    hidden_by_man=GET_SCREEN(ptr);
    SET_SCREEN(ptr,CHAR_MAN);
}

void man_remove()
{
   unsigned char *ptr=SCR_PTR+man_y*SCR_WIDTH+man_x+SCR_WIDTH;
   *ptr=hidden_by_man;
}

void man_init()
{
    man_set();
}


unsigned char mapRight[16]={0xa0,0xa3,0xa2,0xa3,  //a0..a3
                   0xa4,0xa6,0xa6,0xa7,  //a4..a7
                   0xa8,0xa4,0xa2,0xa0,   //a8..ab
                   0xa8,0xa0,0xa7,'f'    //ac..af
};

unsigned char mapLeft[16]={0xa0,0xa5,0xa2,0xa6,  //a0..a3
                  0xa4,0xa5,0xa6,0xa2,  //a4..a7
                  0xa4,0xa9,0xaa,0xa0,  //a8..ab
                  0xa9,0xa0,0xaa,'l'   //ac..af
                    };


unsigned char mapUp[16]={0xa2,0xa1,0xa2,0xa3,  //a0..a3
                0xa6,0xa5,0xa6,0xa7,  //a4..a7
                0xa3,0xa5,0xaa,0xaa,  //a8..ab
                0xa1,0xa7,0xa1,'a'   //ac..af
                    };

unsigned char mapDown[16]={0xa4,0xa1,0xa6,0xa3,  //a0..a3
                  0xa4,0xa5,0xa6,0xa3,  //a4..a7
                  0xa8,0xa9,0xa5,0xa9,  //a8..ab
                  0xa1,0xa8,0xa1,'c'   //ac..af
                    };




void man_right()
{
    if (man_x<SCR_WIDTH-1)
    {
        unsigned char *scrPtr;
        unsigned char before;
        man_remove();
        
        scrPtr=SCR_PTR+man_y*SCR_WIDTH+man_x+SCR_WIDTH;
        before=*scrPtr;
        *scrPtr=mapRight[before-0xa0];

        scrPtr++;          
        if (IS_FREE(scrPtr))
        {
            *scrPtr=0xab;
        } else
        {
            *scrPtr=mapLeft[*scrPtr-0xa0];
        }
        man_x++;
        man_set();
    }
}

void man_left()
{
    if (man_x>0)
    {
        unsigned char *scrPtr;
        unsigned char before;
        man_remove();
        
        scrPtr=SCR_PTR+man_y*SCR_WIDTH+man_x+SCR_WIDTH;
        before=*scrPtr;
        *scrPtr=mapLeft[before-0xa0];

        scrPtr--;          
        if (IS_FREE(scrPtr))
        {
            *scrPtr=0xad;
        } else
        {
            *scrPtr=mapRight[*scrPtr-0xa0];
        }
        man_x--;
        man_set();
    }
}

void man_down()
{
    if (man_y<SCR_HEIGHT-2)
    {
        unsigned char *scrPtr;
        unsigned char before;
        man_remove();
        
        scrPtr=SCR_PTR+man_y*SCR_WIDTH+man_x+SCR_WIDTH;
        before=*scrPtr;
        *scrPtr=mapDown[before-0xa0];

        scrPtr+=SCR_WIDTH;          
        if (IS_FREE(scrPtr))
        {
            *scrPtr=0xae;
        } else
        {
            *scrPtr=mapUp[*scrPtr-0xa0];
        }
        man_y++;
        man_set();
    }
}

void man_up()
{
    if (man_y>0)
    {
        unsigned char *scrPtr;
        unsigned char before;
        man_remove();
        
        scrPtr=SCR_PTR+man_y*SCR_WIDTH+man_x+SCR_WIDTH;
        before=*scrPtr;
        *scrPtr=mapUp[before-0xa0];

        scrPtr-=SCR_WIDTH;          
        if (IS_FREE(scrPtr))
        {
            *scrPtr=0xac;
        } else
        {
            *scrPtr=mapDown[*scrPtr-0xa0];
        }
        man_y--;
        man_set();
    }
}




int main()
{
    clrscr();
    _setcursortype (_NOCURSOR);
    border();
    man_init();



    return 0;

/*    
    ball_init();
    
    for(;;) 
    {
        ball_move();
        switch (quickKey() )
        {
            case 0x03:
            case 0x1b:
                return; 
                break;
            case 0x08:
                man_left();
                break;
            case 0x09:
                man_right();
                break;
            case 0x0a:
                man_down();
                break;
            case 0x0b:
                man_up();
                break;
            default:
                break;
        }
    }
*/
}

