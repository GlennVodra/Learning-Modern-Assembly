
        format PE GUI
start:
        ;int3
        push    3
        push    example

        call    subrutine

        push    0
        push    example
        push    example
        push    0
        call    [MessageBox]

        push    0
        call    [ExitProcess]

; STD Calling Convention
subrutine:
        enter   8,0 ; Does next 3 instructions
       ; eax, ecx, edx - may be destroyed
       ; push    ebp
       ; mov     ebp,esp
       ; sub     esp,4 ; Reserve extra space
                  ; [ebp-4] - local var
                  ; [ebp] - stored ebp
                  ; [ebp+4] Return Address
        mov     dword [ebp-8],1234h

        mov     edx,[ebp+8]
        mov     ecx,[ebp+12]

lowercase:
        add     byte [edx],20h
        inc     edx
        loop    lowercase

        leave
       ; mov     esp,ebp
       ; pop     ebp
        ret     8

section 'example' data readable writable

example:
        db       41h,42h,43h,0 ;  Data byte


section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA user_name,RVA user_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dd RVA _ExitProcess ; Data Double Word
    dd 0
  user_table:
    MessageBox dd RVA _MessageBoxA
    dd 0

  kernel_name db 'KERNEL32.DLL',0
  user_name db 'USER32.DLL',0

  _ExitProcess dw 0
    db 'ExitProcess',0
  _MessageBoxA dw 0
    db 'MessageBoxA',0
