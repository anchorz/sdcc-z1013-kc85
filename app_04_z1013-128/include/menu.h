typedef struct {
    char name[16]; //nicht null-terminiert!
    unsigned char typ; //C-executable
    unsigned char bankStart;
    unsigned int  bankOffset;
    unsigned int  length;
} ENTRY;

typedef struct {
    const unsigned char menuEntriesCount;
    const ENTRY menuEntries[];
} DIRECTORY;


