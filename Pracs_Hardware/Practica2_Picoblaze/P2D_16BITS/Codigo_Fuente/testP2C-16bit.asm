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
		ADDRESS		00			;el programa se cargara a partir de la dir 00
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Inicio del programa
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		DISABLE INTERRUPT
start:		CALL		recibe
		;Instrucciones para la parte1
		LOAD		S7,00
parte1:		INPUT		txreg,S7
		ADD		txreg,00
		JUMP Z		parte2
		CALL		transmite
		ADD		S7,01
		JUMP		parte1
		;Instrucciones para la parte2
parte2:		ENABLE INTERRUPT
bucle1:		LOAD 		S6,09
bucle2:		SUB		S6,01
		JUMP NZ		bucle2
		LOAD		S6,09
		JUMP		bucle2
		
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
            	;clk=50MHz, 9600bps, cont1=0A, cont2=80
            	;esta rutina ejecuta 1 + (1 + 10*(1 + 128*2 + 2)) + 1 = 2593 instruciones,
            	;aproximandose al numero teorico de (104,16us/bit)/(0,04 us/instruc) = 2604,166 instr/bit necesarias.
            	;clk=40MHz, 57600bps, cont1=05, cont2=21
            	;esta rutina ejecuta 1 + (1 + 5*(1 + 33*2 + 2)) + 1 =  instruciones,
            	;aproximandose al numero teorico de (17,36us/bit)/(0,05 us/instruc) = 347,2 instr/bit necesarias.
            	;clk=50MHz, 115200bps, cont1=03, cont2=22
            	;esta rutina ejecuta 1 + (1 + 3*(1 + 34*2 + 2)) + 1 = 216 instruciones,
            	;aproximandose al numero teorico de (8,68us/bit)/(0,04 us/instruc) = 217 instr/bit necesarias.
            	;clk=50MHz, 230400bps, cont1= 03, cont2= 10
            	;esta rutina ejecuta 1 + (1 + 3*(1 + 16*2 + 2)) + 1 = 108 instruciones,
            	;aproximandose al numero teorico de (4,34us/bit)/(0,04 us/instruc) = 108,5 instr/bit necesarias.
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;OJO: con el USB2COM no he conseguido pasar de los 230400bps bien. 
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;clk=50MHz, 460800bps, cont1= 03, cont2=06 OJO:Hay que ponerle 1 menos a cont2 y que tome 
            	;caracteres ascii de 7 bits para que funcione.
            	;esta rutina ejecuta 1 + (1 + 3*(1 + 7*2 + 2)) + 1 = 54 instruciones,
            	;aproximandose al numero teorico de (2,17us/bit)/(0,04 us/instruc) = 54,25 instr/bit necesarias.
            	;clk=50MHz, 921600bps, cont1=01, cont2=0A NO FUNCIONA
            	;esta rutina ejecuta 1 + (1 + 1*(1 + 10*2 + 2)) + 1 = 26 instruciones,
            	;aproximandose al numero teorico de (1,085us/bit)/(0,04 us/instruc) = 27,127 instr/bit necesarias.
wait_1bit:	LOAD 		cont1, 03  
espera2:	LOAD		cont2, 22
espera1:	SUB		cont2, 01
		JUMP		NZ, espera1
		SUB		cont1, 01
		JUMP		NZ, espera2
		RETURN
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;Rutina espera 0,5 bits (bit de inicio, a 9600bps)
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;clk=50MHz, 9600bps, cont1=05, cont2=80
            	;1 + (1 + 5*(1 + 128*2 + 2)) + 1 = 1298; aprox = 1302
            	;clk=40MHz, 57600bps, cont1=03, cont2=1B
            	;1 + (1 + 3*(1 + 27*2 + 2)) + 1 = 1298; aprox = 173.6
		;clk=50MHz, 115200bps, cont1=03, cont2=10
            	;1 + (1 + 3*(1 + 16*2 + 2)) + 1 = 108; aprox = 108.5
            	;clk=50MHz, 230400bps, cont1= 03, cont2= 07
            	;1 + (1 + 3*(1 + 7*2 + 2)) + 1 = 54; aprox = 54,25
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;OJO: con el USB2COM no he conseguido pasar de los 230400bps bien. 
            	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            	;clk=50MHz, 460800bps, cont1= 01, cont2= 0A
            	;1 + (1 + 1*(1 + 10*2 + 2)) + 1 = 26; aprox = 27,125
            	;clk=50MHz, 921600bps, cont1=01, cont2=04 NO FUNCIONA
            	;1 + (1 + 1*(1 + 4*2 + 2)) + 1 = 14; aprox = 13,56
wait_05bit:	LOAD 		cont1, 03 
espera4:	LOAD		cont2, 10
espera3:	SUB		cont2, 01
		JUMP		NZ, espera3
		SUB		cont1, 01
		JUMP		NZ, espera4
		RETURN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; FIN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; RUTINA DE ATENCION A LA INTERRUPCIÓN
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
interrup:	DISABLE 	INTERRUPT
		CALL 		recibe
		FLIP		rxreg
		LOAD 		txreg,rxreg
		CALL 		transmite
		ADD		S6,30
		LOAD 		txreg,S6
		CALL 		transmite
		RETURNI		ENABLE
		ADDRESS		FF
		JUMP		interrup

