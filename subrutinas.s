@GoogleFeud
@Universidad del valle de Guatemala
@Proyecto 3 Assembler
@Saul Contreras 18409
@Michele Benvenuto 
@Este programa representa una copia programada en ARM de la API de Google, Google Feud disponible en
@www.googlefeud.com

.text
.align 2
.global checkIfAnswerIsCorrect, generate_question
@Made by michele Benvenuto
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
	eor r3,r1
	CMP r3, #0
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
	b fin
	fin:  
	pop {pc}
	mov pc, lr

@Made by Saul Contreras
@Parametrs 
@R0 answer control
generate_question:
	push {lr}
	ADD r0,#1
	CMP r3,#3         @Check if answer is 3
	MOVEQ r0,#0  
	pop {pc}
