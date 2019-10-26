KBC_Data_Write:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    bp,
        mov     bp, sp

    ;----------------------
    ; save registers
    ;----------------------
        push    cx

        mov     cx, 0
.10L:
        ; check writable?
        in      al, 0x64
        test    al, 0x02
        loopnz  .10L

        cmp     cx, 0
        jz      .20E

        ; write
        mov     al, [bp + 4]
        out     0x60, al
.20E:
        mov     ax, cx

    ;----------------------
    ;   end of this function
    ;----------------------

        pop     cx

        mov     sp, bp
        pop     bp
    ret


KBC_Data_Read:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    bp,
        mov     bp, sp

    ;----------------------
    ; save registers
    ;----------------------
        push    cx
        push    di

        mov     cx, 0
.10L:
        ; check writable?
        in      al, 0x64
        test    al, 0x01    ; readbale?
        loopz  .10L

        cmp     cx, 0
        jz      .20E

        mov     ah, 0x00
        in      al, 0x60    ; get data

        mov     di, [bp + 4]
        mov     [di + 0], ax
.20E:
        mov     ax, cx

    ;----------------------
    ;   end of this function
    ;----------------------

        pop     di
        pop     cx

        mov     sp, bp
        pop     bp
    ret


KBC_Cmd_Write:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    bp,
        mov     bp, sp

    ;----------------------
    ; save registers
    ;----------------------
        push    cx

        mov     cx, 0
.10L:
        ; check writable?
        in      al, 0x64
        test    al, 0x02
        loopnz  .10L

        cmp     cx, 0
        jz      .20E

        ; write
        mov     al, [bp + 4]
        out     0x64, al    ; write command (on the other hand, 0x60 mean data)
.20E:
        mov     ax, cx

    ;----------------------
    ;   end of this function
    ;----------------------

        pop     cx

        mov     sp, bp
        pop     bp
    ret