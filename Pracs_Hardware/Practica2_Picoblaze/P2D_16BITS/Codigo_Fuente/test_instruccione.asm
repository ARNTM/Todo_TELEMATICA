            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;                 
            ;Transmision RS-232 por software. 
            ;115200bps, 8 data bits, no parity, 1 stop bit, no flow control,
            ;parte1: transmite por el puerte serie el contenido de la memoria RAM (64 bytes, portid [0-63])
            ;parte2: genera numeros pseudo-aleatorios, bucle contador+interrupcion para transmitir numero.
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;declaracion de constantes y variables
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                  
            	CONSTANT	rs232, FF		; puerto comunicacion serie es el FF
            						; rx es el bit 0 del puerto FF(entrada)
							; tx es el bit 7 del puerto FF(salida), esto es porque
		;el hyperterminal envia primero el LSB, por eso vamos desplazando a la 
		;izquierda al recibir, y al enviar tambien, con lo que enviamos de nuevo
		;el LSB primero como corresponde para que lo entienda el hyperterminal
        NAMEREG		s1, txreg		;buffer de transmision
        NAMEREG		s2, rxreg		;buffer de recepcion
		NAMEREG		s3, contbit		;contador de los 8 bits de datos
		NAMEREG		s4, cont1		;contador de retardo1
		NAMEREG		s5, cont2		;contador de retardo2
		;
		ADDRESS		0000			;el programa se cargara a partir de la dir 00
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		JUMP prueba
		JUMP Z, prueba
		JUMP NZ, prueba
		JUMP C, prueba
		JUMP NC, prueba
		CALL prueba
		CALL Z, prueba
		CALL NZ, prueba
		CALL C, prueba
		CALL NC, prueba
		RETURN
		RETURN Z
		RETURN NZ
		RETURN C
		RETURN NC
prueba:			
		SR0 s15
		SR1 s9
		SRX s9
		SRA s9
		RR s9		
		SL0 s9
		SL1 s9
		SLX s9
		SLA s9
		RL s9
		
		LOAD s10, B7E0
		AND s10, B7E0
		OR s10, B7E0
		XOR s10, B7E0
		LOAD s10, s15
		AND s10, s15
		OR s10, s15
		XOR s10, s15
		
		ADD s14, B7E0
		ADDCY s14, B7E0
		SUB s14, B7E0
		SUBCY s14, B7E0
		ADD s14, s11
		ADDCY s14, s11
		SUB s14, s11
		SUBCY s14, s11
		
		INPUT s8, B597
		INPUT s8, s12
		OUTPUT s8, B597
		OUTPUT s8, s12
		
		ENABLE INTERRUPT
		DISABLE INTERRUPT

