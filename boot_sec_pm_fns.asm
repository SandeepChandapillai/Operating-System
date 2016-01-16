
[bits 32]


print_string_pm: ; print in protected mode.
		 ; print till 0 encountered.
		 ; ASSUMPTION
		 ; byte to be printed will be in the si register 
	DISP_ADDR equ 0xb8000
	WHITE_BLACK equ 0x0f
	pusha	
	; prepare 
	mov edx , DISP_ADDR
	_loop_print : 
		
		mov al, [esi]
		mov ah, WHITE_BLACK
		
		cmp al , 0
		je _print_done

		mov [edx],ax
		inc esi 
		add edx , 2	
		
		jmp _loop_print	
	
	_print_done:
		popa 
		ret
	
[bits 16]
