reboot:
        ; display reboot message
        cdecl   puts, .s0

        ; wait for key input (entering space key)
.10L:
        mov     ah, 0x10
        int     0x16

        cmp     al, ' '
        jne     .10L

        ; print new line
        cdecl   puts, .s1

        ; reboot
        int     0x19

        ; strings data
.s0     db  0x0A, 0x0D, "Push SPACE key to reboot...", 0
.s1     db  0x0A, 0x0D, 0x0A, 0x0D, 0