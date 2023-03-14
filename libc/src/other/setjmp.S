/* This is file is a merger of SETJMP.S and LONGJMP.S */
/*
 *  This file was modified to use the __USER_LABEL_PREFIX__ and
 *  __REGISTER_PREFIX__ macros defined by later versions of GNU cpp by
 *  Joel Sherrill (joel@OARcorp.com)
 *  Slight change: now includes i386mach.h for this (Werner Almesberger)
 *
 * Copyright (C) 1991 DJ Delorie
 * All rights reserved.
 *
 * Redistribution, modification, and use in source and binary forms is permitted
 * provided that the above copyright notice and following paragraph are
 * duplicated in all such forms.
 *
 * This file is distributed WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

 /*
 **	jmp_buf:
 **	 eax ebx ecx edx esi edi ebp esp eip
 **	 0   4   8   12  16  20  24  28  32
 **
 **	Intel MCU jmp_buf:
 **	 ebx esi edi ebp esp eip
 **	 0   4   8   12  16  20
 */

/*
.global setjmp
.type setjmp,@function
setjmp:
	pushl	%ebp
	movl	%esp,%ebp

	pushl	%edi
	movl	8(%ebp),%edi

	movl	%eax,0(%edi)
	movl	%ebx,4(%edi)
	movl	%ecx,8(%edi)
	movl	%edx,12(%edi)
	movl	%esi,16(%edi)

	movl	-4(%ebp),%eax
	movl	%eax,20(%edi)

	movl	0(%ebp),%eax
	movl	%eax,24(%edi)

	movl	%esp,%eax
	addl	$12,%eax
	movl	%eax,28(%edi)
	
	movl	4(%ebp),%eax
	movl	%eax,32(%edi)

	popl	%edi
	movl	$0,%eax
	leave
	ret

.global longjmp 
.type longjmp,@function
longjmp:
	pushl	%ebp
	movl	%esp,%ebp

	movl	8(%ebp),%edi	
	movl	12(%ebp),%eax	
	testl	%eax,%eax
	jne	0f
	incl	%eax
0:
	movl	%eax,0(%edi)

	movl	24(%edi),%ebp

    cli
	movl	28(%edi),%esp
	
	pushl	32(%edi)	

	movl	0(%edi),%eax
	movl	4(%edi),%ebx
	movl	8(%edi),%ecx
	movl	12(%edi),%edx
	movl	16(%edi),%esi
	movl	20(%edi),%edi
    sti

	ret
*./


/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */

#ifdef ENABLE_x86_64
.global __setjmp
.global _setjmp
.global setjmp
.type __setjmp,@function
.type _setjmp,@function
.type setjmp,@function
__setjmp:
_setjmp:
setjmp:
	mov %rbx,(%rdi)         /* rdi is jmp_buf, move registers onto it */
	mov %rbp,8(%rdi)
	mov %r12,16(%rdi)
	mov %r13,24(%rdi)
	mov %r14,32(%rdi)
	mov %r15,40(%rdi)
	lea 8(%rsp),%rdx        /* this is our rsp WITHOUT current ret addr */
	mov %rdx,48(%rdi)
	mov (%rsp),%rdx         /* save return addr ptr for new rip */
	mov %rdx,56(%rdi)
	xor %rax,%rax           /* always return 0 */
	ret

/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.global _longjmp
.global longjmp
.type _longjmp,@function
.type longjmp,@function
_longjmp:
longjmp:
	mov %rsi,%rax           /* val will be longjmp return */
	test %rax,%rax
	jnz 1f
	inc %rax                /* if val==0, val=1 per longjmp semantics */
1:
	mov (%rdi),%rbx         /* rdi is the jmp_buf, restore regs from it */
	mov 8(%rdi),%rbp
	mov 16(%rdi),%r12
	mov 24(%rdi),%r13
	mov 32(%rdi),%r14
	mov 40(%rdi),%r15
	mov 48(%rdi),%rdx       /* this ends up being the stack pointer */
	mov %rdx,%rsp
	mov 56(%rdi),%rdx       /* this is the instruction pointer */
	jmp *%rdx               /* goto saved address without altering rsp */
#endif