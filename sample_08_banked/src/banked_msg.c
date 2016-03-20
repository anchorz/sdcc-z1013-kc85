#include <stdio.h>

#pragma bank 1

void msg1(unsigned char *msg) __banked
{
  puts("this is message 1\r");
}
