static int conioInitialized;

void clrscr() {
    if (!conioInitialized)
    {
        gfx_init();
        conioInitialized=1;
    }
    gfx_putchar(0x0c);
}

void cputs(const char *str) {

    char c;
    if (!conioInitialized)
    {
        gfx_init();
        conioInitialized=1;
    }
    while (c = *str++) {
        gfx_putchar(c);
    }
}
