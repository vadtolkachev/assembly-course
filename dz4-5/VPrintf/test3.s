section .text

extern VPrintf


global _start
_start:

		mov rax, 255
		push 'W'
		push msg
		push rax
		push rax
		push rax
		push msg2
		call VPrintf
		add rsp, 6*8


		mov rax, 0x3c
		mov rdi, 0
		syscall


section .data
msg:		db "Hello world!", 0xa, 0
msgLen:		equ $ - msg - 1
msg2:		db"hey there%%as%ddj %b ch 0x%x sa str - %schar - %c", 0xa, 0