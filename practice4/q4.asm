section .data
msg1: db 'Enter string '
l1:equ $-msg1
msgno: db 'They are not the same strings '
lno:equ $-msgno
msgyes: db 'They are the same strings '
lyes:equ $-msgyes

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
mov byte[len2],0
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
mov byte[ebx], 0

push ebx
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h
pop ebx
mov ebx, r
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
inc byte[len2]
jmp read2

end2:
mov byte[ebx],0

mov al, byte[len1]
cmp al, byte[len2]
jne kill

mov ebx, s
mov ecx, r
print:

mov al,byte[ebx]
mov byte[last],al
mov ah, byte[ecx]
cmp ah, byte[last]
je loop
cmp ah, byte[last]
ja if
else:
sub byte[last], ah
cmp byte[last], 32
je loop
if:
sub ah, byte[last]
mov byte[temp], ah
cmp byte[temp], 32
je loop

cmp ah, byte[last]
jne kill

loop:
inc ebx
inc ecx
dec byte[len1]
cmp byte[len1],0
ja print

push ebx
push ecx
mov eax, 4
mov ebx, 1
mov ecx, msgyes
mov edx, lyes
int 80h
pop ecx
pop ebx
jmp stop

kill:
mov eax, 4
mov ebx, 1
mov ecx, msgno
mov edx, lno
int 80h

stop:
mov eax,1
mov ebx,0
int 80h

