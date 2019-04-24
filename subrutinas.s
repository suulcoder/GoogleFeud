.text
.align 2
.global checkIfAnswerIsCorrect, generate_question
@Parameters:
@R0: counter
@R1: User guess
@R2: memory of question to use 
@R3: will contain the current correct answet to compare
checkIfAnswerIsCorrect:
	ciclo:
	add r2, r2, #8
	ldr r3, [r2]
	cmp r1, r3
	bne notTheAnswer
	beq isAnAnswer
	notTheAnswer:
	sub r0, r0, #1
	cmp r0, #0
	bne ciclo
	beq fin
	isAnAnswer:
	mov r1, r0
	mov r2, #1000
	mul r0, r0, r2 
	b fin
	fin:  
	mov pc, lr

@Parametrs
@R0 mask from memory where mask is the number of options in binary format
generate_question:
	push {lr}
	loop:
		MOV r1,r0
		bl aleatorios
		MOV r3,r0
		AND r3,r1
		CMP r3,#0
		BEQ loop
	MOV r0,r3	
	pop {pc}
