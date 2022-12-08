section .data
   msg1: db 'Enter number: '
   l1: equ $-msg1
section .bss
   n: resb 1
   m: resb 1
   a: resb 1
   b: resb 1
   x: resb 1
   y: resb 1
   s: resb 50

section .text
  global _start:
  _start:
  mov ebx, s
  mov byte[x], 0
       input:
       push ebx
       mov eax, 4
       mov ebx, 1
       mov ecx, msg1
       mov edx, l1
       int 80h
       mov eax, 3
       mov ebx, 0
       mov ecx, n
       mov edx, 1
       int 80h
       pop ebx
       mov byte[m], 0
       read:
       
       mov al, byte[n]
       sub al, 30h
       add byte[m], al
       push ebx
       mov eax, 3
       mov ebx, 0
       mov ecx, n
       mov edx, 1
       int 80h
       pop ebx
       cmp byte[n], 10
       je endread
       mov al, byte[m]
       mov ah, 0
       mov bl, 10
       mul bl
       mov word[m],ax
       jmp read

       endread:
       mov al, byte[m]
       mov byte[ebx], al
       inc ebx
       inc byte[x]
       cmp byte[x], 10
       je next
       jmp input

       next:
       mov ebx, s
       mov al, byte[ebx]
       mov byte[a], al
       mov byte[b], al
      inc ebx
       mov byte[y], 1
       loop:

       mov al, byte[ebx]
       cmp al, byte[a]
       ja max
       mov byte[b], al
       jmp run
       max:
       mov byte[a], al
       run:
       inc byte[y]
       inc ebx
       cmp byte[y], 10
       je exit
       jmp loop
exit:
       add byte[a], 30h
       add byte[b], 30h
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
       mov eax, 1
       mov ebx, 0
       int 80h
       
       


