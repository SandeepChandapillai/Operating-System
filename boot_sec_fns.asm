;
; FUNCTIONS 
;






DISK_ERROR:
	db 'ERROR READING SECTOR' , 0 

read_from_disk:

	mov ah, 0x02 ; READ SECTOR FROM DRIVE
	mov al, 1 ; # sectors to read ; 1 sector is 512 
	mov ch, 0 ; # select first cylinder / track 
	mov dh, 0 ;	# select first head
	mov cl, 2 ; select 2 nd sector  after the 512 for bootsector
	
	mov bx, 0 
	mov es, bx
	mov bx, 0x7c00 + 512  ; this specifies the sector that will be read. 



	int 0x13 ; SPECIAL TYPE OF INTERUPT

	jc read_error
		
	ret

read_error:
	mov si , DISK_ERROR
	call print_string
	
	ret ; jmp $







find_bios_string: ; on return dx will has the address and es will have the segment
	push bx 
	mov bx, 0 
	mov es, bx ; 0 th segment. segment shifted by 4 bits and then addrees added.
		   ; bx 0x0123 ex 0x1000
			; real address = 0x10123
			; we are able to address more this manner. 
	
	_search_loop : 
		mov al , [es:bx]
		cmp al , 'B';
		jne _continue_search	
	
		mov al , [es:bx + 1]
		cmp al , 'I';
		jne _continue_search	

		mov al , [es:bx + 2]
		cmp al , 'O';
		jne _continue_search	

		mov al , [es:bx + 3]
		cmp al , 'S';
		jne _continue_search	
	
			; found the 4 characters together	
			; return 
			mov dx , es
			call print_hex
			mov dx , bx 
			call print_hex
			; halt 
			jmp _return

		_continue_search:
		add bx , 1 
		cmp bx,0
		je _inc_segment
		jmp _search_loop

		_inc_segment:
			mov cx, es 
			add cx, 0x1000
			mov es, cx 
			jmp _search_loop	

	_return : 	
	pop bx
	ret 



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
loading: 
	db 'BOOTING THE SYSTEM ',0






