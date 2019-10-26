memcpy:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    ebp,
        mov     ebp, esp

    ;----------------------
    ; save registers
    ;----------------------
        push    ecx
        push    esi
        push    edi

    ;----------------------
    ; copy bytes
    ;----------------------
        cld
        mov     edi, [ebp + 8]
        mov     esi, [ebp + 12]
        mov     ecx, [ebp + 16]

        rep movsb

        pop     edi
        pop     esi
        pop     ecx

        mov     esp, ebp
        pop     ebp

    ret

