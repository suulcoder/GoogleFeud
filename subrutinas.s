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
@R2: user input
@R3: will contain the correct answer
checkIfAnswerIsCorrect:
	push {r4-r12,lr}
	mov r4, #100
	mov r7, #0
	mov r5 ,#0
	mov r6, #0
	ciclo:
		ldrb r5, [r2], #1
		ldrb r6, [r3], #1
		cmp r5, r6
		movne r7, #0
		bne fin
		beq lookingGood
	lookingGood:
		cmp r5, r6
		subeq r4, #1
		mov r7, #1
		cmp r4, #0
		bne ciclo
	fin:
		mov r0, r7
		pop {r4-r12,pc}
@Made by Saul Contreras
@Parametrs 
@R0 answer control
generate_question:
	push {lr}
	ADD r0,#1
	CMP r3,#3         @Check if answer is 3
	MOVEQ r0,#0  
	pop {pc}
