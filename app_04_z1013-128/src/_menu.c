#include <stdio.h>
#include <string.h>
#include "menu.h"

typedef struct {
    unsigned int dest;
    unsigned int len;
    unsigned int start;
    char name[];
} MENU_RECORD;

MENU_ENTRY menuEntries[10];
unsigned char menuEntriesCount;

#ifndef __SDCC
#define __at(X)
#endif

static __at (0x8003) const char * startOfBootApplication;
static __at (0x8005) const char * destinationForBootApplication;
static __at (0x8007) const unsigned int lengthOfBootApplication;
static __at (0x8009) const char * startAddress;

void menuEntriesCreate() {
    const MENU_RECORD * menuEntry =
            (const MENU_RECORD *) (startOfBootApplication
                    + lengthOfBootApplication);
    menuEntriesCount=0;
    do {
        //bug!
        //menuEntries[menuEntriesCount].name = menuEntry->name;
        MENU_ENTRY *p=&menuEntries[menuEntriesCount];
        p->len = menuEntry->len;
        p->name = menuEntry->name;
        p->dst = menuEntry->dest;
        p->src =
                (unsigned int) ((const char *) menuEntry)
                        + strlen(menuEntry->name) + sizeof(MENU_RECORD) + 1;
        p->start = menuEntry->start;
        menuEntry = (const MENU_RECORD *) (menuEntries[menuEntriesCount].src
                + menuEntry->len);
        menuEntriesCount++;
    } while (menuEntry->dest != 0);
    menuEntries[menuEntriesCount].name = "..Exit";
    menuEntriesCount++;
}
