#include <stdio.h>
#include <string.h>
#include "menu.h"


const ENTRY menuEntries[] = { 
  { "0-KC-BASIC......",1,2,3,4,5},
  { "1-3K+CRASH      ",1,2,3,4,5 },
  { "2-JUMPING-JACK  ",1,2,3,4,5},
  { "3-MINEFIELD     ",1,2,3,4,5 },
  { "4-KC-BASIC      ",1,2,3,4,5},
  { "5-3K+CRASH      ",1,2,3,4,5 },
  { "6-JUMPING-JACK  ",1,2,3,4,5},
  { "7-MINEFIELD     ",1,2,3,4,5 },
  { "...exit         ",1,2,3,4,5 },
};

const unsigned char menuEntriesCount=sizeof(menuEntries)/sizeof(ENTRY);

