section .text


extern VGetChar
extern VGetBin
extern VGetHex
extern VGetDec
extern VPutChar
extern VPrintBin
extern VPrintHex
extern VPrintDec
extern VEndl


global _start
_start:		call VGetChar

		mov ah, 0

		push rax
		call VPutChar
		add rsp, 8

		call VEndl


		call VGetBin
		inc rax

		push rax
		call VPrintBin
		add rsp, 8

		call VEndl


		call VGetHex
		inc rax

		push rax
		call VPrintHex
		add rsp, 8

		call VEndl

		call VGetDec
		inc rax

		push rax
		call VPrintDec
		add rsp, 8

		call VEndl


		mov rax, 0x3c
		mov rdi, 0
		syscall

