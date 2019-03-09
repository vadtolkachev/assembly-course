section .text

numb		equ 2048

extern VPrintBin
extern VPuts
extern VStrLen
extern VEndl
extern VMemSet

global _start
_start:		mov rax, 1
		mov rdi, 1
		mov rsi, msg
		mov rdx, msgLen
		syscall

		push numb
		call VPrintBin
		add rsp, 8
		;call VEndl

		push msg
		call VStrLen
		add rsp, 8
		
		mov rdx, rax
		mov rax, 1
		mov rdi, 1
		mov rsi, msg
		syscall

		push msg
		call VPuts
		add rsp, 8

		call VEndl

		push 4
		push 'a'
		push msg + 2
		call VMemSet
		add rsp, 3*8

		mov rax, 1
		mov rdi, 1
		mov rsi, msg
		mov rdx, msgLen
		syscall

		mov rax, 0x3c
		mov rdi, 0
		syscall


section .data
msg:		db "Hello world!", 0xa, 0
msgLen:		equ $ - msg - 1 

;00007ffe541ef7e0
;00007ffe541ef7d8