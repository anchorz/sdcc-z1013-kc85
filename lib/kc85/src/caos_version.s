        .module caos_version
        .include 'caos.inc'

_caos_version::
        ld      a,(0xE011) ; Beim ist KC85/4 hier immer BASIC-Menuewort
        cp      #0x7F   ; KC 85/4 ?
        jr      nz,caos_900
        ld      a,(CAOSNR)  ; Versionsnummer steht seit CAOS 4.1 immer hier
        ld      l,a
        ret
caos_900:
        ld      a,(0xF0B2)  ; HC90[0]-CAOS
        cp      #0x30
        jr      nz,caos_22	
        ld      l,#0x22
        ret
caos_22:
        ld      a,(0xF0B6)  ; HC-CAOS [2].2
        cp      #0x32
        jr      nz,caos_31
        ld      l,#0x22
        ret
caos_31:
        ld      l,#0x31
        ret