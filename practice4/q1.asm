section .data
    msg1: db 'enter the string',10
    l1:equ $-msg1
    msg2: db 'yes',10
    l2:equ $-msg2
    msg3: db 'no',10
    l3:equ $-msg3

section .bss
    str: resb 50
    strlen: resb 1
    temp: resb 1
    last: resb 1

section .text
    global _start:
    _start:

        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,l1
        int 80h

        mov ebx,str
        str_read:
            push ebx

            mov eax,3
            mov ebx,0
            mov ecx,temp
            mov edx,1
            int 80h

            pop ebx
            mov al,byte[temp]
            cmp al,10
            je end_read

            mov byte[ebx],al
            inc ebx
            inc byte[strlen]
            jmp str_read

            end_read:
                mov byte[ebx],0
                inc byte[strlen]
                dec ebx
                mov dword[last],ebx

                mov ebx,str

            end_print:
                mov ecx,dword[last]
                mov ebx,str

            palindrome:
                mov al,byte[ebx]
                cmp byte[ecx],al
                jne neg
                inc ebx
                dec ecx
                cmp ecx,ebx
                jle pos
                jmp palindrome

            pos: 
                mov eax,4
                mov ebx,1
                mov ecx,msg2
                mov edx,l2
                int 80h
                
                jmp exit

            neg:
                mov eax,4
                mov ebx,1
                mov ecx,msg3
                mov edx,l3
                int 80h

            inc byte[strlen]
            exit:
                mov eax,1
                mov ebx,0
                int 80h







