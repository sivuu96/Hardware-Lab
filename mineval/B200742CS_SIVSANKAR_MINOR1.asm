section .data
msg1 : db 'Sum='
l1 : equ $-msg1
msg2 : db 'Result='
l2 : equ $-msg2
nwl : db 10
l3 :equ $-nwl

section .bss

a : resb 1
b : resb 1
c : resb 1
junk : resb 1
sum : resb 1
temp : resb 1
f : resb 1
l : resb 1
t : resb 1

section .text
	global _start:
	_start:
	
	mov eax, 3
	mov ebx, 0
	mov ecx, c
	mov edx, 1
	int 80h
    sub byte[c],30h

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
    sub byte[a],30h

    mov byte[sum], 0
    inc word[c]
	mov ax, word[c]
	mov [b], ax
	
	for:
	;mov eax, 4
	;mov ebx, 1
	;mov ecx, b
	;mov edx, 1
	;int 80h
	
	mov al, byte[b]
    add byte[sum],al
	add al, 1
	mov [b],al
	cmp al, byte[a]
	jb for
	
    mov bl,byte[sum]
    mov byte[t],bl
    add byte[sum],30h

    cmp byte[sum],57
    ja if

    else:
        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,l1
        int 80h
        
        mov eax, 4
	    mov ebx, 1
	    mov ecx, sum
	    mov edx, 1
	    int 80h

        sub byte[sum],30h

        mov eax,4
        mov ebx,1
        mov ecx,nwl
        mov edx,l3
        int 80h

        jmp r
    
    if: 
        sub byte[sum],30h
        mov ax,word[sum]
        mov bl,10
        ;sub bl,'0'
        ;inc bl
        div bl

        add al,'0'
        add ah,'0'

        mov byte[f],al
        mov byte[l],ah

        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,l1
        int 80h

        mov eax,4
        mov ebx,1
        mov ecx,f
        mov edx,1
        int 80h

        mov eax,4
        mov ebx,1
        mov ecx,l
        mov edx,1
        int 80h

        mov eax,4
        mov ebx,1
        mov ecx,nwl
        mov edx,l3
        int 80h
    r:  
        mov ax, word[t]
        mov bl,2
        div bl

        add al,'0'
        add ah,'0'

        mov byte[temp],al

        mov eax,4
        mov ebx,1
        mov ecx,msg2
        mov edx,l2
        int 80h

        mov eax,4
        mov ebx,1
        mov ecx,temp
        mov edx,1
        int 80h

        mov eax,4
        mov ebx,1
        mov ecx,nwl
        mov edx,l3
        int 80h

	mov eax,1
	mov ebx,0
	int 80h