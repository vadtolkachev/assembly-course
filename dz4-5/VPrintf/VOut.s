section .text

global VPutChar
global VPuts
global VEndl
global VPrintBin
global VPrintHex
global VPrintDec

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
;Destr: rax, rbx, rcx
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
		jnc pb_next
		inc byte [rcx]

pb_next:	cmp rbx, 0
		jne pb_cicle

		push rcx
		call VPuts
		add rsp, 8

		add rsp, 65

		pop rbp		
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPrintHex(numb)
;Destr: rax, rbx, rcx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPrintHex:	push rbp
		mov rbp, rsp
		
		sub rsp, 17			;char str[17]
		mov byte [rsp+16], 0		;str[16] = '\0'

		mov rax, rsp			;memset(str, '0', 16)
		push 16
		push '0'
		push rax
		call VMemSet
		add rsp, 3*8


		mov rbx, [rbp+2*8]		;rbx = numb

		mov rcx, rsp			;rcx = rsp+16
		add rcx, 16


ph_cicle:	dec rcx
		mov al, bl
		shr rbx, 4
		and al, 0xf
		add byte [rcx], al
		cmp byte [rcx], '9'
		jbe ph_next
		add byte [rcx], 'a' - '9' - 1
ph_next:	cmp rbx, 0
		jne ph_cicle

		push rcx
		call VPuts
		add rsp, 8


		add rsp, 17

		pop rbp	
		ret



;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPrintDec(numb)
;Destr: rax, rbx, rcx, rdx, r8
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPrintDec:	push rbp
		mov rbp, rsp
		push rsi
		push rdi
		
		sub rsp, 21			;char str[21]
		mov byte [rsp+20], 0		;str[20] = '\0'

		mov rax, rsp			;memset(str, '0', 20)
		push 20
		push '0'
		push rax
		call VMemSet
		add rsp, 3*8


		mov rax, [rbp+2*8]		;rbx = numb

		mov r8, rsp			;r8 = rsp+20
		add r8, 20
		mov rbx, 10
pd_cicle:	dec r8
		mov rdx, 0
		div rbx
		add byte [r8], dl
		cmp rax, 0
		jne pd_cicle


		push r8
		call VPuts
		add rsp, 8


		add rsp, 21

		pop rdi
		pop rsi
		pop rbp	
		ret