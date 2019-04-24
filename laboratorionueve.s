/*Universidad del valle de Guatemala*/
/*Saul Contreras*/
/*18409*/
/*Laboratorio nueve*/

.data
.align 2

asistencia:
	.word 0

no_asistencia:
	.word 0

a:
	.word 0

entrada:
	.asciz "%d"

asignado:
	.asciz "El valor asignado en asistencia es %d\n"

no_asignado:
	.asciz "El valor asignado a la casilla de no asistencia es %b\n"

mensaje:
	.asciz "Ingrese dato:"

mask: .word 0x3
.text
.align 2
.global main
.type main,%function

main:
	
	loop:
		bl aleatorios
		MOV r3,r0
		MOV r1,r3
		LDR r0,=asignado
		bl printf
		AND r3,#3
		MOV r1,r3
		LDR r0,=asignado
		bl printf
		CMP r3,#0
		BEQ loop
