;
; FUNCTIONS 
;

; assumes the value is stored in dx
print_hex:
	push bx 
	push dx 
	push si 

	mov si, HEX_TEMPLA
	mov bx,dx
	shr bx,12 ; bx -> 0x0001
	and bx,0x000f ; bx masked -> 0x0002
;	add bx,48 ; converting to ASCII
	mov bx,[HEX_CONV + bx]
	mov [HEX_TEMPLA + 2] , bl

	mov bx,dx
	shr bx,8 ; bx -> 0x0001
	and bx,0x000f ; bx masked -> 0x0002
	mov bx,[HEX_CONV + bx]
	mov [HEX_TEMPLA + 3] , bl

	mov bx,dx
	shr bx,4 ; bx -> 0x0001
	and bx,0x000f ; bx masked -> 0x0002
	mov bx,[HEX_CONV + bx]
	mov [HEX_TEMPLA + 4] , bl

	mov bx,dx
	shr bx,0 ; bx -> 0x0001
	and bx,0x000f ; bx masked -> 0x0002
	mov bx,[HEX_CONV + bx]
	mov [HEX_TEMPLA + 5] , bl

	call print_string
	
	pop si 
	pop dx 
	pop bx 
	ret


; print 100 hex values from smaller address to larger 
; or put the value in ax and we will print from there

print_hex_100:
	push cx
	push di 
	push dx
	push si 	
	mov cx , 0
	mov di , dx
	_loop_2:
		cmp cx , 100
		jg _end_2
		inc cx 
		mov dx , [di]
		call print_hex
		add di ,2
		jmp _loop_2

	_end_2: 
	
		mov si , LONG_SPACE
		call print_string
	
		pop si
		pop dx 
		pop di 
		pop cx 	
		ret

print_string:
	push ax
	push si  
	_loop :
		mov al, [si]
		cmp al,0
		je _break
		call print_char
		inc si	
		jmp _loop

	_break : 
		pop si 
		pop ax 
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

LONG_SPACE:
	db '     /      ',0
HEX_TEMPLA:
	db '0x???? ',0

HEX_CONV: 
	db '0123456789abcdef'





