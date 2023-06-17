
        format PE GUI
start:
        ;int3

        mov     edx,1234227Eh
        push    edx
        call    ShowHex

        push    0
        call    [ExitProcess]

; STD Calling Convention
ShowHex:
        push    ebp
        mov     ebp,esp
        sub     esp,12
       ; eax, ecx, edx - may be destroyed
                  ; [ebp-12] - local area
                  ; [ebp] - stored ebp
                  ; [ebp+4] Return Address

        mov     edx,[ebp+8]
        push    ebx

        lea     ebx,[ebp-12]
        mov     ecx,28
process:
        mov     eax,edx
        shr     eax,cl
        and     eax,0fh
        mov     al,[digits+eax]
        mov     [ebx],al
        add     ebx,1
        sub     ecx,4
        jnc     process

        pop     ebx

        lea     ecx,[ebp-12]

        xor     eax,eax
        push    eax
        push    ecx
        push    ecx
        push    eax
        call    [MessageBox]

        leave
        ret     4

section 'example' data readable writable

digits db '0123456789ABCDEF'

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
