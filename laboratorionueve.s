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
	.asciz "El valor asignado a la casilla de no asistencia es %d\n"

mensaje:
	.asciz "Ingrese dato:"

mask: .byte 0x3 
Questions1: .asciz "what body parts can you"
Answer11: .asciz "sell"
Answer12: .asciz "live without"
Answer13: .asciz "eat"
Answer14: .asciz "donate"
Answer15: .asciz "pierce"
Answer16: .asciz "crack"
Answer17: .asciz "use in soccer"
Answer18: .asciz "fill with bees" 
Answer19: .asciz "donate and still live"
Answer10: .asciz "sprain"
Question1: .word Questions1,Answer11,Answer12,Answer13,Answer14,Answer15,Answer16,Answer17,Answer18,Answer19,Answer10 

Questions2: .asciz "how do you make"
Answer21: .asciz "slime"
Answer22: .asciz "french toast"
Answer23: .asciz "buttermilk"
Answer24: .asciz "brown"
Answer25: .asciz "caramel"
Answer26: .asciz "almond milk"
Answer27: .asciz "gravy"
Answer28: .asciz "meatloaf" 
Answer29: .asciz "whipped cream"
Answer20: .asciz "chili"
Question2: .word Questions2,Answer21,Answer22,Answer23,Answer24,Answer25,Answer26,Answer27,Answer28,Answer29,Answer20 

Questions3: .asciz "can i perform my own"
Answer31: .asciz "wedding"
Answer32: .asciz "marriage"
Answer33: .asciz "nikah"
Answer34: .asciz "home inspection"
Answer35: .asciz "circumcision"
Answer36: .asciz "liposuction"
Answer37: .asciz "membran sweep"
Answer38: .asciz "background check" 
Answer39: .asciz "stretch and sweep"
Answer30: .asciz "tittle search"
Question3: .word Questions3,Answer31,Answer32,Answer33,Answer34,Answer35,Answer36,Answer37,Answer38,Answer39,Answer30 

@Here we store an array with memory directions. Each question has one
Questions: .word Question1,Question2,Question3

.text
.align 2
.global main
.type main,%function

main:
	
	LDR r1,=Questions
	LDR r2,=mask
	LDRB r2,[r2]
	bl generate_question

