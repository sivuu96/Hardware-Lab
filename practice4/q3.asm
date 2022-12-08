section .data
msg1: db 'Enter string '
l1:equ $-msg1

msg2: db 'reversed string '
l2:equ $-msg2

section .bss
s : resb 50
r : resb 50
len1 : resb 1
len2 : resb 1
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

mov byte[len1],0
mov ebx , s

read1:
push ebx

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

pop ebx
cmp byte[temp],10
je end1
mov al,byte[temp]
mov byte[ebx],al
inc ebx
inc byte[len1]
jmp read1

end1:
push ebx
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h
pop ebx
read2:
push ebx

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

pop ebx
cmp byte[temp],10
je end2
mov al,byte[temp]
mov byte[ebx],al
inc ebx
;inc byte[len]
jmp read2

end2:
mov byte[ebx],0
mov ebx , s

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
inc ebx
;inc byte[len]
cmp byte[ebx],0
ja print

mov eax,1
mov ebx,0
int 80h
