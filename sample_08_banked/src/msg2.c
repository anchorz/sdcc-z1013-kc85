#include <stdio.h>

#pragma bank 2

void msg2() __banked
{
  printf("this is message 2\n");
}
