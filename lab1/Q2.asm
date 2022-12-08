section .data
msg1 : db 'Enter single digit number :'
l1 : equ $-msg1
msg2 : db 'Square of single digit number :'
l2 : equ $-msg2

section .bss
new : resb 2
f : resb 1
l : resb 1
d1 : resb 1
sq : resb 1

section .text
    global _start:
    _start: 

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,l1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,d1
    mov edx,1
    int 80h

    mov al,byte[d1]
    sub al,'0'
    mov bl,byte[d1]
    sub bl,'0'
    mul bl
    add al,'0'

    cmp al,57
    ja if

    else:
        mov [sq],al
        mov eax,4
        mov ebx,1
        mov ecx,msg2
        mov edx,l2
        int 80h

        mov eax,4
        mov ebx,1
        mov ecx,sq
        mov edx,1
        int 80h
        jmp ending
    
    if:
        sub al,'0'
        mov byte[new],al
        mov ax,word[new]
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
        mov ecx,msg2
        mov edx,l2
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
    
    ending:
        mov eax,1
        mov ebx,0
        int 80h
