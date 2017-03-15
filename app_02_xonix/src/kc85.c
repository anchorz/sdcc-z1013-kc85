//KRT-Routinen für KC85/3 und KC85/4

int dummy;

#ifdef __KC85__

void krt_gotoxy(unsigned int x, unsigned int y) __z88dk_callee
{
    __asm
        pop hl
        pop de  ; x
        ex (sp),hl ; y
        ld  a,l
        rlca
        rlca
        rlca  ; y*8
        ld h,a
        ld l,e
        ld (#_krt_cursor),hl
        ret
    __endasm;
}

void krt_textcolor( unsigned int color) __z88dk_callee
{
    __asm
        pop hl
        ex (sp),hl
    __endasm;
}

void krt_init() __z88dk_callee
{
    __asm
        call _krt_font_init
        ld h,#0
        ld (#_krt_cursor),hl

        ret
        _krt_save_sp::
                .ds 2
        _krt_cursor::
                .ds 2
        _krt_color::
                .ds 1
__endasm;
}

void krt_off() __z88dk_callee
{
}

void krt_putchar(unsigned char *ptr, unsigned int c, unsigned int color) __z88dk_callee
{
    __asm
    ; ptr is an int value H-Y value L-X value
    pop iy ; return
    pop de ; ptr
    pop hl ; c
    ex (sp),iy ; iyl color
    ld h,#0
    add hl,hl
    add hl,hl
    add hl,hl
    ld bc,#_krt_font
    add hl,bc
    push    hl
    ld      l,e
    ld      h,d
    ;ld      a,e
    ;cp      #0x28
    ;jr      c,no_correction$
    ;sub     #0x28
    ;ld      l,a
    ;ld      a,#0x08
    ;add     h
    ;ld      h,a
no_correction$:
    call    _fast_video_address
    ld      e,l
    ld      d,h
    ;ld      b,#0
    ;ld      c,#0x80 kc85/3
    pop     hl
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi


    ret

_fast_video_address:
           ld      a,l
           ld      l,h
           or      #0x80
           ld      h,a
           ret

    __endasm;
}

void krt_clrscr(unsigned int pixel, unsigned int color) __z88dk_callee
{
    __asm
    pop hl
    pop de
    ex (sp),hl

    ld (#_krt_save_sp),sp
    di
    ld h,e
    ld a,e
    rlca
    ld l,a
    ld  sp,#0x8000+(320*32)

    ld  c,#5
part$:
    ld  b,#0x80
next$:
    push hl
    push hl
    push hl
    push hl

    push hl
    push hl
    push hl
    push hl

    djnz next$
    dec c
    jr  nz,part$
    ei
    ld sp,(#_krt_save_sp)
    __endasm;
}

void krt_clear_textarea(unsigned int x, unsigned int y, unsigned int width, unsigned int height) __z88dk_callee
{
    __asm
        ld  iy,#2
        add iy,sp
xL = 0
xH = 1
yL = 2
yH = 3
wL = 4
wH = 5
Lh = 6

;        ld      c,wL(iy)
next_column$:
        ld      a,yL(iy)
        rlca
        rlca
        rlca  ; y*8

        ld      b,Lh(iy)
        ld      h,a
        ld      l,xL(iy)
        call    _fast_video_address
        xor     a,a

down$:
        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl

        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl
        ld      (hl),a
        inc     hl
        djnz    down$
        inc     xL(iy)
        dec     wL(iy)
        jr      nz,next_column$

    pop hl
    pop de
    pop bc
    pop af
    ex (sp),hl
    __endasm;
}

#endif
