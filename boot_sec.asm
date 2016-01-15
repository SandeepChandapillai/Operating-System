[org 0x7c00] ; tell assembler location of origin of file

mov bp , 0xffff
mov sp , bp 


mov si , loading
call print_string

call read_from_disk


mov si , MY_MESS
call print_string


jmp $


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
	
	jmp $



MSG_REAL: 	
	db " READ MODE " , 0
MSG_PROC:
	db " PROTECTED MODE " , 0 



; LOAD MORE SECTORS FROM DISK 
%include "boot_sec_fns.asm"
times 510-($-$$) db 0 
dw 0xaa55




MY_MESS:
	db 'LOADED INTO MEMORY BY BIOS',0 ; loaded in the next sector after the bootloader
		; bios does only loads the 512 byte sector as 0x7c00 
		; boot loader has to load the next if we want to use it , by boot strapping the 
		; the BIOS 

times 512 db 0







