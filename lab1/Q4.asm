section .data
msg1 : db 'fd'
l1 : equ $-msg1
msg2 : db 'ld'
l2 : equ $-msg2

section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1
sum : resb 2

section .text
    global _start: 
    _start: 

    mov eax , 4
    mov ebx , 1
    mov ecx , msg1
    mov edx , l1
    int 80h

    mov eax , 3
    mov ebx , 0
    mov ecx , d1
    mov edx , 1
    int 80h
    
    mov eax , 3
    mov ebx , 0
    mov ecx , junk
    mov edx , 1
    iny 80h

    mov eax , 4
    mov ebx , 1
    mov ecx , msg2
    mov edx , l2
    int 80h

    mov eax , 3
    mov ebx , 0
    mov ecx , d2
    mov edx , 1
    int 80h

    

