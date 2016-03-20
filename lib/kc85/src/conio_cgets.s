; functions for conio.h

; first parameter LSB on SP+2
; first parameter MSB on SP+3
; 2nd   parameter LSB on SP+4
; 2nd   parameter MSB on SP+5
; return values on L or HL

    .include 'caos.inc'



;; cgets - Reads a string directly from the console.
; hl + 0 = max length
; hl + 1 = actual length
; hl + 2 = content
; hl + max length + 1 = zero termination
;.globl _cgets
_cgets::
    ; save x cursor position
    ld  a, (CURSO_COL)  ; c = x position
    ld  c, a
    
    ld  hl, #2
    add hl, sp
    ld  e, (hl)
    inc hl
    ld  d, (hl)
    ex  de, hl          ; hl = pointer auf max input
    
    ld  b, (hl)         ; b = max input
    inc b
    
    inc hl              ; hl = pointer auf count

    ; call input
    call PV1            ; de = pre source pointer
    .db FNINLIN

    jr c, getbrk$

    ; copy screen to buffer
    ; erhoehe DE um die (alte) Cursorposition
    ; de = de + c
    push hl

    xor a               ; a = 0
    ld  h, a            
    ld  l, c            ; hl = cursor pos

    add hl, de          ; hl = source pointer
    pop de              ; de = dest pointer - 1
    
    ; Anzahl bestimmen, Null suchen
    push de
    push hl
    ld  c, b
    ld  b, a            ; bc = max
    cpir
    ex  de, hl
    pop hl              ; hl = source pointer
    ex  de, hl
    ; Anzahl = hl - de
    sbc hl, de
    ex  de, hl          ; hl = source pointer
    ld  b, a
    ld  c, e            ; bc = anzahl
    pop de              ; de = dest pointer - 1
    ; Anzahl speichern
    ex  de, hl
    ld  a, c
    dec a
    ld  (hl), a
    ld  c, a
    inc hl              ; hl = dest pointer
    push hl
    ex  de, hl
    ; kopieren
    jr  z, nocopy$
    ldir
nocopy$:
    ; terminate with zero
    ex  de, hl
    ld  (hl), #0
    pop hl              ; return dest poiner
    ret
    
    ; got brk key, return zero
getbrk$:
    ld  (hl), #0
    inc hl

    ret
