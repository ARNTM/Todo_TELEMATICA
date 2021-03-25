;-------------------------------------------------------
			LIST p=16F876A
			include "p16f876.inc"
			__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
N			EQU		0x20
paso		EQU		0X21
VALORB		EQU		0x23
XOR			EQU		0x24
M			EQU		0x25
O			EQU		0x26
flags		EQU		0x27
N_original	EQU		0x28
STATE1		EQU		0x34
STATE2		EQU		0x33
STATE3		EQU		0x32
STATE4		EQU		0X31
;-------------------------------------------------------
			ORG 0
			goto inicio
			
			ORG 4
			goto ISR
			ORG 5
;-------------------------------------------------------

inicio

			BSF		STATUS,RP0 ; Cambiamos al banco 1

			CLRF	TRISA ; Ponemos todo PORTA como salida

;##### Configuramos TRISA como salidas DIGITALES ####
			BCF 	ADCON1,0 
			BSF		ADCON1,1
			BSF		ADCON1,2
			BSF		ADCON1,3
;####################################################

			MOVLW	b'11100001'
			MOVWF	TRISB ; Configuramos las entradas y salidas de PORTB
			CLRF	TRISC ; Ponemos todo PORTA como salida
		
			BSF		OPTION_REG,T0CS ; Interrupción del reloj interno
			BCF		OPTION_REG,PSA ; Preescaler del Timer0
			BSF		OPTION_REG,PS2 ; PS2 = 1
			BSF		OPTION_REG,PS1 ; PS1 = 1
			BSF		OPTION_REG,PS0 ; PS0 = 1
			BSF		OPTION_REG,INTEDG ; Interrupción de PULSO ASCENDENTE de RB0

			BCF		STATUS,RP0 ; Cambiamos al banco 0
		
			MOVLW	.7
			MOVWF	N_original ; Copiamos el numero 7 en N_original
			MOVF	N_original,0 ; Copiamos N_original en WREG
			CLRF	N ; Inicializamos N a 0
			MOVWF	PORTA ; Movemos WREG en PORTA
		
			MOVLW	.61
			MOVWF	TMR0 ; Ponemos TMR0 a 61
		
			MOVLW	.4
			MOVWF	paso ; Ponemos paso a 4

;############# Inicializamos los estados ############
			MOVLW	b'00001100'
			MOVWF	STATE1
			MOVWF	PORTC
			DECF	paso,1
			MOVLW	b'00000110'
			MOVWF	STATE2
			MOVLW	b'00000011'
			MOVWF	STATE3
			MOVLW	b'00001001'
			MOVWF	STATE4
;####################################################
			
			MOVF	PORTB,0
			MOVWF	VALORB	; Movemos el valor de PORTB a VALORB
				
			CLRF	flags ; Inicializamos flags a 0
		
			BSF		INTCON,GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF		INTCON,T0IE ; Habilitamos el BIT de overflow de TMR0 - PAGINA 20 del manual resumido
			BSF		INTCON,INTE ; Habilitamos el BIT de interrupciones externas de RB0 - PAGINA 20 del manual resumido
			BSF		INTCON,RBIE ; Habilitamos el BIT de interrupciones del puerto RB - PAGINA 20 del manual resumido

main
	goto	main

;-------------------------------------------------------
ISR
			BTFSC	INTCON,T0IF ; Si el BIT T0IF está a 0, salta la siguiente instrucción
			goto	ISR_TMR0
			BTFSC	INTCON,INTF ; Si el BIT INTF está a 0, salta la siguiente instrucción
			goto	ISR_RB0

ISR_RBIF
		 	CALL	bucle_retardo
			MOVF	PORTB,0 ; Copia el valor de PORTB a WREG
			XORWF	VALORB,0 ; XOR de WREG con VALORB
			MOVWF	XOR ; Guarda el resultado en XOR
			MOVF	PORTB,0 ; Copia el valor de PORTB a WREG
			MOVWF	VALORB ; Copia el reultado en VALORB
			BCF		INTCON,RBIF ;Ponemos a 0 el FLAG de interrupcion de RBIF
			BTFSC	XOR,7   ; Si el BIT 7 de XOR es 0 saltamos la instrucción
			goto	ISR_RB7
			BTFSC	XOR,6  ; Si el BIT 6 de XOR es 0 saltamos la instrucción
			goto	ISR_RB6

ISR_RB5
			BTFSC	PORTB,RB5 ; Si el RB5 es 0 saltamos el RETFIE
RETFIE

decremento_N
			MOVF	N_original,0
			MOVWF	PORTA ; Movemos el valor de N_original a PORTA
			MOVLW	.1
			XORWF	N_original,0 ; Hacemos la XOR de N_original y el valor 1
			BTFSC	STATUS,Z ; Si en WREG hay un 0 el BIT Z se activará, si no está activado saltaremos el RETFIE
RETFIE
			DECF	N_original,1 ; Decrementamos N_original en 1
			MOVF	N_original,0 ; Movemos N_original a WREG
			MOVWF	PORTA ; Copiamos WREG en PORTA
RETFIE

ISR_RB6
			BTFSC	PORTB,RB6 ; Si el RB6 es 0 saltamos el RETFIE 
RETFIE

incremento_N

			MOVF	N_original,0
			MOVWF	PORTA ; Movemos el valor de N_original a PORTA
			MOVLW	.15
			XORWF	N_original,0 ; Hacemos la XOR de N_original y el valor 15
			BTFSC	STATUS,Z  ; Si en WREG hay un 0 el BIT Z se activará, si no está activado saltaremos el RETFIE
