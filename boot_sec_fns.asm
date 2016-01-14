;
; FUNCTIONS 
;


print_string:

	_loop :
		mov al, [si]
		cmp al,0
		je _break
		call print_char
		inc si	
		jmp _loop

	_break : 
		ret 

print_char:
	mov ah , 0x0e
	int 0x10			
;	pop dx 
;	jmp dx
	ret
;
; DATA
;

msg1:
	db 'hello',0

msg2: 	
	db 'goodbye',0


