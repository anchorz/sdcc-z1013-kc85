#include <stdio.h>

char *str = "text";
unsigned char w1;
unsigned int w2 = 0x6543;
const unsigned int w3 = 0x1234;
char c1 = 'T';
char c2 = '2';
float f=5.6f;

int main() {
    printf("  initialized string str:%s\n", str);
    printf("  initialized word    w2:0x%04x\n", w2);
    printf("  initialized word    w3:0x%04x\n", w3);
    printf("  initialized char    c1:%c\n", c1);
    printf("  initialized char    c2:%c\n", c2);
    printf("uninitialized char    w1:0x%02x\n", w1);
    printf("  initialized float   f :%f\n", f);
    return 0;
}
