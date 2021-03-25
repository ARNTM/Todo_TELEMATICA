            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;                 Ejemplo 1:
            	;Suma dos numeros de 4 bits y convierte el resultado a BCD
            	;para excitar dos displays de 7 segmentos
            	;
            	; (C) Javier Garrigos. Ver. 1.0 - dec,2003
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;declaracion de constantes y variables
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                  
            	CONSTANT	rd_swt, FF      ;CS OE WE A4A3A2A1A0 = 1111 1111
            	CONSTANT 	wini_7seg, 42	;CS OE WE A4A3A2A1A0 = 0100 0010
            	CONSTANT 	wend_7seg, 62	;CS OE WE A4A3A2A1A0 = 0110 0010            
	    	NAMEREG		s4, cont
            	ADDRESS		00		;el programa se cargara a partir de 00            
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:		LOAD		cont, 00	;ponemos a 0 el contador
		INPUT 		s0, rd_swt	;leemos los interruptores
        	LOAD		s1, s0		;copiamos a s1 los interruptores
        	SR0		s1		;y desplazamos para dejar los 4 + signific
        	SR0		s1
        	SR0		s1
        	SR0		s1
        	AND		s0, 0F		;en s0 dejamos los 4 bits - significativos
        	ADD		s0, s1		;hacemos la multiplicacion        		
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	;rutina de conversion de binario a decimal
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bucle:   	ADD		cont, 01	;sumamos 1 al contador y
        	SUB		s0, 0A		;restamos 10 a s0
        	JUMP		NC, bucle	;mientras el resto sea positivo
        	SUB		cont, 01	;con resto negativo decrementamos el cont
        	ADD		s0, 0A		;y s0
        	SL0		cont		;desplazamos a izqda y
        	SL0		cont
        	SL0		cont
        	SL0		cont
        	OR 		s0, cont	;juntamos con la parte menos significat        		
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	;escritura del resultado en el puerto de salida
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	OUTPUT		s0, wini_7seg	;inicio de operacion de escrittura
        	OUTPUT		s0, wend_7seg	;fin de operacion de escritura
        	JUMP		start		;volvemos al inicio        		
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; FIN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;