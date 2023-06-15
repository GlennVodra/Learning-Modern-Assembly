
        format PE GUI
start:
        ;int3
        push    example

        call    ToLowerCase

        push    0
        push    example
        push    example
        push    0
        call    [MessageBox]

        push    0
        call    [ExitProcess]

; STD Calling Convention
ToLowerCase:
        push    ebp
        mov     ebp,esp

       ; eax, ecx, edx - may be destroyed
                  ; [ebp] - stored ebp
                  ; [ebp+4] Return Address

        mov     edx,[ebp+8]

lower:
        mov     al,[edx]
        cmp     al,'A'
        jb      nextChar
        cmp     al,'Z'
        ja      nextChar
        add     byte [edx],20h

nextChar:
        inc     edx
        cmp     al,0
        jne     lower

        leave
        ret     4

section 'example' data readable writable

example:
        db       '0BC',0 ;  Data byte


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
