// sdcc sample for keywords __naked and inline

#include <stdio.h>

// The __naked function modifier attribute prevents the compiler from generating prologue and epilogue code
// the user is entirely responsible for such things as saving any registers that may need to be preserved,
// generating the return instruction at the end, etc.
// Practically, this means that the contents of the function must be written in inline assembler.
// This is particularly useful for interrupt functions.

// __naked keyword is not supported by gcc cross compiler environment
// for compatibility reasons and testing you may provide a plain c implementation
#ifndef __GNUC__
void naked_foo() __naked {
    __asm__("ret");
}
#else
void naked_foo() {
}

#define inline
#endif
// use --std-sdcc99 flag to enable c99 extensions
void inline OUTCH(unsigned char c)
{
    putchar(c);
}

void main() {
    OUTCH('a');
}
