section .text

extern cPrint

global main
main:		push 31
		push 100
		push 3802
		push str
		push format
		call cPrint
		add rsp, 5*8

		mov rax, 0x3c
		mov rdi, 0
		syscall


section .data
format:		db "Hello world! I %s %x %d %% %c", 0xa, 0
str:		db "love", 0
