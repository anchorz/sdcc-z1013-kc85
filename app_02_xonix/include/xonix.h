/*
 schaltet zwischen der Grafikdarstellung und der internen Darstellung hin und her

 Hilfreich beim Debuggen
 */
extern void toggle();
extern unsigned char get_input();
extern void title_screen();

extern unsigned char field[];

/* 
 Bytecodes und deren Farbkombination
 */
#define FIELD_EMPTY 0x00
#define COLOR_EMPTY (COLOR_DEFAULT)

#define FIELD_FULL 0x01
#define COLOR_FULL (COLOR_FG_GREEN|COLOR_BG_BLUE)

#define FIELD_CLAIMING 0x02
#define COLOR_CLAIMING (COLOR_DEFAULT)

#define FIELD_FULL_MAN 0x03
#define COLOR_FULL_MAN (COLOR_FG_GREEN|COLOR_BG_BLUE)

#define FIELD_FULL_T1 0x04
#define FIELD_FULL_B1 (FIELD_FULL_T1+7)
#define FIELD_FULL_L1 (FIELD_FULL_B1+7)
#define FIELD_FULL_R1 (FIELD_FULL_L1+7)

#define FIELD_CLAIMING_MAN (0x88)
#define FCLAIM_L1  (FIELD_CLAIMING_MAN+1)
#define FCLAIM_R1  (FCLAIM_L1+7)
/* 
 Annahmen für die Bildschirmaufteilung. Es wäre aber besser man holt sich die Informationen zur Laufzeit,
 da die Werte je nach Grafik- oder Textmodus anders ausfallen können.
 */

#ifdef __Z1013__
#define SCR_WIDTH 32
#define SCR_HEIGHT 32
#define SCR_PTR ((unsigned char *)0xec00)

#elif defined(__Z9001__)
#define SCR_WIDTH 40
#define SCR_HEIGHT 24
#define SCR_PTR ((unsigned char *)0xec00)

#elif defined(__KC85__)
#define SCR_WIDTH 40
#define SCR_HEIGHT 32
#define SCR_PTR ((unsigned char *)0)

#else
#define SCR_WIDTH 40
#define SCR_HEIGHT 24
extern unsigned char *pixelRam;
#define SCR_PTR (pixelRam)
#endif

#define COLOR_BW (COLOR_FG_YELLOW|COLOR_BG_GREEN)

#define CURSOR_LEFT 0x08
#define CURSOR_RIGHT 0x09
#define CURSOR_DOWN 0x0a
#define CURSOR_UP 0x0b

#define VK_ENTER 0x0d

