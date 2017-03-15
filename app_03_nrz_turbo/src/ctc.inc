    CTC_INT_ENABLE      .equ 0x80
    CTC_INT_DISABLE     .equ 0x00

    CTC_MODE_COUNTER    .equ 0x40
    CTC_MODE_TIMER      .equ 0x00

    CTC_PRESCALE_256    .equ 0x20 ; timer mode only
    CTC_PRESCALE_16     .equ 0x00 ; timer mode only

    CTC_TRIGGER_EXT     .equ 0x08
    CTC_TRIGGER_NOW     .equ 0x00

    CTC_SET_COUNTER     .equ 0x04
    CTC_RESET           .equ 0x02
    CTC_CMD             .equ 0x01   
