#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <keys.h>
#include "menu.h"

extern const DIRECTORY const dir; 

#define MENU_W 24
#define MENU_X ((SCR_WIDTH-MENU_W-1)/2)
#define MENU_Y 5
#define MENU_H 5

void draw_main_menu() {
    char idx = MENU_Y + 1;

    for (int i = 0; i < dir.menuEntriesCount; i++, idx += 2) {
        gotoxy(MENU_X + 4, idx);
        cputs(dir.menuEntries[i].name);
    }
}

char active_item;
char first_visible_item;
char cnt;

#define PROGRESS_BAR
#ifdef PROGRESS_BAR
#define PROGRESS_BAR_W 2
#endif

const char * const bottomLines[] = { "\xeb","\xea","\xe9","\xe8" };
const char * const topLines[] = { "\xe8","\xe7","\xe6","\xe5" };

void paint()
{
    char id=first_visible_item;
    const ENTRY *ptr=dir.menuEntries;
    unsigned char y=0;
    
 //   clrscr();
    
    ptr+=first_visible_item;
    while (y<MENU_H*2)
    {
        gotoxy(MENU_X+1,y+MENU_Y+1);
        if (active_item==id)
        {
            cputs("->");
        } else
        {
            cputs("  ");
        }
        gotoxy(MENU_X+4,y+MENU_Y+1);
        cputs(ptr->name);
        if (active_item==id)
        {
            cputs(" <-");
        } else
        {
            cputs("   ");
        }
        ptr+=1;
        id++;
        y+=2;
    }

    id=0;
    {
       //Annahme: line wird immer in 4er Schritten hochgezählt
       //TODO lines ist nicht konstant, der Scrollbar muss immer "von item-line" "bis-item-line" gezeichnet werden 
       unsigned char lines=MENU_H*8-4;
       unsigned char firstLine=(first_visible_item*(MENU_H*8-4))/dir.menuEntriesCount;
       unsigned char visibleLines=(MENU_H*(MENU_H*8-4))/dir.menuEntriesCount;
       unsigned char line=0;
       while (id<MENU_H*2-1)
       {
          gotoxy(MENU_X+MENU_W,MENU_Y+1+id);
          if (line==(firstLine&0xfc) )
          {
            int ofs=firstLine-line;
            cputs(topLines[ofs]);
          }
          else if (line==((firstLine+visibleLines-1)&0xfc) )
          {
            int ofs=firstLine+visibleLines-line-1;
            cputs(bottomLines[ofs]);
          }
          else if (line>=(firstLine|0x03) && line<((firstLine+visibleLines-1)&0xfc) )
            cputs("\xe8");
          else
            cputs(" ");
          id++;
          line+=4;
    }
    gotoxy(0,20);
    printf("to=%d(%d) vis=%d(%d) at=%d(%d)",dir.menuEntriesCount,lines,MENU_H,visibleLines,first_visible_item,firstLine);
    }
}

unsigned char handle_main_menu() 
{
    char c;

    for (;;) {
        c = getch();
        if (c == VK_DOWN) {
            if (active_item<dir.menuEntriesCount-1)
               active_item++;
            
            if (active_item==first_visible_item+MENU_H && active_item<dir.menuEntriesCount)
            {
              first_visible_item++;
            }
        }
        if (c == VK_UP) {
            if (active_item>0)
            active_item--;
     
            if (active_item==first_visible_item-1 && first_visible_item>0)
            {
              first_visible_item--;
            }
        }
        if (c == VK_ENTER) {
            break;
        }
        paint();
    }
    return 0;
}

unsigned char handle_main_menu2() {
    char c;

    for (;;) {
        gotoxy(MENU_X + 1, active_item * 2 + MENU_Y + 1);
        cputs("->");
        gotoxy(MENU_X + MENU_W - 1 - PROGRESS_BAR_W, active_item * 2 + 1 + MENU_Y);
        cputs("<-");
        c = getch();
        paint();
        if (c == VK_DOWN) {
            gotoxy(MENU_X + 1, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            gotoxy(MENU_X + MENU_W - 1- PROGRESS_BAR_W, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            active_item++;
            if (active_item >= dir.menuEntriesCount)
                active_item = 0;
        } else if (c == VK_UP) {
            gotoxy(MENU_X + 1, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            gotoxy(MENU_X + MENU_W - 1- PROGRESS_BAR_W, active_item * 2 + 1 + MENU_Y);
            cputs("  ");
            if (active_item == 0)
                active_item = dir.menuEntriesCount;
            active_item--;
        }
        if (c == VK_ENTER) {
            break;
        }
        if (c == VK_ESCAPE) {
            return dir.menuEntriesCount - 1;
        }
        if (c == VK_CTRL_C) {
            return dir.menuEntriesCount - 1;
        }
    }
    //printf("%d ",active_item);
    return active_item;
}

void execute_item(char item) {
item=item;
//    execute(menuEntries[item].src, menuEntries[item].dst, menuEntries[item].len,
//            menuEntries[item].start);
}

extern void win_msgbox(unsigned char x, unsigned char y, unsigned char w,
        unsigned char h)
__z88dk_callee;

int main() {

    char item;

    clrscr();

    do {
        gotoxy((SCR_WIDTH - 22) / 2, MENU_Y - 2);
        cputs("Z1013-128 VORFUEHRMODUS");
        win_msgbox(MENU_X, MENU_Y, MENU_W, 2 * MENU_H - 1);
        //draw_main_menu();
        paint();
        item = handle_main_menu();
        if (item == dir.menuEntriesCount - 1)
            break;
        else
            execute_item(item);
    } while (item != dir.menuEntriesCount - 1);

    __asm__("jp 0xf000");
    return 0;
}
