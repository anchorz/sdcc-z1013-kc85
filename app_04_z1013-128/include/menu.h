typedef struct {
    char name[17];
    unsigned char bankStart;
    unsigned int  bankOffset;
    unsigned int  bankLength;
    unsigned int  destAddr;
    unsigned int  destStart;
} ENTRY;

extern const unsigned char menuEntriesCount;
extern const ENTRY menuEntries[];

