[bits 16] ; 16 bit opcode 

; prepared global descriptor table 
%include "gdt.asm"

; switch to protected mode
switch_to_pm:
	cli
	lgdt [gdt_descriptor]

	mov eax, cr0 
	or eax , 0x1
	mov cr0, eax


	jmp CODE_SEG:init_pm	

[bits 32] ; nasm to output to 32 bit opcoes

init_pm:
; 32 bit instrcutions... 	
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es,	ax
	mov fs, ax
	mov gs, ax 

	mov ebp, 0x90000 ; stack position 
	mov esp , ebp 

	call BEGIN_PM

[bits 16]

