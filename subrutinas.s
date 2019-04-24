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
@R1 current Category, gives the direction of the Category that is played.
@R2 mask from memory
generate_question:
	push {lr}
	bl aleatorios
	MOV r3,r0
	AND r3,r2
	CMP r3,#0
	BEQ LoadFirst
	CMP r3,#1
	BEQ LoadSecond
	CMP r4,#2
	BEQ LoadThird
	CMP r3,#3
	BEQ LoadFirst
	LoadFirst: 
		LDR r0,[r1]
		B End
	LoadSecond:
		LDR r0,[r1,#4]
		B End
	LoadThird:
		LDR r0,[r1,#8]
		B End
	End:
		pop {pc}
