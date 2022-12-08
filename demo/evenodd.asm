section .data
	msg1: db "Enter the number of elements : "
	size1: equ $-msg1
	msg2: db "Enter a number:"
	size2: equ $-msg2
	msg3: db "No of even numbers = "
	size3: equ $-msg3
	msg4: db "No of odd numbers = "
	size4: equ $-msg4
	nwl : db 10
	l :equ $-nwl

section .bss
	digit0: resb 1
	digit1: resb 1
	array: resb 50 ;Array to store 50 elements of 1 byte each.
	element: resb 1
	num: resb 1
	temp: resb 1
	even: resb 1
	odd: resb 1

section .text
	global _start
	_start:
	;Printing the message to enter the number
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, size1
	int 80h
	;Reading the number
	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, digit0
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h

	sub byte[digit1], 30h
	sub byte[digit0], 30h
	mov al, byte[digit1]
	mov dl, 10
	mul dl
	mov byte[num], al
	mov al, byte[digit0]
	add byte[num], al
	mov al, byte[num]
	mov byte[even] ,0
	mov byte[odd], 0

	mov byte[temp], al
	mov ebx, array
	reading:
	push ebx ;Preserving The value of ebx in stack
	;Printing the message to enter each element
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, size2
	int 80h
	;Reading the number
	mov eax, 3
	mov ebx, 0
	mov ecx, digit1
	mov edx, 1
	int 80h
	mov eax, 3
	mov ebx, 0
	mov ecx, digit0
	mov edx, 2
	int 80h
	sub byte[digit1], 30h
	sub byte[digit0], 30h
	mov al, byte[digit1]
	mov dl, 10
	mul dl
	add al, byte[digit0]
	;al now contains the number

	mov bl, 2
	mov ah, 0
	div bl
	cmp ah, 0
	je if
	
	else :
		inc byte[odd]
		jmp L
	if:
		inc byte[even]	
	L:	
	pop ebx
	mov byte[ebx], al
	add ebx, 1

	dec byte[temp]
	cmp byte[temp], 0
	jg reading

	add byte[even], 30h
	add byte[odd], 30h
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, size3
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, even
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, nwl
	mov edx, l
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, size4
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, odd
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, nwl
	mov edx, l
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

	
