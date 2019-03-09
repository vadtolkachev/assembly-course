section .text

global VStrLen
global VMemSet

;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VStrLen(str_addr)
;Exit : rax - strlen
;Destr : rbx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VStrLen:	mov rbx, [rsp+8]
		mov rax, 0

sl_cicle:	cmp byte [rbx], 0
		je sl_ret
		inc rbx
		inc rax
		jmp sl_cicle

sl_ret:		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VMemSet(mem_addr, value, size) - value must be <= 0xff
;Destr : rax, rbx, rcx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VMemSet:	push rbp
		mov rbp, rsp

		mov rax, [rbp+2*8]	;mov rax, mem_addr
		mov rbx, [rbp+3*8]	;mov rbx, value
		mov rcx, [rbp+4*8]	;mov rcx, size

ms_cicle:	mov byte [rax], bl
		inc rax
		loop ms_cicle

		pop rbp
		ret

