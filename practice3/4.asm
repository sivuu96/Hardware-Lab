section .data 
    msg1: db 'Enter size of array: '
    l1: equ $-msg1
    msg2: db 'Enter digit :'
    l2: equ $-msg2
    msg4: db 'Enter digit to search :'
    l4: equ $-msg4
    msg5: db 'FOUND'
    l5: equ $-msg5
    msg6: db 'NOT FOUND'
    l6: equ $-msg6       

section .bss
    d0: resb 1
    d1: resb 1
    array: resb 50 
    junk : resb 1
    flag: resb 1
    n: resb 1
    m: resb 1
        
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
    mov ecx, d0
    mov edx, 1
    int 80h
    
    mov eax, 3
    mov ebx, 0
    mov ecx, junk
    mov edx, 1
    int 80h
    
    sub byte[d1], 30h
    sub byte[d0], 30h
    
    mov al, byte[d1]
    mov dl, 10
    mul dl
    mov byte[n], al
    mov al, byte[d0]
    add byte[n], al
    
    mov al, byte[n]
    mov byte[m], al

    mov ebx, array
    
    reading:
        push ebx
       
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
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
        
        sub byte[d1],30h

        pop ebx
        
        mov al, byte[d1]
        mov byte[ebx], al
        add ebx, 1
    
        dec byte[n]
        cmp byte[n], 0
        jg reading
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, l4
    int 80h
    
    mov eax, 3
    mov ebx, 0
    mov ecx, flag
    mov edx, 1
    int 80h
    
    mov eax, 3
    mov ebx, 0
    mov ecx, junk
    mov edx, 1
    int 80h
    
    sub byte[flag], 30h
    
    mov ebx, array
    
    printing:
        push ebx
        
        mov al, byte[ebx]
        cmp al, byte[flag]
        je if
        else: 
            jmp L
        if: 
            mov eax, 4
            mov ebx, 1
            mov ecx, msg5
            mov edx, l5
            int 80h
            jmp exit
        L:
            pop ebx
            add ebx, 1

            dec byte[m]
            cmp byte[m], 0
            jg printing

    mov eax, 4
    mov ebx, 1
    mov ecx, msg6
    mov edx, l6
    int 80h
    
    exit:    
        mov eax, 1
        mov ebx, 0
        int 80h