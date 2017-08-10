section .data

newline_char: db 10
codes: db '0123456789abcdef'

section .text
global _start

print_newline:
	mov	rax, 1			; "write" syscall identifier
	mov	rdi, 1			; stdout file descriptor
	mov	rsi, newline_char	; where do we take data from
	mov	rdx, 1			; the amount of bytes to write

	syscall
	ret

print_hex:
	mov	rax, rdi

	mov	rdi, 1			; (stdout)
	mov	rdx, 1			; write 1 byte
	mov	rcx, 64			; how far to shift rax

iterate:
	push	rax			; save current rax value
	sub	rcx, 4
	sar	rax, cl			; shift to 60, 56, 52, ... 4, 0
					; cl register is smallest part of rcx
	and	rax, 0xf		; clear all bits but the lowest four
	lea	rsi, [codes + rax]	; take a hex digit character code

	mov	rax, 1			; (write)

	push	rcx			; syscall modifies rcx

	syscall				; rax = 1 (write)
					; rdi = 1 (stdout)
					; rsi = address of char from 'lea'
	pop	rcx			; recover countdown data
	pop	rax			; restore original byte string

	test	rcx, rcx		; rcx & rcx
	jnz	iterate			; if (rcx & rcx) != 0 goto 'iterate'

	ret

_start:
	mov	rdi, 0x1122334455667788
	call	print_hex
	call	print_newline

	mov	rax, 60			; prepare to exit
	xor	rdi, rdi		; set return code to 0
	syscall				; exit 0
