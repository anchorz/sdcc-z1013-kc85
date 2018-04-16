; Definition of used I/O addresses:

GIDE    equ     40h             ; I/O base address

RTC     equ     GIDE+5h         ; I/O address of RTC chip

; Init the RTC for normal operation.
; If the RTC is battery backed, this is needed only for
; the first time the RTC is powered up!
	org 100h
	call RTCinit
	call RTCread
	rst 38h

RTCinit: ld	bc,0F00h+RTC	; access Ctl-Reg. F
	ld	a,5
	out	(c),a		; RTC Ctl-F: 24h mode, Reset
	dec	a
	out	(c),a		; release Reset
	dec	b
	dec	b		; access Ctl.-Reg. D
	xor	a
	out	(c),a		; RTC Ctl-D: No Hold, No Adjust
	ret


; Prepare for R/W access to the RTC. The hold bit is set,
; and the busy flag checked to see if accesses are allowed.

RTCwait: ld	bc,0D00h+RTC	; access Ctl-D
	ld	a,1
        out     (c),a           ; set Hold bit
        in      a,(c)
        bit     1,a             ; check Busy flag
	ret	z		; not busy: return
	xor	a
	out	(c),a		; reset Hold bit
	jr	RTCwait 	; go try again

; Read the current date & time from the RTC. The data is
; stored in memory in BCD format, using 6 bytes from seconds
; to year.

RTCread: call	RTCwait 	; check for RTC non-busy
	ld	hl,Time
	ld	b,0Bh		; start with year tens
RTCrd1: in	a,(c)		; read tens digit
	and	0Fh		; mask unused bits
        rlca
        rlca                
        rlca                
	rlca			; shift into upper digit
	ld	d,a		; then into d
	dec	b
	in	a,(c)		; read units digit
        and     0Fh             ; mask unused bits
	or	d		; combine with tens
	ld	(hl),a		; store BCD result
	inc	hl		; bump pointer
	dec	b
	jp	p,RTCrd1	; repeat until seconds done
	ld	b,0Dh
	xor	a
	out	(c),a		; reset Hold bit
	ret

; Set date & time of RTC according to RAM variables.

RTCset: call	RTCwait 	; check for RTC non-busy
	ld	hl,Time
	ld	b,0Bh		; start with year tens
RTCst1: ld	a,(hl)		; get BCD value
	rrca
        rrca
        rrca
        rrca
	and	0Fh		; use tens only
	out	(c),a		; write tens to RTC
	ld	a,(hl)		; get BCD value again
	and	0Fh		; use units only
        dec     b
	out	(c),a		; write units to RTC
	inc	hl		; bump pointer
	dec	b
	jp	p,RTCst1	; repeat until seconds done
	ld	b,0Dh
	xor	a
	out	(c),a		; reset Hold bit
        ret


Time:	defs	6		; RAM variables for date&time

	end
