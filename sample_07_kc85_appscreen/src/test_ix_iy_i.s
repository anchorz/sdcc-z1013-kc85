
.globl _test_ix
_test_ix::
    push ix
    pop hl

    call 0xf003
    .db 0x1a

    push iy
    pop hl
    call 0xf003
    .db 0x1a

    ld a,i
    call 0xf003
    .db 0x1c
    call 0xf003
    .db 0x2c

    push ix
    push iy
    ld a, i
    push af

    ld ix, #0x5555
    ld iy, #0x4444
    ld a, #0x33
    ld i,a
    
    push ix
    pop hl

    call 0xf003
    .db 0x1a

    push iy
    pop hl
    call 0xf003
    .db 0x1a

    ld a,i
    call 0xf003
    .db 0x1c


    call 0xf003
    .db 0x2c

    ld a, #0x33
    ld i,a
    ld iy, #0x5555
    ld ix, #0x4444

    push ix
    pop hl

    call 0xf003
    .db 0x1a

    push iy
    pop hl
    call 0xf003
    .db 0x1a

    ld a,i
    call 0xf003
    .db 0x1c

    call 0xf003
    .db 0x2c

    pop af
    ld i,a
    pop iy
    pop ix
    
    push ix
    pop hl

    call 0xf003
    .db 0x1a

    push iy
    pop hl
    call 0xf003
    .db 0x1a

    ld a,i
    call 0xf003
    .db 0x1c
    call 0xf003
    .db 0x2c

    ret
