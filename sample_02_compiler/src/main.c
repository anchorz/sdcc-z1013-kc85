// sdcc sample for keywords __naked and inline

#include <stdio.h>

#ifndef __SDCC
#define __z88dk_fastcall
#define __z88dk_callee
#define __naked
#define __sfr char
#define __banked
#define __at(X) 
#define inline
#endif

/* 8-bit IO access */
__sfr __at(0x79) IoPort8;
__sfr __banked __at(0x123) IoPort16;
#ifdef __Z1013__
    __at (0xec00) unsigned char bws[1024];
#elif defined(__Z9001__)
    __at (0xec00) unsigned char bws[1024];
    __at (0xe800) unsigned char color[1024];
#elif defined(__KC85__)
    __at (0x8000) unsigned char bws[1024];
    __at (0xa800) unsigned char color[1024];
#elif defined(__A5105__)
    //unsafe dummy variable
    __at (0x9000) unsigned char bws[1024];
#elif defined(__GNUC__)
    unsigned char bws[1024];
#else
    #error undefined platform
#endif

/* not to run in any kind of trouble, that code can be checked via LST file only
 *
 */
unsigned char _test_io16(int s) __z88dk_fastcall
{
    switch (s)
    {
        case 0:
            IoPort8=0x01;
            break;
        case 1:
            IoPort16=0x01;
            break;
    }
    return bws[0];
}

/* test case for compiler option: --allow-unsafe-reads
 * the compiler may execute the expression (*p * 7) before the switch statement in order 
 * to avoid multiple code instances for that expression
 *
 * the programmer still may rely on the fact that *p is not read at all if s==0
 *   - still that is bad style in that case - test that assumption first or switch
 *     only if s!=0 - make the intentions more clear
 * 
 * In general I like the behaviour of the compiler to produce code more closer 
 * to the actual c source. The option is more benefitial when optimizing for size.
 * So it is good the sub term optimization is off by default. 
 */
unsigned char _test_premature_read(int s, int *p)
{
    switch(s)
    {
    case -1:
        return *p * 7 - 3;
    case 0:
        return 0;
    case 1:
        return *p * 7 + 3;
    default:
        return *p * 7;
    }
}

/* SDCC allows to specify preserved registers in function declarations, to enable further 
 * optimizations on calls to functions implemented in assembler. Example for the Z80 architecture
 * specifying that a function will preserve register pairs bc and iy
 *
 * may be not supported, but still it is referenced in the manual
 */
//void foo(void) __preserves_regs(b, c);


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

void OUTSTR_CALLEE(int c1, int c2, int c3) __z88dk_callee;
#ifndef __SDCC
void OUTSTR_CALLEE(int c1, int c2, int c3) __z88dk_callee
{
    put_char_int(c1);
    put_char_int(c2);
    put_char_int(c3);
}
#else
//assembler file einbinden
#endif

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
    bws[0]='A'; //works with GCC, result is only visible if GUI is linked
#if defined(__Z9001__) 
    color[0]=0x3f;
#endif
#if defined(__KC85__) 
    color[0]=0x1f;
#endif
    
    return 0;
}

