#include <stdio.h>

#pragma bank 1

void msg1() __banked
{
  printf("this is message 1");
}
