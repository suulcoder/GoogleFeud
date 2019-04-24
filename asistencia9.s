/*Universidad del valle de Guatemala*/
/*Tarea de Asistencia 9*/

/*Ejemplo de NE*/
/*Codigo en Java*/

/*if(R1!=R2){
	R1 = R1 * R2
}*/

/*Codigo en ARM*/
CMP R1,R2
MULNE R1,R1,R2

/*Ejemplo de LE*/
/*Codigo en Java*/

/*if(R1<=R2){
	R1 = R1 - R2
}*/

/*Codigo en ARM*/
CMP R1,R2
SUBLE R1,R1,R2

/*Ejemplo de GT*/
/*Codigo en Java*/

/*if(R1>R2){
	R1 = R1 + R2
}*/

/*Codigo en ARM*/
CMP R1,R2
ADDGT R1,R1,R2

