section .data 
nwl : db 10
l :equ $-nwl

section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1

section .text
    global _start: 
    _start :

    mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, junk
    mov edx, 1
    int 80h

    mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h

    

    mov eax, 1
    mov ebx, 0
    int 80h