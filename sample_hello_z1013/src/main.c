#include <stdio.h>
#include <z1013.h>

//The _naked function modifier attribute prevents the compiler from generating prologue and epilogue code 
// This means that the user is entirely responsible for such things as saving any registers that may need to be preserved,
// generating the return instruction at the end, etc. 
// Practically, this means that the contents of the function must be written in inline assembler. 
// This is particularly useful for interrupt functions.
void naked_foo() __naked
{
  __asm__(" ret");
}

//list of keywords in SDCC.lex
// use --std-sdcc99 flag to enable c99 extensions
void __inline OUTCH2(unsigned char c)
{
  OUTCH(c);
}

void main()  {
  unsigned char c;

  PRST7("ffHello World!\r<press any key>\r");
  c=INCH();
  OUTCH2(c);
}
