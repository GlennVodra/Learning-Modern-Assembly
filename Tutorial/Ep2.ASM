
        format PE
start:
        int3
        mov     ebx,example
        mov     ecx,3
loop1:
        add     byte [ebx],20h
        inc     ebx
        dec     ecx
        jnz     loop1
        mov     al,0

section 'example' data readable writable

example:
        db       41h,42h,43h
