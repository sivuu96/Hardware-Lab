section .bss
	array1 : resd 50
	array2 : resd 50
	n1 : resd 1
	n2 : resd 1
	temp : resd 1
	temp1 : resd 1
	temp2 : resd 1
	count : resd 1
	num : resd 1
	ele : resd 1
	digit : resd 1
	length : resd 1

section .data
	msg1: db "Enter the number of elements in 1st array : "
	size1: equ $-msg1
	msg2: db "Enter a number:"
	size2: equ $-msg2
	msg3: db "Enter the number of elements in 2nd array : "
	size3: equ $-msg3
	msg4: db "Common Elements : "
	size4: equ $-msg4
	msg5: db " "
	size5: equ $-msg5
	nwl : db 10
	l :equ $-nwl

section .text
	global _start:
	_start:
		pusha
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size1
		int 80h
		popa

		call input_number
		mov eax,[num]
		mov [n1],eax

		mov [temp],eax
		mov ebx,array1

		;reading array
		read:
			pusha
			mov eax,4
			mov ebx,1
			mov ecx,msg2
			mov edx,size2
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
		
		pusha
		mov eax,4
		mov ebx,1
		mov ecx,msg1
		mov edx,size1
		int 80h
		popa

		call input_number
		mov eax,[num]
		mov [n2],eax

		mov [temp],eax
		mov ebx,array2

		;reading array
		read2:
			pusha
			mov eax,4
			mov ebx,1
			mov ecx,msg2
			mov edx,size2
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
			ja read2

		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,size4
		int 80h		
		
		mov eax,[n1]
		mov [temp1],eax
		mov eax,[n2]
		mov [temp2],eax
		mov ebx,array1
		mov eax,dword[ebx]

		sel_ele:
		mov eax,dword[ebx]
		mov edx,array2
		mov [ele],eax
		mov ecx,[n2]
		mov [temp2],ecx
		
		common_detect:
		mov ecx,dword[edx]
		cmp ecx,dword[ele]
		jne next_count

		mov eax,[ele]
		mov [num],eax
		call print_number
		call print_space
		jmp next_ele

		next_count:
		add edx,4
		dec byte[temp2]
		cmp byte[temp2],0
		jnz common_detect

		next_ele:
		add ebx,4
		dec byte[temp1]
		cmp byte[temp1],0
		jnz sel_ele

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
		je printzero

		get_number:
		mov edx,0
		mov eax, [num]
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

		printzero:
		mov byte[length],1
		mov edx, [num]
		push edx
		jmp print_digit

		end_print:
		popa
		ret

		print_space:
		pusha
		mov eax,4
		mov ebx,1
		mov ecx,msg5
		mov edx,size5
		int 80h
		popa
		ret
		
