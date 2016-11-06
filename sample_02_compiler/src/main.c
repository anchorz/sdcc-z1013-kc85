// sdcc sample for keywords __naked and inline

#include <stdio.h>

#ifndef __SDCC
#define __z88dk_fastcall
#define __z88dk_callee
#define __naked
#define inline
#endif

// The __naked function modifier attribute prevents the compiler from generating prologue and epilogue code
// the user is entirely responsible for such things as saving any registers that may need to be preserved,
// generating the return instruction at the end, etc.
// Practically, this means that the contents of the function must be written in inline assembler.
// This is particularly useful for interrupt functions.
// __naked keyword is not supported by gcc cross compiler environment
// for compatibility reasons and testing you may provide a plain c implementation
void naked_foo() __naked {
    __asm__("ret");
}

// use --std-sdcc99 flag to enable c99 extensions
void inline OUTCH(char c) {
    putchar(c);
}

void put_char_int(int c) __z88dk_fastcall
{
    putchar(c);
}

void OUTSTR_CALLEE(int c1, int c2, int c3) __z88dk_callee
{
#ifdef __SDCC
    __asm__("pop iy"); //stack pointer
    __asm__("pop hl");
    __asm__("call _put_char_int");
    __asm__("pop hl");
    __asm__("call _put_char_int");
    __asm__("pop hl");
    __asm__("call _put_char_int");
    __asm__("push iy");
#else
    put_char_int(c1);
    put_char_int(c2);
    put_char_int(c3);
#endif
}

void OUTSTR(int c1, int c2, int c3) {
    put_char_int(c1);
    put_char_int(c2);
    put_char_int(c3);
}

void OUTSTR_FAST(char *ptr) __z88dk_fastcall
{
    char c;

    while ((c = *ptr++)) {
        OUTCH(c);
    }
}

int main() {
    OUTSTR_FAST("compiler demo\n");
    OUTSTR_FAST("check .c and .lst for effects;");
    OUTSTR_CALLEE('1', '0', '9');
    OUTSTR('1', '0', '9');
    OUTCH('a');
    return 0;
}

