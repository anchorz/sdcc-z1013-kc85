#include <stdio.h>
#include <z1013.h>

extern void msg1() __banked;
extern void msg2() __banked;

void main() {
  unsigned char c;
  //void (*foo)(unsigned char *msg) __banked=msg; 
  //banked1.asm contains a banked_call to the address of msg1
  //  beside that, the actual bank is missing and has to be added semi-automatic
  // call	banked_call
  // .dw	_msg1
  // .dw 0     ; PENDING: bank support
  msg1();
  msg2();
  printf("<press any key>\n");
  c=INCH();
  OUTCH(c);
}
