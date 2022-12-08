section .bss
	array : resd 50
	n : resd 1
	temp : resd 1
	sum : resd 1
	num : resd 1
	yea : resd 1
	dig : resd 1
	le : resd 1

section .data
	msg1: db "Enter the number of elements in the array:"
	size1: equ $-msg1
	msg2: db "Enter a number in the array:"
	size2: equ $-msg2
	msg3: db "Sum of Primes in the array:"
	size3: equ $-msg3

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

		mov dword[sum],0
		mov ebx,array
		mov eax,[n]
		mov [temp],eax
		mov eax,dword[ebx]
		mov [yea],eax

		loop:
			mov eax,dword[ebx]
			mov [yea],eax
			call check_prime
			add ebx,4		
			dec byte[temp]
			cmp byte[temp],0
			jne loop

		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,size3
		int 80h		
		
		mov eax,[sum]
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
			mov ecx,dig
			mov edx,1
			int 80h
		
		cmp byte[dig],10
		je end_input

		sub byte[dig],30h
		mov eax,[num]
		mov ebx,10
		mul ebx
		add eax,dword[dig]
		mov [num],eax

		jmp digit_loop
		end_input:
		popa
		ret

		print_number:
		pusha
		mov dword[le],0
		cmp dword[num],0
		je printzero

		get_number:
		mov edx,0
		mov eax, [num]
		mov ebx,10
		div ebx
		mov [num],eax
		push edx
		inc dword[le]
		cmp dword[num],0
		ja get_number

		print_digit:
		pop edx
		mov [dig],dl

		add byte[dig],30h
		mov eax,4
		mov ebx,1
		mov ecx,dig
		mov edx,1
		int 80h

		dec dword[le]
		cmp dword[le],0
		ja print_digit

		jmp end_print

		printzero:
		mov byte[le],1
		mov edx, [num]
		push edx
		jmp print_digit

		end_print:
		popa
		ret

		check_prime:
		pusha
		mov ax,word[yea]
   		mov cx,0
    	mov bl,2
    		check:
        		cmp bl,byte[yea]
        		ja exitcheck
        		push ax
        		div bl
        		cmp ah,0
        		jne L1
        		inc cx
        		L1:
        		pop ax
        		inc bl
        		jmp check
    		exitcheck:
        	cmp cx,1
    		jne L2
    
    		mov eax,dword[yea]
		add dword[sum],eax
    
   		L2:
    
    		popa
		ret