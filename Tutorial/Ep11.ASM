

        format PE64 GUI

start:
        int3

        sub     rsp,8+10*8

        mov     rcx,0123456789ABCDEFh
        call    ShowHex


        ;Fast call, rcx, rdx, r8, r9 - first 4 args
        mov     ecx,0
        call    [ExitProcess]


ShowHex:
        push    rbp
        mov     rbp,rsp
        sub     rsp,32+4*8
       ; rax, rcx, rdx, r8-r11 - may be destroyed
                  ; [rbp-32] - local area
                  ; [rbp] - stored rbp
                  ; [rbp+8] Return Address

        mov     rdx,rcx

        lea     r10,[rbp-32]
        mov     ecx,60
process:
        mov     rax,rdx
        shr     rax,cl
        and     eax,0fh
        mov     al,[digits+rax]
        mov     [r10],al
        inc     r10
        sub     ecx,4
        jnc     process
        mov     byte [r10],0

        xor     ecx,ecx
        lea     rdx,[rbp-32]
        mov     r8,rdx
        xor     r9d,r9d
        call    [MessageBox]

        leave
        ret


section 'example' data readable writable

digits db '0123456789ABCDEF',0

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA user_name,RVA user_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess ; Data Double Word
    dq 0
  user_table:
    MessageBox dq RVA _MessageBoxA
    dq 0

  kernel_name db 'KERNEL32.DLL',0
  user_name db 'USER32.DLL',0

  _ExitProcess dw 0
    db 'ExitProcess',0
  _MessageBoxA dw 0
    db 'MessageBoxA',0