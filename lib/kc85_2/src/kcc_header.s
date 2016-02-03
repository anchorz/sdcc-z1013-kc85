; specific header to automatic generate KCC format 
; (which is used by simulator, disk, tape, USB, etc...)

    .area   _KCC_HEADER (abs)

    .org 0x180          ; = 0x200 - 0x80 (header size)

    .ascii '        '   ; name (placeholder 8 chars)
    .ascii 'KCC'        ; extension
    .ds 5               ; reserved
    .db 0x03            ; 0x02 = load, 0x03 = autostart
    .dw s__CODE         ; load address
    .dw s__STACK        ; end address + 1
    .dw init            ; start address
