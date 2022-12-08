section .data
msg1: db 'Enter string '
l1:equ $-msg1

msg2: db 'reversed string '
l2:equ $-msg2

section .bss
s : resb 50
len : resb 1
temp : resb 1
last : resb 1

section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

mov byte[len],0
mov ebx , s

read:
push ebx

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

pop ebx
cmp byte[temp],10
je end
mov al,byte[temp]
mov byte[ebx],al
inc ebx
inc byte[len]
jmp read

end:
mov byte[ebx],0
dec ebx


print:

mov al,byte[ebx]
mov byte[last],al
push ebx

mov eax , 4
mov ebx , 1
mov ecx , last
mov edx , 1
int 80h

pop ebx
dec ebx
dec byte[len]
cmp byte[len],0
ja print

mov eax,1
mov ebx,0
int 80h
