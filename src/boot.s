        BOOT_LOAD       equ     0x7c00
        ORG         BOOT_LOAD
;************************************************************
;       MACRO
;************************************************************
; %include    "include/macros.s"

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

        push    word 'A'
        call    putc
        add     sp, 2
        push    word 'B'
        call    putc
        add     sp, 2
        push    word 'C'
        call    putc
        add     sp, 2

        ;--------------------
        ; loading end 
        ;--------------------
        jmp     $
ALIGN 2, db 0
BOOT:
.DRIVE:         dw  0       ; drive number

;************************************************************
;       Modules
;************************************************************
%include    "src/modules/real/putc.s"

; End of first 512bytes
        times 510 - ($ - $$) db 0x00
        db  0x55, 0xAA