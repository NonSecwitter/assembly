global _start

section .data

test_string: db "abcdef", 0

section .text

strlen:
	xor	rax, rax		;counter

.loop:
	cmp	byte [rdi+rax], 0	;check for null at 
					;"string_address" + "current_count"

	je	.end			;if "current_char" == 0, end
	
	inc	rax			;else, increment rax
	jmp	.loop			;and move to the next byte

.end:
	ret				;finished counting, return

_start:
	mov	rdi, test_string
	call	strlen
	mov	rdi, rax		;return value from strlen
					;to return value for "exit"

	mov	rax, 60			;prepare to exit
	syscall				;exit
