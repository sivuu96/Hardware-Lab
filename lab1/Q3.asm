section .data
msg1 : db 'Enter first number :'
l1 : equ $-msg1
msg2 : db 'Enter second number :'
l2 : equ $-msg2
msg3 : db 'Yes divisible'
l3 : equ $-msg3
msg4 : db 'No not divisible'
l4 : equ $-msg4
nwl : db 10
l :equ $-nwl

section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1

section .text
	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

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

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h

        mov ax, word[d1]
        sub ax, 30h
        mov ah, 0
        mov bl, byte[d2]
        sub bl, 30h
        div bl
       
        cmp ah, 0 
        je if
        else:
        mov eax, 4
	    mov ebx, 1
	    mov ecx, msg4
	    mov edx, l4
	    int 80h 
        jmp L2
        
        if: 
        mov eax, 4
	    mov ebx, 1
	    mov ecx, msg3
	    mov edx, l3
	    int 80h
        
        L2:
        mov eax, 4
        mov ebx, 1
        mov ecx, nwl
        mov edx, l
        int 80h
	
	    mov eax, 1
	    mov ebx, 0
	    int 80h