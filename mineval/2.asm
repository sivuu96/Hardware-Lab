section .data
msg1 : db 'Sum='
l1 : equ $-msg1
msg2 : db 'Result='
l2 : equ $-msg2

section .bss

a : resb 1
b : resb 1
c : resb 1
junk : resb 1

section .text
	global _start:
	_start:
	
	mov eax, 3
	mov ebx, 0
	mov ecx, c
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, junk
	mov edx, 1
	int 80h

    mov eax, 3
	mov ebx, 0
	mov ecx, a
	mov edx, 1
	int 80h

    inc word[c]
	mov ax, word[c]
	mov [b], ax
	
	for:
	mov eax, 4
	mov ebx, 1
	mov ecx, b
	mov edx, 1
	int 80h
	
	mov al, byte[b]
	add al, 1
	mov [b],al
	cmp al, byte[a]
	jb for
	
	mov eax,1
	mov ebx,0
	int 80h