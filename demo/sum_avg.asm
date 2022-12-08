section .bss
	array : resd 50
	n : resd 1
	temp : resd 1
	temp2 : resd 1
	count : resd 1
	sum : resd 1
	sumcpy : resd 1
	avg : resd 1
	min_count : resd 1
	num : resd 1
	ele : resd 1
	digit : resd 1
	length : resd 1

section .data
	msg1: db "Enter the number of elements : "
	size1: equ $-msg1
	msg2: db "Enter a number:"
	size2: equ $-msg2
	msg3: db "Sum : "
	size3: equ $-msg3
	msg4: db "Average : "
	size4: equ $-msg4
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
		mov [n],eax
		
		mov [temp],eax
		mov ebx,array

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

		mov ebx,array
		mov dword[sum],0
		mov dword[count],0
		mov eax,[n]
		mov [temp],eax

		get_sum:
		mov ecx,[ebx]
		add [sum],ecx
		add ebx,4
		dec byte[temp]
		cmp byte[temp],0
		ja get_sum
		
		mov eax,[sum]
		mov [sumcpy],eax
		mov ebx,[n]
		div ebx
		mov [avg],eax

		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,size3
		int 80h

		mov eax,[sum]
		mov [num],eax

		call print_number

		mov eax,4
		mov ebx,1
		mov ecx,nwl
		mov edx,l
		int 80h		

		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,size4
		int 80h

		mov eax,[avg]
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
