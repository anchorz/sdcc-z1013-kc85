#include <stdio.h>

char *str = "text";
unsigned int w1;
unsigned int w2 = 0x6543;
const unsigned int w3 = 0x1234;
char c1 = 'T';
char c2 = '2';

int main() {
    printf("start:\n");
    printf("  initialized string str:%s\n", str);
    printf("  initialized word    w2:0x%04x\n", w2);
    printf("  initialized word    w3:0x%04x\n", w3);
    printf("  initialized char    c1:%c\n", c1);
    printf("  initialized char    c2:%c\n", c2);
    printf("uninitialized word    w1:0x%04x\n", w1);
    return 0;
}
