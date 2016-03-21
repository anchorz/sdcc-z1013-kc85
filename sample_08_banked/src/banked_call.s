  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
  .include "bank.inc"
	.globl banked_call
	.area _CODE
banked_call::
  pop hl
  ld e,(hl)
  inc hl
  ld d,(hl)
  inc hl
  ; 
  ; the bank will copied to BC register
  ;    add some extra code if you need
  ;
  ld c,(hl)
  inc hl
  ld b,(hl)
  inc hl
  ;
  ; return address will be corrected by the 
  ;   offset of the banked_call parameters
  push hl 
  ex de,hl
  jp (hl)
  ; 
  ; the return address of the caller will be used
  ;   modify return address in HL if needed
