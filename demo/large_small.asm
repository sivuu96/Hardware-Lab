section .bss
	array : resd 50
	n : resd 1
	temp : resd 1
	temp2 : resd 1
	count : resd 1
	largest : resd 1
	big : resd 1
	smallest : resd 1
	sm : resd 1
	num : resd 1
	ele : resd 1
	digit : resd 1
	length : resd 1

section .data
	msg1: db "Enter a number:"
	size1: equ $-msg1
	msg2: db "Largest : "
	size2: equ $-msg2
	msg3: db "Smallest : "
	size3: equ $-msg3
	nwl : db 10
	l :equ $-nwl

section .text
	global _start:
	_start:
		mov dword[n],10
		mov dword[temp],10
		mov ebx,array
	
		read:
			pusha
			mov eax,4
			mov ebx,1
			mov ecx,msg1
			mov edx,size1
			int 80h
			popa

			push ebx
			call input_number
			pop ebx
			mov eax,[num]
			mov [ebx],eax
			add ebx,4
			dec byte[temp]
			cmp byte[temp],0
			ja read	

		mov ebx,array
		mov dword[temp],10
		mov eax,[ebx]
		mov [largest],eax
		mov [smallest],eax
		
		compare:
		mov ecx,[ebx]
		mov [big],ecx
		mov [sm],ecx
		cmp ecx,[largest]
		jle check_small

		mov eax,[big]
		mov [largest],eax

		check_small:
		mov ecx,[ebx]
		mov [big],ecx
		mov [sm],ecx
		cmp ecx,[smallest]
		jge next_ele

		mov eax,[sm]
		mov [smallest],eax

		next_ele:
		add ebx,4
		dec byte[temp]
		cmp byte[temp],0
		jnz compare

		mov eax,4
		mov ebx,1
		mov ecx,msg2
		mov edx,size2
		int 80h

		mov eax,[largest]
		mov [num],eax

		call print_number

		mov eax,4
		mov ebx,1
		mov ecx,nwl
		mov edx,l
		int 80h		

		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,size3
		int 80h

		mov eax,[smallest]
		mov [num],eax

		call print_number
		
		mov eax,1
		mov ebx,0
		int 80h

		input_number:
		pusha
		mov dword[num],0

		digit_loop:		
		mov eax,3
		mov ebx,0
		mov ecx,digit
		mov edx,1
		int 80h

		cmp byte[digit],10
		je end_input

		sub byte[digit],30h
		mov eax,[num]
		mov ebx,10
		mul ebx
		add eax,dword[digit]
		mov [num],eax
		
		jmp digit_loop
		end_input:
		popa
		ret

		print_number:
		pusha
		mov dword[length],0
		cmp dword[num],0
		je print_zero

		get_number:
		mov edx,0
		mov eax,[num]
		mov ebx,10
		div ebx
		mov [num],eax
		push edx
		inc dword[length]
		cmp dword[num],0
		ja get_number

		print_digit:
		pop edx
		mov [digit],dl
		
		add byte[digit],30h
		mov eax,4
		mov ebx,1
		mov ecx,digit
		mov edx,1
		int 80h

		dec dword[length]
		cmp dword[length],0
		ja print_digit

		jmp end_print

		print_zero:
		mov byte[length],1
		mov edx,[num]
		push edx
		jmp print_digit

		end_print:
		popa
		ret
