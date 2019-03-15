Section .data                           ;Data segment
   userMsg db 'Please enter 15 numbers: ' ;Ask the user to enter a number
   lenUserMsg equ $-userMsg             ;The length of the message
   fispMsg db 'Encrypted Message is: '
   lenFispMsg equ $-fispMsg           
   dispMsg db 'Decrypted Message is: '
   lenDispMsg equ $-dispMsg          

section .bss           ;Uninitialized data
   num resw 15
   encrypted resw 15	

	
section .text          ;Code Segment
   global _start
	
_start:                ;User prompt
   mov eax, 4
   mov ebx, 1
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 80h

   ;Read and store the user input
   mov eax, 3
   mov ebx, 2
   mov ecx, num  
   mov edx, 15      ;5 bytes (numeric, 1 for sign) of that information
   int 80h

   lea edi,[num]
   lea esi,[encrypted]

   ;encrypt
   mov ecx,15
   encrypting:
	mov eax,[edi]
        xor eax,26
   	mov [esi],eax
	inc edi
	inc esi
        int 80h
   loop encrypting

   ;Output the message 'The entered number is: '
   mov eax, 4
   mov ebx, 1
   mov ecx, fispMsg
   mov edx, lenFispMsg
   int 80h  


   ;Output the number entered
   mov eax, 4
   mov ebx, 1
   mov ecx, encrypted
   mov edx, 15
   int 80h  

   lea esi,[encrypted]

   mov ecx,15
   decrypting:
	mov eax,[esi]
        xor eax,26
   	mov eax,[esi]
	xor eax,26
	mov[esi],eax
	inc esi
        int 80h
   loop decrypting
	
   ;Output the message 'The entered number is: '
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 80h  

   ;Output the number entered
   mov eax, 4
   mov ebx, 1
   mov ecx, encrypted
   mov edx, 15
   int 80h  
    
   ; Exit code
   mov eax, 1
   mov ebx, 0
   int 80h
