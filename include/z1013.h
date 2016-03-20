#define PRST7(X) \
  __asm__("rst 0x20"); \
  __asm__(".db 2 ;PRST7"); \
  __asm__(".ascis "#X);

extern void OUTCH(unsigned char);
extern unsigned char INCH();

