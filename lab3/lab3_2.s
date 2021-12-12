@ ARM Assembly - lab 3.2 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@GCD(int a,int b){
@	if(b==0){
@		return a;
@	}else{
@		return GCD(b, a%b);
@	}
@}

@ ---------------------	

gcd: @ r0 = a @ r1 =b

@ stack handeling
sub sp, sp, #4
str lr , [sp, #0]


cmp r1, #0 
beq exit  @ if b==0 return a

b mod @cal culate a%b
done:

bl gcd @ branch and link to gcd fn

exit:

@ restore stack and returning
ldr lr , [sp, #0]
add sp, sp, #4
mov pc, lr


mod:
			@ preserving using register values in stack
			sub		sp, sp, #20
			str		r4 , [sp, #16]
			str		r5 , [sp, #12]
			str		r6 , [sp, #8]
			str		r7 , [sp, #4]
			str		r8 , [sp, #0]
			
			mov		r4, #0 @ count  =0

			@ saving initial values of r0, r1
			mov		r6, r0
			mov		r7, r1

			@ getting how many counts need to pass r0, by r1
while:
			cmp		r0, r1
			
			ble		exit_while
			add		r1, r1, r7
			add		r4, r4, #1 @ count++
			b		while
exit_while:
			
			@ calculating count * r1
			mov		r8, #0
			mov		r5, #0
loop:
			cmp		r8, r4
			bgt		exloop
			add		r5, r5, r7
			add		r8, r8, #1
			b		loop
			
			
			
exloop:
			mov		r1, r6 @ resore original value of r0
			sub		r6, r5, r0 @ calculate r0 % r1
			mov		r1, r6 @ r1 = r0 % r1
			mov		r0, r7 @ r0 = r1
			
			@ restoring values
			ldr		r4 , [sp, #16]
			ldr		r5 , [sp, #12]
			ldr		r6 , [sp, #8]
			ldr		r7 , [sp, #4]
			ldr		r8 , [sp, #0]
			add		sp, sp, #20
			b		done


@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "gcd(%d,%d) = %d\n"

