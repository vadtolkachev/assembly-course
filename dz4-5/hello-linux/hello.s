section .text

global _start

_start:		mov rax, 1
		mov rdi, 1
		mov rsi, msg
		mov rdx, msgLen
		syscall

		mov rax, 0x3c
		xor rdi, rdi
		syscall

section .data

msg:		db "Hello world!", 10
msgLen:		equ $ - msg