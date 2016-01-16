[org 0x7c00] ; tell assembler location of origin of file

mov bp , 0xffff
mov sp , bp 

mov si , MSG_REAL 
call print_string

; SWTICH INTO OM 

call switch_to_pm

jmp $


; LOAD MORE SECTORS FROM DISK 
%include "boot_sec_fns.asm"

%include "pm.asm"

%include "boot_sec_pm_fns.asm"

[bits 32]

BEGIN_PM:

	mov edx, 0xb8000
	mov [edx], byte 'A'
	mov [edx + 2], byte 'B'
	
	mov esi, MSG_PROC
	call print_string_pm	

	
	jmp $ 



[bits 16]

MSG_REAL	db " REAL MODE " , 0
MSG_PROC 	db " 32 - BIT PROTECTED MODE " , 0 


times 510-($-$$) db 0 
dw 0xaa55
