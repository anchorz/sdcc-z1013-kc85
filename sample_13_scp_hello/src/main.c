#include <scpx.h>

char buffer[10];
char *text="Zeichenkette\n\r$";

int main() {
    bdos(CPM_PRNT,(int)text);
    bios(JP_CONST,0,0);
    return 0;
}
