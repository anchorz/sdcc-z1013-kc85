; specific header to automatic generate KCC format 
; (which is used by simulator, disk, tape, USB, etc...)

	.module header
    .area   _HEADER (ABS)

	.dw s__CODE
	.dw start_of_stackframe
	.dw init

	.ascii 'sdcc80'
	.ascii 'C'
	.db 0xd3,0xd3,0xd3
	.ascii '                '


