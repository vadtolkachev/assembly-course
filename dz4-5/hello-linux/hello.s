section .text

global _start
_start:		mov rax, 1
		mov rdi, 1
		mov rsi, msg
		mov rdx, msgLen
		syscall

		mov rax, 0x3c
		mov rdi, 0
		syscall


section .data
msg:		db "Hello world!", 0xa
msgLen:		equ $ - msg