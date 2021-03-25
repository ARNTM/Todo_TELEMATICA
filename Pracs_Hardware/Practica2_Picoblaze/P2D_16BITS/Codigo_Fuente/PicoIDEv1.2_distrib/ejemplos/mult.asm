		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;                 Ejemplo 4:
            	;multiplica dos numeros de 8 bits 
            	;
            	; (C) Javier Garrigos. Ver. 1.0 - sep,2004
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;declaracion de constantes y variables
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
		NAMEREG 	s0, multiplicando 	
		NAMEREG 	s1, multiplicador 		
		NAMEREG 	s2, bit_mask 		
		NAMEREG 	s3, result_msb 		
		NAMEREG 	s4, result_lsb  	
		;                
            	ADDRESS		00		;el programa se cargara a partir de 00
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:		INPUT		s0, 00		;cargamos el multiplicando
		INPUT		s1, 01		;cargamos el multiplicador
		CALL		mult		;hacemos la multiplicacion
		JUMP		start
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina de multiplicacion
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mult:		LOAD 		bit_mask, 01 		; comenzamos con el LSB
		LOAD 		result_msb, 00 		; inicializamos producto MSB
		LOAD 		result_lsb, 00 		; inicializamos producto LSB
		; para los 8 bits del multiplicador
mult_loop:	LOAD		s4, multiplicador	;
		AND 		s4, bit_mask	 	; si el bit del multiplicador esta a 1
		JUMP 		Z, no_add 		; si no, no hace la suma
		ADD 		result_msb, multiplicando	; 
no_add: 	SRA 		result_msb 		; shift MSB right, CARRY into bit 7, lsb into CARRY
		SRA 		result_lsb 		; shift LSB right, lsb from result_msb into bit 7
		SL0 		bit_mask 		; shift bit_mask left to examine next bit in multiplier
		JUMP 		NZ, mult_loop 		; if all bit examined, then bit_mask = 0, loop if not 0
		OR		s0, s1
		XOR		s1, s0
		RETURN 					; multiplier result now available in result_msb and result_lsb
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; FIN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;