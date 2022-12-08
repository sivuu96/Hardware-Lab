section .data 
    msg1: db 'Enter size of array: '
    l1: equ $-msg1
    msg2: db 'Enter digit: '
    l2: equ $-msg2
    msg4: db 'Sum: '
    l4: equ $-msg4
    msg5: db 'Average: '
    l5: equ $-msg5
    msg6: db 0Ah
    l6: equ $-msg6       

section .bss
    d0: resb 1
    d1: resb 1
    array: resb 50 
    junk : resb 1
    n: resb 1
    m: resb 1
    o: resb 1
    p: resb 1
    sum: resb 1
    avg: resb 1
    a: resb 1
    b: resb 1
    c: resb 1
    d: resb 1
    e: resb 1
    f: resb 1
    x: resb 1
    y: resb 1
        
section .text
    global _start
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
    mov byte[o], al

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
    
    mov byte[sum], 0
    mov ebx, array
    
    printing:
        push ebx

        mov al, byte[ebx]
        add byte[sum], al
    
        pop ebx
        add ebx, 1

        dec byte[m]
        cmp byte[m], 0
        jg printing
    
    mov ax, word[sum]
    mov bl, byte[o]
    mov ah, 0
    div bl
    mov byte[avg], al
    

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, l4
    int 80h
    
    mov ax, word[sum]
    mov bl, 100
    mov ah, 0
    div bl
    add al, 30h
    mov byte[a], al
    
    mov byte[x], ah
    mov ax, word[x]
    mov bl, 10
    mov ah, 0
    div bl
    add al, 30h
    add ah, 30h
    mov byte[b], al
    mov byte[c], ah
    
    mov eax, 4
    mov ebx, 1
    mov ecx, a
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, b
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, c
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg6
    mov edx, l6
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, l5
    int 80h
    
    mov ax, word[avg]
    mov bl, 100
    mov ah, 0
    div bl
    add al, 30h
    mov byte[d], al
    
    mov byte[y], ah
    mov ax, word[y]
    mov bl, 10
    mov ah, 0
    div bl
    add al, 30h
    add ah, 30h
    mov byte[e], al
    mov byte[f], ah
    
    mov eax, 4
    mov ebx, 1
    mov ecx, d
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, e
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, f
    mov edx, 1
    int 80h
    
    mov eax, 1
    mov ebx, 0
    int 80h