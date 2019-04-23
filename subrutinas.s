.text
.align 2
.global checkIfAnswerIsCorrect,generate_question
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
@R0 control, gives the directions of a boolean it is false or 0 when the initial interface needs to be desplayed and 1 or true when the question interface is needed
@R1 current Category, gives the direction of the Category that is played. 
@R2 All initial interface, gives the direction of the initial interface
@R3 interface, gives the direction that are changed
generate_question:
	
	CMP r0, #0
	BEQ InitialInterface
	CMP r0, #1
	BEQ questionInterface

	@if initial interface is asked
	InitialInterface:
		pop {r0,r1}
		MOV r1,#12
		loop:		
			LDR r0,[r3,#4]
			pop {r3}
			LDR r3,[r2,#4]
			STR r0,r3
			push {r3}
			SUB r0,#1
			CMP r0,#0
			BNE loop
			push {r0,r1}
			B end

	questionInterface:
		@Generate question

	end:
		mov pc, lr