            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;                 Ejemplo 3:
            ;Transmision RS-232 por software. 
            ;9600bps, 8 data bits, no parity, 1 stop bit, no flow control,
            ; (C) Javier Garrigos. Ver. 1.0 - sep,2004
            ; Ver. 1.2 - mayo, 2005(utiliza SR0 en lugar de SL0 para mejorar compatibilidad con hyperterminal)
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;declaracion de constantes y variables
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                  
            	CONSTANT	rs232, 00		; puerto comunicacion serie es el 00
            						; rx es el bit 0 del puerto 00(entrada)
							; tx es el bit 7 del puerto 00(salida), esto es porque
		;el hyperterminal envia primero el LSB, por eso vamos desplazando a la 
		;izquierda al recibir, y al enviar tambien, con lo que enviamos de nuevo
		;el LSB primero como corresponde para que lo entienda el hyperterminal
            	NAMEREG		s1, txreg		;buffer de transmision
            	NAMEREG		s2, rxreg		;buffer de recepcion
		NAMEREG		s3, contbit		;contador de los 8 bits de datos
		NAMEREG		s4, cont1		;contador de retardo1
		NAMEREG		s5, cont2		;contador de retardo2
		;
		ADDRESS		00			;el programa se cargara a partir de la dir 00
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:		;esperamos a recibir un caracter
		CALL		recibe
		;copiamos el caracter recibido al buffer de transmision
		LOAD		txreg, rxreg
		;ADD		txreg, 01
		;hacemos el eco del caracter recibido
		CALL		transmite
		JUMP		start
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina de recepcion de caracteres
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
recibe:		;esperamos a que se reciba un bit de inicio
		INPUT		rxreg, rs232
		AND		rxreg, 80
		JUMP		NZ, recibe
		CALL		wait_05bit
		;almacenamos los 8 bits de datos
		LOAD		contbit,09
next_rx_bit:	CALL		wait_1bit
		SR0		rxreg
		INPUT		s0, rs232
		AND		s0, 80
		OR		rxreg, s0
		SUB 		contbit, 01
		JUMP		NZ, next_rx_bit
		RETURN
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina de transmision de caracteres
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
transmite:	;enviamos un bit de inicio
		LOAD		s0, 00
		OUTPUT		s0, rs232
		CALL		wait_1bit
		;enviamos los 8 bits de datos
		LOAD 		contbit, 08
next_tx_bit:	OUTPUT		txreg, rs232
		CALL		wait_1bit
		SR0		txreg
		SUB 		contbit, 01
		JUMP		NZ, next_tx_bit
		;enviamos un bit de parada
		LOAD		s0, FF
		OUTPUT		s0, rs232
		CALL		wait_1bit
		RETURN
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina espera 1 bit (a 9600bps)
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wait_1bit:	LOAD 		cont1, 0A ;esta rutina ejecuta 1 + (1 + 10*(1 + 128*2 + 2)) + 1 = 2593 instruciones, 
		; aproximandose al numero teorico de (104,16us/bit)/(0,04 us/instruc) = 2604,1666 instr/bit necesarias.
espera2:	LOAD		cont2, 80
espera1:	SUB		cont2, 01
		JUMP		NZ, espera1
		SUB		cont1, 01
		JUMP		NZ, espera2
		RETURN
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina espera 0,5 bits (bit de inicio, a 9600bps)
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wait_05bit:	LOAD 		cont1, 05 ;1 + (1 + 5*(1 + 128*2 + 2)) + 1 = 1298; aprox = 1302
espera4:	LOAD		cont2, 80
espera3:	SUB		cont2, 01
		JUMP		NZ, espera3
		SUB		cont1, 01
		JUMP		NZ, espera4
		RETURN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; FIN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
