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
	;Cargamos la matriz A en los primeros 9 registros numerados del 0 al 8
	lf	f0,A 		;Cargamos la posicion (0,0)
	lf	f1,A+4 		;Cargamos la posicion (0,1)
	lf	f2,A+8 		;Cargamos la posicion (0,2)
	lf 	f3,A+12 	;Cargamos la posicion (1,0)
	lf	f4,A+16		;Cargamos la posicion (1,1)
	lf 	f5,A+20		;Cargamos la posicion (1,2)
	lf 	f6,A+24 	;Cargamos la posicion (2,0)
	lf	f7,A+28		;Cargamos la posicion (2,1)
	lf 	f8,A+32		;Cargamos la posicion (2,2)

	;Cargamos la matriz B en los siguientes 9 registros numerados del 9 al 17
	lf	f9,B 		;Cargamos la posicion (0,0)
	lf	f10,B+4 	;Cargamos la posicion (0,1)
	lf	f11,B+8 	;Cargamos la posicion (0,2)
	lf 	f12,B+12 	;Cargamos la posicion (1,0)
	lf	f13,B+16	;Cargamos la posicion (1,1)
	lf 	f14,B+20	;Cargamos la posicion (1,2)
	lf 	f15,B+24 	;Cargamos la posicion (2,0)
	lf	f16,B+28	;Cargamos la posicion (2,1)
	lf 	f17,B+32	;Cargamos la posicion (2,2)

	;Multiplicamos A por B, teniendo en cuenta que son matrices y almacenando la matriz resultante en los registros del 18 al 26
	;Primera fila por la primera columna -> posicion (0,0) en la matriz AxB
	multf f18,f0,f9
	multf f19,f1,f12
	multf f20,f2,f15
	addf f18,f18,f19
	addf f18,f18,f20

	;Primera fila por la segunda columna -> posicion (0,1) en la matriz AxB
	multf f19,f0,f10
	multf f20,f1,f13
	multf f21,f2,f16
	addf f19,f19,f20
	addf f19,f19,f21

	;Primera fila por la tercera columna -> posicion (0,2) en la matriz AxB
	multf f20,f0,f11
	multf f21,f1,f14
	multf f22,f2,f17
	addf f20,f20,f21
	addf f20,f20,f22

	;Segunda fila por la primera columna -> posicion (1,0) en la matriz AxB
	multf f21,f3,f9
	multf f22,f4,f12
	multf f23,f5,f15
	addf f21,f21,f22
	addf f21,f21,f23

	;Segunda fila por segunda columna -> posicion (1,1) en la matriz AxB
	multf f22,f3,f10
	multf f23,f4,f13
	multf f24,f5,f16
	addf f22,f22,f23
	addf f22,f22,f24

	;Segunda fila por la tercera columna -> posicion (1,2) en la matriz AxB
	multf f23,f3,f11
	multf f24,f4,f14
	multf f25,f5,f17
	addf f23,f23,f24
	addf f23,f23,f25

	;Tercera fila por la primera columna -> posicion (2,0) en la matriz AxB
	multf f24,f6,f9
	multf f25,f7,f12
	multf f26,f8,f15
	addf f24,f24,f25
	addf f24,f24,f26

	;Tercera fila por la segunda columna -> posicion (2,1) en la matriz AxB
	multf f25,f6,f10
	multf f26,f7,f13
	multf f27,f8,f16
	addf f25,f25,f26
	addf f25,f25,f27

	;Tercera fila por la tercera columna -> posicion (2,3) en la matriz AxB
	multf f26,f6,f11
	multf f27,f7,f14
	multf f28,f8,f17
	addf f26,f26,f27
	addf f26,f26,f28

	;Sumamos A más B, teniendo en cuenta que son matrices y almacenando la matriz resultante en los registros del 0 al 9
	;Esto se debe a que ya no vamos a volver a utilizar A por lo que podemos sobreescribir los registros en los que esta
	;almacenada esta matriz, realizando la suma de A y B sobre si misma
	;Elemento (0,0)
	addf f0,f0,f9

	;Elemento (0,1)
	addf f1,f1,f10

	;Elemento (0,2)
	addf f2,f2,f11

	;Elemento (1,0)
	addf f3,f3,f12

	;Elemento (1,1)
	addf f4,f4,f13

	;Elemento (1,2)
	addf f5,f5,f14

	;Elemento (2,0)
	addf f6,f6,f15

	;Elemento (2,1)
	addf f7,f7,f16

	;Elemento (2,2)
	addf f8,f8,f17

	;Hallamos el determinante de la matriz obtenida al sumar, determinante de A+B
	;Despues con los seis resultados obtenidos realizamos lo siguiente -> Primero + Segundo + Tercero - Cuarto - Quinto - Sexto
	;Almacenamos estos valores en los registros del 10 al 15, donde esta la matriz B que ya no vamos a volver a utilizar
	;Primero
	multf f9,f0,f4
	multf f10,f9,f8

	;Segundo
	multf f9,f3,f7
	multf f11,f9,f2

	;Tercero
	multf f9,f6,f1
	multf f12,f9,f5

	;Cuarto
	multf f9,f2,f4
	multf f13,f9,f6

	;Quinto
	multf f9,f5,f7
	multf f14,f9,f0

	;Sexto
	multf f9,f8,f1
	multf f15,f9,f3

	;Suma final, hacemos el calculo explicado arriba almacenando el resultado en el registro 30
	;El calculo al que hacemos referencia -> Primero + Segundo + Tercero - Cuarto - Quinto - Sexto
	addf f30,f30,f10
	addf f30,f30,f11
	addf f30,f30,f12
	subf f30,f30,f13
	subf f30,f30,f14
	subf f30,f30,f15

	;Dividimos 1 entre el valor del determinante
	;Primero comprobamos que el determinante no sea 0, registro 30, si es 0 acabamos el programa
	eqf f30,f31
	bfpt fin
	;Si no es 0 hacemos la division, 1 entre el valor del determinante, registro 30
	;Previamente cargamos un 1 para poder realizar el calculo
	lf f29,uno
	divf f30,f29,f30

	;Cargamos la matriz C en los registros del 9 al 17, donde habia datos de operaciones anteriores que ya no necesitamos
	;por lo que podemos sobreescribir sin problema
	lf	f9,C 		;Cargamos la posicion (0,0)
	lf	f10,C+4 	;Cargamos la posicion (0,1)
	lf	f11,C+8 	;Cargamos la posicion (0,2)
	lf 	f12,C+12 	;Cargamos la posicion (1,0)
	lf	f13,C+16	;Cargamos la posicion (1,1)
	lf 	f14,C+20	;Cargamos la posicion (1,2)
	lf 	f15,C+24 	;Cargamos la posicion (2,0)
	lf	f16,C+28	;Cargamos la posicion (2,1)
	lf 	f17,C+32	;Cargamos la posicion (2,2)

	;Hacemos el primer escalar presente en la formula, es decir, la matriz AxB por el valor de dividir 1 entre el determinante
	;de A+B almacenado en el registro 30, se trata de multiplicar el valor del registro 30 por cada posicion de la matriz AxB
	multf f18,f18,f30	;Posicion (0,0)	
	multf f19,f19,f30	;Posicion (0,1)	
	multf f20,f20,f30	;Posicion (0,2)	
	multf f21,f21,f30	;Posicion (1,0)	
	multf f22,f22,f30	;Posicion (1,1)	
	multf f23,f23,f30	;Posicion (1,2)	
	multf f24,f24,f30	;Posicion (2,0)	
	multf f25,f25,f30	;Posicion (2,1)	
	multf f26,f26,f30 	;Posicion (2,2)

	;Hacemos el segundo escalar presente en la formula, es decir, el valor alfa que lo cargamos en el registro 30, en el que se
	;encuentra la division de 1 entre el determinante de A+B y que ya no necesitaremos, este producto escalar se realizar
	;de forma analoga al anterior, multiplicamos cada posicion de la matriz C almacenada en los registros del 9 al 17
	;por el valor alfa almacenado en el registro 30
	lf f30,alfa

	multf f9,f9,f30		;Posicion (0,0)	
	multf f10,f10,f30	;Posicion (0,1)	
	multf f11,f11,f30	;Posicion (0,2)	
	multf f12,f12,f30	;Posicion (1,0)	
	multf f13,f13,f30	;Posicion (1,1)	
	multf f14,f14,f30	;Posicion (1,2)	
	multf f15,f15,f30	;Posicion (2,0)	
	multf f16,f16,f30	;Posicion (2,1)	
	multf f17,f17,f30	;Posicion (2,2)


	;Sumamos la matriz resultante del primer producto escalar almacenada en los registros del 18 al 26 con la matriz resultante
	;del segundo producto escalar almacenada en los registros del 9 al 17 y el resultado de esta suma es una matriz que
	;almacenamos en los registros del 0 al 9 donde se encuentra la matriz A+B que ya no necesitamos
	;Elemento (0,0)
	addf f0,f18,f9

	;Elemento (0,1)
	addf f1,f19,f10

	;Elemento (0,2)
	addf f2,f20,f11

	;Elemento (1,0)
	addf f3,f21,f12

	;Elemento (1,1)
	addf f4,f22,f13

	;Elemento (1,2)
	addf f5,f23,f14

	;Elemento (2,0)
	addf f6,f24,f15

	;Elemento (2,1)
	addf f7,f25,f16

	;Elemento (2,2)
	addf f8,f26,f17

	;Por ultimo, almacenamos los valores obtenidos de la suma anterior almacenados en los registros del 0 al 9 en la matriz M
	;Este es el resultado final
	;Elemento (0,0)
	sf M,f0

	;Elemento (0,1)
	sf M+4,f1

	;Elemento (0,2)
	sf M+8,f2

	;Elemento (1,0)
	sf M+12,f3

	;Elemento (1,1)
	sf M+16,f4

	;Elemento (1,2)
	sf M+20,f5

	;Elemento (2,0)
	sf M+24,f6

	;Elemento (2,1)
	sf M+28,f7

	;Elemento (2,2)
	sf M+32,f8

	;Acabamos 
	j fin

fin:
	;Acaba la ejecucion
	trap 0