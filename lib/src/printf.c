#include <stdio.h>

void printf(const char *fmt, ...)
{
    char c;
    while(c=*fmt)
    {
	putchar(c);
	fmt++;
    }
}