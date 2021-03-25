; _____ _____ _____      _____   _____      __  __                 _       
;|  __ \_   _/ ____|    |  __ \ / ____|    |  \/  |               | |      
;| |__) || || |     __ _| |__) | |   ______| \  / | __ _ _ __   __| | ___  
;|  ___/ | || |    / _` |  _  /| |  |______| |\/| |/ _` | '_ \ / _` |/ _ \ 
;| |    _| || |___| (_| | | \ \| |____     | |  | | (_| | | | | (_| | (_) |
;|_|   |_____\_____\__,_|_|  \_\\_____|    |_|  |_|\__,_|_| |_|\__,_|\___/
;-------------------------------------------------------
			LIST p=16F876A
			INCLUDE "p16f876a.inc"
			__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
TOKEN		EQU		0x20
VALORB		EQU		0x21
XOR			EQU		0x22
M			EQU		0x23
O			EQU		0x24
VEL			EQU		0x25
N			EQU		0x26
;-------------------------------------------------------
			ORG 	0
			goto 	inicio

			ORG 	4
			goto 	ISR
			ORG 	5
;-------------------------------------------------------

inicio
			MOVLW	'ç' ; Siempre mandaremos primero esto para asegurarnos de que no existan interferencias con otros mandos
			MOVWF	TOKEN ; Cargamos ç en TOKEN

			MOVF	PORTB,0 
			MOVWF	VALORB ; Hacemos copia de PORTB en VALORB, pasando por WREG (PORTB --> WREG --> VALORB)

			BSF	STATUS,RP0 ; Cambiamos al banco 1
			
			MOVLW	b'11111111'
			MOVWF	TRISB ; Ponemos PORTB como entrada
			MOVWF	TRISA ; Ponemos PORTA como entrada

;##### Configuramos las entradas de PORTA como analógicas, ver página 112 para saber los valores de cada bit. ####	
			BCF		ADCON1, ADFM ; Alineamos a la izquierda
			BCF		ADCON1, PCFG0
			BCF		ADCON1, PCFG1
			BCF		ADCON1, PCFG2
			BCF		ADCON1, PCFG3
;#################################################################################################################

			MOVLW 	.25
			MOVWF 	SPBRG ; Asignamos el ratio de baudios para el modo asincrono (VER EN LA TABLA DEL MANUAL REDUCIDO, SE PUDE ENCONTRAR EN LA PAGINA 98) 

			BSF 	TXSTA, BRGH ; Activamos el BIT para que el modo asincrono sea a baja velocidad (también se ve en la tabla)
			BSF		TXSTA, TXEN ; Activamos el BIT que habilita la transmisión

			BCF		OPTION_REG, T0CS ; Ponemos el BIT T0CS a 0 para indicar que usamos el reloj interno

;##### Configuramos el preescaler asignado al Timer0 (1:256)####
			BCF		OPTION_REG, PSA
			BSF		OPTION_REG, PS0
			BSF		OPTION_REG, PS1
			BSF		OPTION_REG, PS2
;###############################################################

			BCF		STATUS,RP0 ; Cambiamos al banco 0

			BSF		ADCON0, ADON ; Habilitamos la conversión A/D

			BSF		RCSTA, SPEN ; Activamos el BIT para habilitar el puerto serie

			BSF 	INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF		INTCON, RBIE ; Habilitamos el BIT de interrupciones de RB - PAGINA 20 del manual resumido
			BSF		INTCON, T0IE ; Habilitamos el BIT de overflow de TMR0 - PAGINA 20 del manual resumido
			BSF		INTCON, PEIE ; Habilitamos el BIT de interrupciones de perifericos - PAGINA 20 del manual resumido

			MOVLW	.61
			MOVWF	TMR0 ; Ponemos TMR0 a 61

			MOVLW	.5
			MOVWF	N

main
	goto main
;-------------------------------------------------------
ISR
			BTFSC	INTCON,RBIF ; Si RBIF es 0 saltamos la instrucción ISR_BOTON
			goto	ISR_BOTON
			BTFSC	INTCON,T0IF ; Si R0IF es 0 saltamos la instrucción ISR_VELOCIDAD
			goto	ISR_VELOCIDAD
RETFIE

ISR_BOTON
			MOVF 	PORTB,0 ; Movemos el valor del PORTB a WREG
			XORWF	VALORB,0
			MOVWF	XOR
			MOVF 	PORTB,0
			MOVWF	VALORB

			BCF		INTCON,RBIF ;Ponemos a 0 el FLAG de interrupcion de RBIF

			BTFSC 	XOR,7   ; Si el BIT 7 de XOR es 0 saltamos la instrucción
			goto gira_derecha
			BTFSC 	XOR,6   ; Si el BIT 6 de XOR es 0 saltamos la instrucción
			goto adelante
			BTFSC 	XOR,5   ; Si el BIT 5 de XOR es 0 saltamos la instrucción
			goto gira_izquierda
			BTFSC 	XOR,4   ; Si el BIT 4 de XOR es 0 saltamos la instrucción
			goto atras

RETFIE

ISR_VELOCIDAD
			MOVLW	.61
			MOVWF	TMR0 ; Ponemos TMR0 a 61
			DECFSZ	N,1
RETFIE
			MOVLW	.5
			MOVWF	TMR0 ; Ponemos TMR0 a 61
			BCF 	INTCON, T0IF ; ;Ponemos a 0 el FLAG de interrupcion de T0IE

;----- Seleccionamos el canal 2 ----
			BCF		ADCON0,CHS2
			BSF		ADCON0,CHS1
			BCF		ADCON0,CHS0
;-----------------------------------
			BSF		ADCON0,GO ; Ponemos el BIT GO a 1 para comenzar la conversión

		es1
			BTFSC	ADCON0,GO  ; Comprobamos si el BIT GO se ha puesto a 0, ya que automaticamente cambia al finalizar la conversión
		goto es1

			MOVF	ADRESH,0 ; Movemos los 8 bits más significativos de la convesión a WREG
			MOVWF	VEL ; Copiamos WREG en VEL

;*************** DIVIDIR ENTRE 32 ********************
			BCF		STATUS,C
			RRF		VEL,1 
			BCF		STATUS,C
			RRF		VEL,1 
			BCF		STATUS,C
			RRF		VEL,1 
			BCF		STATUS,C
;*****************************************************

			CALL	envia_velocidad

RETFIE
;################### Movimientos ####################
gira_derecha ;Para girar a la derecha mandamos -> D
			BTFSS	PORTB,RB7
			goto	parar
;			CALL	envia_token
			MOVLW 	'D'	
			MOVWF 	TXREG
			NOP
			NOP
			CALL	envia_velocidad
RETFIE

adelante ;Para seguir recto mandamos -> W
			BTFSS	PORTB,RB6
			goto	parar
;			CALL	envia_token
			MOVLW 	'W'	
			MOVWF 	TXREG
			NOP
			NOP
			CALL	envia_velocidad
RETFIE

gira_izquierda ;Para girar a la izquierda mandamos -> A
			BTFSS	PORTB,RB5
			goto	parar
;			CALL	envia_token
			MOVLW 	'A'	
			MOVWF 	TXREG
			NOP
			NOP
			CALL	envia_velocidad
RETFIE

atras ;Para retroceder mandamos -> S
			BTFSS	PORTB,RB4
			goto	parar
;			CALL	envia_token
			MOVLW 	'S'	
			MOVWF 	TXREG
			NOP
			NOP
			CALL	envia_velocidad
RETFIE

parar
			MOVLW 	'P'	
			MOVWF 	TXREG
RETFIE

envia_velocidad
			MOVF	VEL,0
			MOVWF 	TXREG
RETFIE


;####################################################

envia_token
			MOVF	TOKEN,0
			MOVWF	TXREG		
RETURN

END