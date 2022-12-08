section .data
msg1 :db 'Enter keystroke :',10
l1 : equ $-msg1
msg2 :db 'ON ',10
l2 : equ $-msg2
msg3 :db 'OFF ',10
l3 : equ $-msg3

section .bss
k : resb 1
l : resb 1
i : resb 1

section .text

global _start:
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    mov byte[i], 0
    mov byte[l], 0
    for:

       add byte[l], 1

    mov eax, 3
    mov ebx, 0
    mov ecx, k
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, k
    mov edx, 1
    int 80h

    mov al, byte[k]

    cmp al,'A'
    setnc bl
    cmp al,'Z'+1
    setc bh
    and bh, bl
    cmp bh, 0
    jne if

    else:
    ;add byte[i], 1
    jmp L

    if:
        add byte[i], 1
        ;add byte[l], 1

        L:
    cmp byte[k], 'A'
    setnc bl
    cmp byte[k], 'Z'+1
    setc bh
    and bl, bh
    cmp byte[k], 'a'
    setnc ah
    cmp byte[k], 'z'+1
    setc bh
    and ah, bh
    or bl, ah
    cmp bl, 1
    je for

    mov al, byte[l]
    sub al, 1
    cmp al, byte[i]
    je if1
    else1:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h
    jmp X

    if1:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h

    X:
    mov eax, 1
    mov ebx, 0
    int 80h
