            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;                 Ejemplo 2:
            	;Comunicación RS-232 utilizando una UART externa al PicoBlaze
            	;
            	;
            	; (C) Javier Garrigos. Ver. 1.0 - jun,20034
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;declaracion de constantes y variables
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                  
            	CONSTANT	datareg, 02   		; 0000 0010
            	CONSTANT 	controlreg, 01		; 0000 0001
            	CONSTANT 	envia, 02	    	;
	    	CONSTANT	borra, 01		;
		CONSTANT	guion, 81		;guion
		CONSTANT 	punto, 82		;punto
		CONSTANT	lf, 0a			;
		CONSTANT	rtn, 0d			;
            	NAMEREG		s4, cont		;
		;
		ADDRESS		00			;el programa se cargara a partir de 00
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:		;enviamos un guión
		LOAD		s0, guion
		CALL		transmite
		;enviamos un punto
		LOAD		s0, punto
		CALL		transmite
		JUMP		start

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina de transmisión de caracteres
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
transmite:	;esperamos a que el buffer de transmisión esté libre
		INPUT		s1, controlreg
		AND		s1, 40  ; 40=>tx_buffer_empty=1
		JUMP		Z, transmite
		;enviamos el caracter almacenado en s0
		OUTPUT		s0, datareg
		LOAD		s0, envia
		OUTPUT		s0, controlreg
		;esperamos a que coja el dato (buffer de transmisión ocupado)
espera:		INPUT		s1, controlreg
		AND		s1, 40
		JUMP		NZ, espera
		;desactivamos la solicitud de envío
		LOAD		s0, 00
		OUTPUT		s0, controlreg
		RETURN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; FIN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
