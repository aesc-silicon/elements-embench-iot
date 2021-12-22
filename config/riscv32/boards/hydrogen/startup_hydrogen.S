.section .init
.globl _start
.type _start,@function


_start:
#ifdef USE_GP
.option push
.option norelax
	la gp, __global_pointer$
.option pop
#endif

init:
	la sp, _sp

#	/* Load data section */
#	la a0, _data_lma
#	la a1, _data
#	la a2, _edata
#	bgeu a1, a2, after1
#before1:
#	lw t0, (a0)
#	sw t0, (a1)
#	addi a0, a0, 4
#	addi a1, a1, 4
#	bltu a1, a2, before1
#after1:

	/* Clear bss section */
	la a0, __bss_start
	la a1, _end
	bgeu a0, a1, after2
before2:
	sw zero, (a0)
	addi a0, a0, 4
	bltu a0, a1, before2
after2:

	call __libc_init_array
	call main
mainDone:
	j mainDone


.globl _init
_init:
	ret

#ifdef SMP
.bss
.align 2
	smp_lottery_target: .word 0
	smp_lottery_lock:   .word 0
#endif
