section .data

newline_char: db 10
codes: db '0123456789abcdef'

section .text
global _start

print_newline:
	mov	rax, 1			; 'write' syscall identifier
	mov	rdi, 1			; 'stdout' file descriptor
	mov	rsi, newline_char	; starting address of data
	mov	rdx, 1			; number of bytes to write
	syscall
      ret

print_hex:
	mov	rax, rdi		; move input (rdi) to rax
	mov	rdi, 1			; 'stdout' file descriptor
	mov	rdx, 1			; number of bytes to write
	mov	rcx, 64			; bit/position counter

iterate:
	push	rax			; save input, rax altered later
	sub	rcx, 4			; every iteration shifts 4 fewer
	sar	rax, cl			; shift rax 'cl' times (cl is lowest byte of rcx)
	and	rax, 0xf		; 'AND' rax with 0xf to preserve lowest 4 bits
	lea	rsi, [codes + rax]	; add value of rax to address of codes

	mov	rax, 1			; 'write' syscall identifier (prepare to write)
	push	rcx			; 'write' syscall alters rcx (counter) (rcx caller saved)

	syscall

	pop	rcx			; restore counter
	pop	rax			; restore original input

	test	rcx, rcx		; rcx & rcx -> (set flags)
	jnz	iterate			; if not zero, load 'iterate' to RIP

      ret
	

section .data
demo1: dq 0x1122334455667788
demo2: db 0x12, 0x20, 0x32, 0x42, 0x52, 0x62, 0x72, 0x82

section .text

_start:
	mov	rdi, [demo1]
	call	print_hex
	call	print_newline

	mov	rdi, [demo2]
	call	print_hex
	call	print_newline

	mov	rax, 60
	xor	rdi, rdi
	syscall	
