// debug & demonstrate .bss segment initialization int crt0
//   einfach nur mal main.s anschauen und sehen, ob ix auch wirklich nicht verwendet wird.
#include <stdio.h>

// vor der Ausgabe sollte die Variable erst einmal initialisert werden
// das sollte automatisch erfolgen, der initialisierungscode sollte dann in das _GSINIT segment
// 
//extern int lib_conio_version;

unsigned char var_c;
unsigned char var_d = 'B';
unsigned char var_c2;

// test --fomit-frame-pointer 
//   ix register should not be used by the compiler for this tests
int foo(int in) {
    int a, b, c, d;
    a = in;
    b = a;
    c = a;
    d = a + b;
    return in + in * 3 + a + b + c + d;
}

int main() {
    var_c = 'H';
    var_c2 = '2';
    printf("c=%c c2=%c b=%c foo=%04x\n", var_c, var_c2, var_d, foo(4));
    //printf("lib_conio_version=%04x\n", lib_conio_version);
    return 0;
}
