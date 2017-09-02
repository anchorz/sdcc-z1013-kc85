typedef struct {
    const char * name;
    unsigned int  src;
    unsigned int dst;
    unsigned int start;
    unsigned int len;
} MENU_ENTRY;

extern unsigned char menuEntriesCount;
extern MENU_ENTRY menuEntries[10];
extern void menuEntriesCreate();