RETFIE
			INCF	N_original,1 ; Incrementamos N_original en 1
			MOVF	N_original,0 ; Movemos N_original a WREG
			MOVWF	PORTA ; Copiamos WREG en PORTA
RETFIE

ISR_RB7
			BTFSS	PORTB,RB7 ; Si el RB7 es 1 saltamos el RETFIE
RETFIE
			BTFSS	flags,0 ; Si el BIT 0 de flags es 1 saltamos el RETFIE
			goto	ON
			goto	OFF
;-------------------------------------------------------
ON
			BSF		STATUS,RP0 ; Cambiamos al banco 1

			BCF		OPTION_REG,T0CS ; Ponemos a 0 el BIT T0CS (CLKOUT)

			BCF		STATUS,RP0 ; Cambiamos al banco 0

			MOVLW	.1
			MOVWF	flags ; Ponemos el PRIMER BIT de flags a 1
RETFIE
;-------------------------------------------------------	
OFF
			BSF		STATUS,RP0 ; Cambiamos al banco 1

			BSF		OPTION_REG,T0CS ; Ponemos a 0 el BIT T0CS. Transcición en RA4

			BSF		STATUS,RP0 ; Cambiamos al banco 0

			MOVLW	.0
			MOVWF	flags ; Ponemos el PRIMER BIT de flags a 1	
RETFIE		
;-------------------------------------------------------	


;-------------------------------------------------------
ISR_TMR0
			BCF		INTCON,T0IF ;Ponemos a 0 el FLAG de interrupcion de T0IE
			MOVLW	.61
			MOVWF	TMR0 ; Ponemos TMR0 a 61
			goto	iniciar_N

decrementar_N
			DECFSZ	N,1 ; Decrementamos N en 1 y si es 0 saltamos RETFIE
			RETFIE
			BTFSS	PORTB,RB0 ; Si RB0 es 1 saltamos la instrucción
			goto	seq_invertida

seq_normal
			MOVLW	0x30
			MOVWF	FSR ; Movemos 0x30 a FSR
			MOVF	paso,0 ; Movemos paso a WREG
			ADDWF	FSR,1 ; Sumamos paso con FSR y lo guardamos en FSR
			MOVF	INDF,0 ; Movemos el valor de la direccion de FSR en WREG
			MOVWF	PORTC ; Movemos WREG a PORTC
			DECFSZ	paso,1 ; Decrementamos paso en 1 y si es 0 saltamos RETFIE
RETFIE	
			MOVLW	.4 
			MOVWF	paso ; Volvemos a inicializar paso a 4	
RETFIE		

seq_invertida
			MOVLW	0x30
			MOVWF	FSR  ; Movemos 0x30 a FSR
			MOVF	paso,0 ; Movemos paso a WREG
			ADDWF	FSR,1 ; Sumamos paso con FSR y lo guardamos en FSR
			MOVF	INDF,0  ; Movemos el valor de la direccion de FSR en WREG
			MOVWF	PORTC  ; Movemos WREG a PORTC
			INCF	paso,1 ; Incrementamos paso en 1
			MOVLW	.5
			XORWF	paso,0 ; Hacemos XOR de paso con 5 y lo guardamos en WREG
			BTFSS	STATUS,Z ; Si Z es 1 saltamos RETFIE
RETFIE
			goto	reiniciar_paso

reiniciar_paso
			MOVLW	.1 
			MOVWF	paso ; Ponemos paso a 1
RETFIE

iniciar_N
			MOVLW	.0
			XORWF	N,0 ; Hacemos XOR de N con 0 y lo guardamos en WREG
			BTFSS	STATUS,Z ; Si el BIT Z es 1 salta la instruccion
			goto	decrementar_N
			MOVF	N_original,0 
			MOVWF	N ; Copia N_original en N
RETFIE
;-------------------------------------------------------


;-------------------------------------------------------
ISR_RB0
			BCF		INTCON,INTF ;Ponemos a 0 el FLAG de interrupcion de INTE
			BTFSC	PORTB,RB0 ; Si RB0 es 0 salta la instruccion
			goto	RB0_1
RB0_0
			BCF		PORTB,RB0 ; Ponemos a 0 RB0
			BSF		STATUS,RP0 ; Cambiamos al banco 1
			BSF		OPTION_REG,INTEDG ; Interrupción de PULSO ASCENDENTE de RB0
			BCF		STATUS,RP0 ; Cambiamos al banco 0
RETFIE

RB0_1
			BSF		PORTB,RB0  ; Ponemos a 1 RB0
			BSF		STATUS,RP0 ; Cambiamos al banco 1
			BCF		OPTION_REG,INTEDG ; Interrupción de PULSO DESCENDENTE de RB0
			BCF		STATUS,RP0 ; Cambiamos al banco 0
RETFIE
;-------------------------------------------------------


; Bucle de retardo del ejercicio 2 de la práctica 1 (Está ajustado a 30ms)
; Está hecho de otra forma al resto de practicas
bucle_retardo
			MOVLW	.99
			MOVWF	M
bucle_O
			MOVLW	.100
			MOVWF	O
decrementar_O
			DECFSZ	O,1
			goto	decrementar_O
			
			DECFSZ	M,1
			goto	bucle_O

RETURN

END

; Hecho por Los Telematicos