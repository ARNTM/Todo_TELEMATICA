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
		NAMEREG 	s0, multiplicand 	; preserved
		NAMEREG 	s1, multiplier 		; preserved
		NAMEREG 	s2, bit_mask 		; modified
		NAMEREG 	s3, result_msb 		; most-significant byte (MSB) of result,
							; modified
		NAMEREG 	s4, result_lsb  	; least-significant byte (LSB) of result,
							; modified
		;                
            	ADDRESS		00		;el programa se cargara a partir de 00
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:		INPUT		s0, 00		;cargamos el multiplicando
		INPUT		s1, 01		;cargamos el multiplicador
		CALL		mult_8x8	;hacemos la multiplicacion
		JUMP		start
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina de multiplicacion
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mult_8x8:	LOAD 		bit_mask, 01 		; start with least-significant bit (lsb)
		LOAD 		result_msb, 00 		; clear product MSB
		LOAD 		result_lsb, 00 		; clear product LSB (not required)
		; loop through all bits in multiplier
mult_loop: 	LOAD		s4, multiplier
		AND 		s4, bit_mask 		; check if bit is set
		JUMP 		Z, no_add 		; if bit is not set, skip addition
		ADD 		result_msb, multiplicand ; addition only occurs in MSB
no_add: 	;SRA 		result_msb 		; shift MSB right, CARRY into bit 7,
							; lsb into CARRY
		;SRA 		result_lsb 		; shift LSB right,
							; lsb from result_msb into bit 7
		SL0 		bit_mask 		; shift bit_mask left to examine
							; next bit in multiplier
		JUMP 		NZ, mult_loop 		; if all bit examined, then bit_mask = 0,
							; loop if not 0
		RETURN 					; multiplier result now available in
							; result_msb and result_lsb
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; FIN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;