;Practica DLX
;Alberto Hernandez Pintor
;Miguel Cabezas Puerto
;07/04/2019

	.data

;Espacio de datos
	;Matrices A, B y C de tamaño 3x3 para realizar los calculos
	;Variable alfa pedida en el enunciado para el cálculo de un producto escalar
	;Variable uno que almacena un 1 necesario para poder realizar la division de 1 entre el determinante
	;Matriz M donde se alamacenará el resultado final

A:	.float	1.000000,	1.000000,	0.00000
	.float	0.000000,	1.000000,	2.00000
	.float	2.000000,	0.000000,	1.00000

B:	.float	2.000000,	1.000000,	1.000000
	.float	0.000000,	1.000000,	2.000000
	.float	0.000000,	2.000000,	0.000000

C:	.float	1.000000,	0.000000,	0.000000
	.float	0.000000,	1.000000,	0.000000
	.float	0.000000,	0.000000,	1.000000

alfa:
	.float	1.0

uno:
	.float 	1.0

M:	.float	0.0,	0.0,	0.0
	.float	0.0,	0.0,	0.0
	.float	0.0,	0.0,	0.0

	.text
	.global main

;Programa
main:
	;Cargamos lo necesario para la primera operacion y una posicion mas ya que como la operacion de multiplicacion siguiente
	;utiliza los registros cargados, necesitamos de una operacion de carga mas para que la multiplicacion no tenga que esperar
	;por los datos, a esta conclusion hemos llegado tras sucesivas pruebas como explicamos en el informe
	lf	f0,A 			;Cargamos la posicion (0,0) matriz A
	lf	f9,B 			;Cargamos la posicion (0,0) matriz B
	lf	f1,A+4 			;Cargamos la posicion (0,1) matriz A

	;Como explicaremos en el informe tras varias pruebas llegamos a la conclusion de que lo mas optimo es multf-lf/sf-lf/sf
	;o multf-lf/sf-addf, ademas ha sido necesario mezclar varias operaciones de tal forma que no se hace primero la primera 
	;fila de A por primera columna B completo si no que mientras hacemos otra operacion como primera fila de A por segunda
	;fila de B podremos meter operaciones que nos hayan quedado pendientes para intentar conseguir las sucesiones mas optimas
	;encontradas, a todo esto hay que sumarle que para que no se produzcan esperas al realizar una operacion que necesita
	;de un dato que se carga previamente o que resulta de una operacion previa, hay que separar convenientemente un
	;determinado numero de ciclos una operacion de otra

	;Comenzamos la multiplicacion de la primera fila de A por la primera columna de B 
	multf f18,f0,f9
	lf 	f12,B+12 		;Cargamos la posicion (1,0) matriz B
	lf 	f15,B+24 		;Cargamos la posicion (2,0) matriz B
	
	multf f19,f1,f12
	lf	f10,B+4 		;Cargamos la posicion (0,1) matriz B
	lf	f13,B+16		;Cargamos la posicion (1,1) matriz B

	multf f20,f2,f15
	lf	f16,B+28		;Cargamos la posicion (2,1) matriz B
	addf f18,f18,f19

	;Comenzamos la multiplicacion de la primera fila de A por la segunda columna de B
	multf f19,f0,f10
	lf	f11,B+8 		;Cargamos la posicion (0,2) matriz B
	addf f18,f18,f20	;Esta suma pertenece al resultado final de multiplicar la primera fila de A por la primera columna de B
						;se corresponde con la posicion (0,0) de la matriz AxB

	multf f20,f1,f13
	lf 	f14,B+20		;Cargamos la posicion (1,2) matriz B
	lf 	f17,B+32		;Cargamos la posicion (2,2) matriz B

	multf f21,f2,f16
	lf	f2,A+8 			;Cargamos la posicion (0,2) matriz A
	addf f19,f19,f20

	;Comenzamos la multiplicacion de la primera fila de A por la tercera columna de B
	multf f20,f0,f11
	lf 	f3,A+12 		;Cargamos la posicion (1,0) matriz A
	addf f19,f19,f21  	;Esta suma pertenece al resultado final de multiplicar la primera fila de A por la segunda columna de B
						;se corresponde con la posicion (0,1) de la matriz AxB

	multf f21,f1,f14
	lf	f4,A+16			;Cargamos la posicion (1,1) matriz A
	addf f0,f0,f9 		;Primera posicion (0,0) de la matriz A+B, como ya no utilizamos f0 podemos sobreescribir

	multf f22,f2,f17
	lf 	f5,A+20			;Cargamos la posicion (1,2) matriz A
	addf f20,f20,f21
	
	;Comenzamos la multiplicacion de la segunda fila de A por la primera columna de B
	multf f21,f3,f9
	lf 	f6,A+24 		;Cargamos la posicion (2,0)
	addf f20,f20,f22 	;Esta suma pertenece al resultado final de multiplicar la primera fila de A por la tercera columna de B
						;se corresponde con la posicion (0,2) de la matriz AxB

	multf f22,f4,f12
	lf	f7,A+28			;Cargamos la posicion (2,1) matriz A
	addf f1,f1,f10 		;Segunda posicion (0,1) de la matriz A+B, como ya no utilizamos f1 podemos sobreescribir

	multf f23,f5,f15
	lf 	f8,A+32			;Cargamos la posicion (2,2) matriz A
	addf f21,f21,f22

	;Comenzamos la multiplicacion de la segunda fila de A por la segunda columna de B
	multf f22,f3,f10
	addf f21,f21,f23 	;Esta suma pertenece al resultado final de multiplicar la segunda fila de A por la primera columna de B
						;se corresponde con la posicion (1,0) de la matriz AxB

	multf f23,f4,f13
	addf f2,f2,f11 		;Tercera posicion (0,2) de la matriz A+B, como ya no utilizamos f2 podemos sobreescribir

	multf f24,f5,f16
	addf f22,f22,f23

	;Comenzamos la multiplicacion de la segunda fila de A por la tercera columna de B
	multf f23,f3,f11
	addf f22,f22,f24 	;Esta suma pertenece al resultado final de multiplicar la segunda fila de A por la segunda columna de B
						;se corresponde con la posicion (1,1) de la matriz AxB

	multf f24,f4,f14
	addf f3,f3,f12 		;Cuarta posicion (1,0) de la matriz A+B, como ya no utilizamos f3 podemos sobreescribir

	multf f25,f5,f17
	addf f23,f23,f24

	;Comenzamos la multiplicacion de la tercera fila de A por la primera columna de B
	multf f24,f6,f9
	addf f23,f23,f25 	;Esta suma pertenece al resultado final de multiplicar la segunda fila de A por la tercera columna de B
						;se corresponde con la posicion (1,2) de la matriz AxB

	multf f25,f7,f12
	addf f4,f4,f13 		;Quinta posicion (1,1) de la matriz A+B, como ya no utilizamos f4 podemos sobreescribir

	multf f26,f8,f15
	addf f24,f24,f25

	;Comenzamos la multiplicacion de la tercera fila de A por la segunda columna de B
	multf f25,f6,f10
	addf f24,f24,f26 	;Esta suma pertenece al resultado final de multiplicar la tercera fila de A por la primera columna de B
						;se corresponde con la posicion (2,0) de la matriz AxB

	multf f26,f7,f13
	addf f5,f5,f14 		;Sexta posicion (1,2) de la matriz A+B, como ya no utilizamos f5 podemos sobreescribir

	multf f27,f8,f16
	addf f25,f25,f26

	;Comenzamos la multiplicacion de la tercera fila de A por la tercera columna de B
	multf f26,f6,f11
	addf f25,f25,f27 	;Esta suma pertenece al resultado final de multiplicar la tercera fila de A por la segunda columna de B
						;se corresponde con la posicion (2,1) de la matriz AxB

	multf f27,f7,f14
	addf f6,f6,f15 		;Septima posicion (2,0) de la matriz A+B, como ya no utilizamos f6 podemos sobreescribir

	multf f28,f8,f17
	addf f8,f8,f17 		;Novena posicion (2,2) de la matriz A+B, como ya no utilizamos f8 podemos sobreescribir

	;Comenzamos a calcular el determiante de A+B
	multf f9,f0,f4
	addf f7,f7,f16 		;Octava posicion (2,1) de la matriz A+B, como ya no utilizamos f7 podemos sobreescribir

	multf f10,f9,f8 	;Primer sumando del determinante
	addf f26,f26,f27

	multf f9,f3,f7
	addf f26,f26,f28 	;Esta suma pertenece al resultado final de multiplicar la tercera fila de A por la tercera columna de B
						;se corresponde con la posicion (2,2) de la matriz AxB

	multf f11,f9,f2 	;Segundo sumando del determinante
	addf f30,f30,f10 	;Sumamos el primer componente del determinate, registro f10

	multf f9,f6,f1
	addf f30,f30,f11 	;Sumamos el segundo componente del determinante, registro f11

	multf f12,f9,f5 	;Tercer sumando del determinante

	multf f9,f2,f4
	addf f30,f30,f12 	;Sumamos el tercer componente del determinante, registro f12

	multf f13,f9,f6 	;Primer sustraendo del determiante

	multf f9,f5,f7
	subf f30,f30,f13  	;Restamos el cuarto componente del determinante, registro f13

	multf f14,f9,f0 	;Segundo sustraendo del determiante

	multf f9,f8,f1
	subf f30,f30,f14 	;Restamos el quinto componente del determinante, registro f14

	multf f15,f9,f3 	;Tercer sustraendo del determiante
	lf f29,uno 			;Cargamos la variable uno necesaria para realizar la division
	subf f30,f30,f15 	;Restamos el sexto componente del determinante, registro f15

	eqf f30,f31 		;Comprobamos si el determinante es 0
	bfpt fin 			;Si es 0 finalizamos el programa
	divf f30,f29,f30  	;Si no es 0 dividimos 1 entre el resultado del determinante

	;Comenzamos a calcular el primer producto escalar, la matriz AxB por el valor resultante de la division y a la par
	;cargamos C
	multf f18,f18,f30	;Posicion (0,0)	
	lf	f9,C 			;Cargamos la posicion (0,0) matriz C
	lf	f10,C+4 		;Cargamos la posicion (0,1) matriz C

	multf f19,f19,f30	;Posicion (0,1)	
	lf	f11,C+8 		;Cargamos la posicion (0,2) matriz C
	lf 	f12,C+12 		;Cargamos la posicion (1,0) matriz C

	multf f20,f20,f30	;Posicion (0,2)	
	lf	f13,C+16		;Cargamos la posicion (1,1) matriz C
	lf 	f14,C+20		;Cargamos la posicion (1,2) matriz C

	multf f21,f21,f30	;Posicion (1,0)	
	lf 	f15,C+24 		;Cargamos la posicion (2,0) matriz C
	lf	f16,C+28		;Cargamos la posicion (2,1) matriz C

	multf f22,f22,f30	;Posicion (1,1)	
	lf 	f17,C+32		;Cargamos la posicion (2,2) matriz C

	multf f23,f23,f30	;Posicion (1,2)	
	multf f24,f24,f30	;Posicion (2,0)	
	multf f25,f25,f30	;Posicion (2,1)	
	multf f26,f26,f30 	;Posicion (2,2)

	lf f30,alfa  		;Cargamos la varibale alfa necesaria para el segundo producto escalar

	;Comenzamos a calcular el segundo producto escalar, la matriz C por el valor de alfa, al mismo tiempo realizamos la suma
	;final y lo almacenamos en M
	multf f9,f9,f30		;Posicion (0,0)	
	multf f10,f10,f30	;Posicion (0,1)	
	addf f0,f18,f9 		;Posicion (0,0) matriz M

	multf f11,f11,f30	;Posicion (0,2)
	sf M,f0	 			;Guardamos la primera posicion en M
	addf f1,f19,f10 	;Posicion (0,1) matriz M

	multf f12,f12,f30	;Posicion (1,0)
	sf M+4,f1 			;Guardamos la segunda posicion en M
	addf f2,f20,f11 	;Posicion (0,2) matriz M

	multf f13,f13,f30	;Posicion (1,1)
	sf M+8,f2	 		;Guardamos la tercera posicion en M
	addf f3,f21,f12 	;Posicion (1,0) matriz M

	multf f14,f14,f30	;Posicion (1,2)
	sf M+12,f3  		;Guardamos la cuarta posicion en M
	addf f4,f22,f13 	;Posicion (1,1) matriz M

	multf f15,f15,f30	;Posicion (2,0)	
	sf M+16,f4 			;Guardamos la quinta posicion en M
	addf f5,f23,f14 	;Posicion (1,2) matriz M

	multf f16,f16,f30	;Posicion (2,1)	
	sf M+20,f5 			;Guardamos la sexta posicion en M
	addf f6,f24,f15 	;Posicion (2,0) matriz M

	multf f17,f17,f30	;Posicion (2,2)
	sf M+24,f6  		;Guardamos la septima posicion en M
	addf f7,f25,f16 	;Posicion (2,1) matriz M

	addf f8,f26,f17 	;Posicion (2,2) matriz M
	sf M+28,f7 			;Guardamos la octava posicion en M
	sf M+32,f8  		;Guardamos la novena posicion en M

	;Acabamos 
	j fin

fin:
	;Acaba la ejecucion
	trap 0