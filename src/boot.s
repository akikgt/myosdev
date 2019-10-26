        BOOT_LOAD       equ     0x7c00
        ORG         BOOT_LOAD
entry:
        jmp     ipl

        ; BPB (BIOS Parameter Block)
        times   90 - ($ -$$) db 0x90


        ;--------------------
        ; IPL (Initial Program Loader)
        ;--------------------
ipl:
        cli     ; forbid interupt

        mov     ax, 0x0000
        mov     ds, ax
        mov     es, ax
        mov     ss, ax
        mov     sp, BOOT_LOAD

        sti     ; permit interupt

        mov     [BOOT.DRIVE], dl    ;save boot drive. BIOS saves drive num to dl

        ;--------------------
        ; loading end 
        ;--------------------
        jmp     $
ALIGN 2, db 0
BOOT:
.DRIVE:         dw  0       ; drive number

; End of first 512bytes
        times 510 - ($ - $$) db 0x00
        db  0x55, 0xAA