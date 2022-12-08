
section .data
     msg1: db 'Enter string: '
     l1: equ $-msg1
     msg2: db ' '
     l2: equ $-msg2
     
section .bss
     n: resb 1
     m: resb 1
     t: resb 1
     a: resb 1
     b: resb 1
     c: resb 1
     d: resb 1
     f: resb 1
     s: resb 50
     val: resb 1

section .text
    global _start
    _start:    
           
            mov eax, 4
            mov ebx, 1
            mov ecx, msg1
            mov edx, l1
            int 80h
           
            mov ebx, s
            mov byte[ebx], 32
            inc ebx
            mov byte[n], 1
           
            read:
                 push ebx
                 mov eax, 3
                 mov ebx, 0
                 mov ecx, val
                 mov edx, 1
                 int 80h
                 
                 pop ebx
                 cmp byte[val], 10
                 je endread
                 mov al, byte[val]
                 mov byte[ebx], al
                 add ebx, 1
                 add byte[n], 1
                 jmp read
                 
                 endread:
                  mov dword[ebx], 0  
 
  print:
          dec ebx

        y:
           mov al, byte[ebx]
           cmp al, 32
           je argh
           
           dec ebx
           jmp y        
       
        argh:
            inc ebx
            mov al, byte[ebx]
            mov byte[a], al
            cmp al, 0
            je z
            cmp al, 32
            je z
            push ebx
            mov eax, 4
            mov ebx, 1
            mov ecx, a
            mov edx, 1
            int 80h
            pop ebx
           
            jmp argh
           
        z:
          push ebx
          mov eax, 4
          mov ebx, 1
          mov ecx, msg2
          mov edx, l2
          int 80h    
          pop ebx
           
        x:
          dec byte[n]
          cmp byte[n], 0
          je kill
          dec ebx
          mov al, byte[ebx]
          cmp al, 32
          je print
          jmp x
 
                kill:
                  mov eax, 1
                  mov ebx, 0
                  int 80h                    
