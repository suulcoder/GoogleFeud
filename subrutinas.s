.text
.align 2
.global checkIfAnswerIsCorrect, generate_question
@Parameters:
@R0: counter
@R1: User guess
@R2: memory of question to use 
@R3: will contain the current correct answet to compare
checkIfAnswerIsCorrect:
	push {lr}
	ciclo:
	add r2, r2, #4
	ldr r3, [r2]
	cmp r1, r3
	bne notTheAnswer
	beq isAnAnswer
	notTheAnswer:
	ADD r0, r0, #1
	cmp r0, #10
	blt ciclo
	beq fin
	isAnAnswer:
	mov r1, r0
	mov r0, #10
	sub r0, r1
	add r1, #1
	mov r2, #1000
	mul r0, r0, r2 
	b fin
	fin:  
	pop {pc}
	mov pc, lr

@Parametrs
@R0 answer control
generate_question:
	push {lr}
	ADD r0,#1
	CMP r3,#3
	MOVEQ r0,#0
	pop {pc}
