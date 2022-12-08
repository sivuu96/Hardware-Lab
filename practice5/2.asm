section .data
     msg1: db 'Enter string: '
     l1: equ $-msg1
     msg2: db 'MYR'
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
    global _start:
    _start:    
           
            mov eax, 4
            mov ebx, 1
            mov ecx, msg1
            mov edx, l1
            int 80h
           
            mov ebx, s
            mov byte[n],0
           
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
                 
               
                 
                  mov ebx, s
                  mov al, byte[ebx]
                  mov byte[a], al
                  mov byte[b], 0
                  mov byte[c], 0
                 
            block:
                 inc ebx
                 mov al, byte[ebx]
                 cmp al, 0
                 je kill
                 
                 x:
                 mov al, byte[ebx]
                 cmp al, byte[a]
                 je if
                 
                 else:
                 mov al, byte[ebx]
                 mov byte[a], al
                 mov ah, byte[c]
                 cmp byte[b], ah
                 jb meh
                 mov ah, byte[b]
                 mov byte[c],ah
                 mov byte[b], 0
                 jmp block
                 meh:
                 mov byte[b], 0
                 jmp block
                 
                 if:
                 inc byte[b]
                 jmp block
               
                kill:
                  mov al, byte[c]
                  cmp al, byte[b]
                  ja if2
                  else2:
                  mov ah, byte[b]
                  mov byte[c],ah
                  jmp ded
                  if2:
                  jmp ded
                 
                ded:
                  add byte[c], 1
                  add byte[c], 30h
               
                 
               
                  mov eax, 4
                  mov ebx, 1
                  mov ecx, c
                  mov edx, 1
                  int 80h
                 
                  mov eax, 1
                  mov ebx, 0
                  int 80h     