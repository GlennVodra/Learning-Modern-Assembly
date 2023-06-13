
        format PE
start:
        int3
        mov     eax,11111111h
        mov     al,3
        mov     ah,al
        mov     ah,[start]