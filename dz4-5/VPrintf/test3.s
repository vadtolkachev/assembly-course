section .text

extern VPrintf
extern VGetDec


global _start
_start:		call VGetDec

		push 31
		push 100
		push 3802
		push msg3
		push msg
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
msg:		db "Hello world!", 0
msg3:		db "love", 0
msgLen:		equ $ - msg - 1
msg2:		db"hey there", 0xa ,"proc - %%; dec - %d; bin - %b; hex - 0x%x; str - %s; char - %c", 0xa, "again - %s", 0xa, "I %s %x %d %% %c", 0xa, 0
