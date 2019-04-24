@  Llamado aleatorios

	@@ codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	@@ etiqueta "main" llama a la funcion global
	.global		main
	.type		main, %function
main:
	@@ grabar registro de enlace en la pila
	stmfd	sp!, {lr}
	
	bl aleatorios

	mov r1,r0
	ldr r0,=numero
	bl printf
	
	@@ r0, r3 <- 0 como sennal de no error al sistema operativo
	mov	r3, #0
	mov	r0, r3

	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr
.data
.align 2

num1:	.word 4
num2:	.byte 6
car1:	.byte 'J'

Lmessage:
	.asciz "Mensaje"
numero:
	.asciz " %d\n"
letra:
	.asciz " %c\n"
cadena:
	.asciz " %s\n"
combinado:
	.asciz "%d %d %c\n"
