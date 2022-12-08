section .data
	msg1: db 'Enter string: '
	l1:equ $-msg1
	msg2: db 'number of vowels: '
	l2:equ $-msg2

section .bss
	s : resb 50
	len : resb 1
	temp : resb 1
	last : resb 1
	val : resb 1

section .text
	global _start:
	_start:
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,l1
		int 80h

		mov byte[len],0
		mov ebx , s

	read:
		push ebx

		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h

		pop ebx
		cmp byte[temp],10
		je end
		cmp byte[temp] , 65
		je if
		cmp byte[temp] , 69
		je if
		cmp byte[temp] , 73
		je if
		cmp byte[temp] , 79
		je if
		cmp byte[temp] , 85
		je if
		cmp byte[temp] , 97
		je if
		cmp byte[temp] , 101
		je if
		cmp byte[temp] , 105
		je if
		cmp byte[temp] , 111
		je if
		cmp byte[temp] , 117
		je if
		else:
   			jmp X
		if:
   			inc byte[val]
		X:

			mov al,byte[temp]
			mov byte[ebx],al
			inc ebx
			inc byte[len]
			jmp read

	end:
		mov byte[ebx],0
		dec ebx
		
		push ebx
		mov eax , 4
		mov ebx , 1
		mov ecx , msg2
		mov edx , l2
		int 80h
		pop ebx

	print:
		mov al,byte[val]
		mov byte[last],al
		add byte[last], 30h

		mov eax , 4
		mov ebx , 1
		mov ecx , last
		mov edx , 1
		int 80h

mov eax,1
mov ebx,0
int 80h
