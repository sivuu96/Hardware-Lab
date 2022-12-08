section .bss
	array1 : resd 50
	n1 : resd 1
	temp : resd 1
	sum : resd 1
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
        mov [temp2],eax
		mov ebx,array1

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
		
		mov ebx,array1
        mov dword[sum],0
        mov cx,0
        mov cl,2
        
        check:
            mov dword[ele],ebx
            mov ax,word[ele]
            mov ah,0
            cmp cl,byte[ele]
            ja exitcheck

            push ax
            ;push ebx
            div cl
            cmp ah,0
            jne L1
            inc cx
            jmp exitcheck
            L1: 
                pop ax
                ;pop ebx
                inc cl

            jmp check
            exitcheck:
                cmp cx,1
                jne bleh
                
                add dword[sum],ebx
    
            bleh:
                add ebx,4
                mov cx,0
                mov cl,2
            
                dec dword[temp2]
                cmp dword[temp2],0
                ja check
        
        mov eax,4
		mov ebx,1
		mov ecx,sum
		mov edx,1
		int 80h

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

		