
        format PE
start:
        int3
        mov     ebx,example
        mov     ecx,3

loop1:
        call    subrutine
        loop    loop1

subrutine:
        add     byte [ebx],20h
        inc     ebx
        ret

section 'example' data readable writable

example:
        db       41h,42h,43h
