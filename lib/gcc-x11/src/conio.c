void gfx_init();
void gfx_putchar(unsigned char c);
void gfx_setcursortype(int type);

void clrscr() {
    gfx_init();
    gfx_putchar(0x0c);
}

void cputs(const char *str) {

    char c;
    gfx_init();

    while ((c = *str++)) {
        gfx_putchar(c);
    }
}

void _setcursortype (int type)
{
    gfx_init();

    gfx_setcursortype(type);
}

