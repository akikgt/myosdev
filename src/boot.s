        BOOT_LOAD       equ     0x7c00
        ORG         BOOT_LOAD
;************************************************************
;       MACRO
;************************************************************
%include    "src/includes/macro.s"

;************************************************************
;       Entry Point
;************************************************************
entry:
        jmp     ipl

        ; BPB (BIOS Parameter Block)
        times   90 - ($ -$$) db 0x90


        ;--------------------
        ; IPL (Initial Program Loader)
        ;--------------------
ipl:
        cli     ; forbid interuption

        ; set up segment registers
        mov     ax, 0x0000
        mov     ds, ax
        mov     es, ax
        mov     ss, ax
        mov     sp, BOOT_LOAD

        sti     ; permit interuption

        mov     [BOOT.DRIVE], dl    ;save boot drive. BIOS saves drive num to dl

        ;--------------------
        ; display string
        ;--------------------
        cdecl   puts, .s0

        ;--------------------
        ; read next 512 bytes
        ;--------------------
        mov     ah, 0x02            ; read command
        mov     al, 1               ; number of sectors to be read
        mov     cx, 0x0002          ; cylinder / sector
        mov     dh, 0x00            ; head
        mov     dl, [BOOT.DRIVE]    ; drive number
        mov     bx, 0x7c00 + 512
        int     0x13 
.10Q:   jnc     .10E                ; if error, CF = true
.10T:   cdecl   puts, .e0       
        call    reboot
.10E:

        ;--------------------
        ; go to next stage
        ;--------------------
        jmp     stage_2

        ;--------------------
        ; data
        ;--------------------
.s0     db      "Booting...", 0x0A, 0x0D, 0
.e0     db      "Error:sector read", 0

ALIGN 2, db 0
BOOT:
.DRIVE:         dw  0       ; drive number

;************************************************************
;       Modules
;************************************************************
%include    "src/modules/real/puts.s"
%include    "src/modules/real/reboot.s"

; End of first 512bytes
        times 510 - ($ - $$) db 0x00
        db  0x55, 0xAA


;************************************************************
;       2nd booting stage
;************************************************************
stage_2:
        cdecl   puts, .s0

        jmp     $

.s0     db      "2nd stage...", 0x0A, 0x0D, 0

;************************************************************
;       padding( this file size is 8k bytes)
;************************************************************
        times(1024 * 8) - ($ - $$)      db  0      ; 8k bytes