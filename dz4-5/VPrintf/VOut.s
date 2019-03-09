section .text

global VPuts
global VEndl
global VPrintBin
global VPutChar

extern VMemSet
extern VStrLen

ENDL		equ 10


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPutChar(char) - char should be <= 0xff
;Destr: rax, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPutChar:	push rsi
		push rdi

		mov rax, [rsp+3*8]
		dec rsp
		mov [rsp], al

		mov rax, 1
		mov rdi, 1
		mov rsi, rsp
		mov rdx, 1
		syscall

		inc rsp

		pop rdi
		pop rsi
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPuts(str_addr)
;Destr: rax, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPuts:		push rsi
		push rdi

		push qword [rsp+3*8]
		call VStrLen
		add rsp, 8

		mov rdx, rax
		mov rax, 1
		mov rdi, 1
		mov rsi, [rsp+3*8]
		syscall

		pop rdi
		pop rsi
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VEndl()
;Destr: rax, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VEndl:		push rsi
		push rdi

		dec rsp
		mov byte [rsp], 0xa

		mov rax, 1
		mov rdi, 1
		mov rsi, rsp
		mov rdx, 1
		syscall

		inc rsp

		pop rdi
		pop rsi
		ret




;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPrintBin(numb)
;Destr: rax, rbx, rcx,rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPrintBin:	push rbp
		mov rbp, rsp
		
		sub rsp, 65			;char str[65]
		mov byte [rsp+64], 0		;str[64] = '\0'

		mov rax, rsp			;memset(str, '0', 64)
		push 64
		push '0'
		push rax
		call VMemSet
		add rsp, 3*8


		mov rbx, [rbp+2*8]		;rbx = numb

		mov rcx, rsp			;rcx = rsp+64
		add rcx, 64

pb_cicle:	dec rcx
		shr rbx, 1
		jnc next1
		inc byte [rcx]

next1:		cmp rbx, 0
		jne pb_cicle

		push rcx
		call VPuts
		add rsp, 8
		call VEndl

		add rsp, 65

		pop rbp		
		ret

section .data
buf:		equ $