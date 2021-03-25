; _____ _____ _____      _____   _____       _____           _          
;|  __ \_   _/ ____|    |  __ \ / ____|     / ____|         | |         
;| |__) || || |     __ _| |__) | |   ______| |     ___   ___| |__   ___ 
;|  ___/ | || |    / _` |  _  /| |  |______| |    / _ \ / __| '_ \ / _ \
;| |    _| || |___| (_| | | \ \| |____     | |___| (_) | (__| | | |  __/
;|_|   |_____\_____\__,_|_|  \_\\_____|     \_____\___/ \___|_| |_|\___|
;-------------------------------------------------------
			LIST p=16F876A
			INCLUDE "p16f876a.inc"
			__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
TOKEN		EQU		0x20
ADE		EQU		0x21
IZQ		EQU		0x22
ATR		EQU		0x23
DER		EQU		0x24
STOP		EQU		0x25
VEL		EQU		0x26
CONTROL		EQU		0x27
N		EQU		0x28
N_AUX		EQU		0x29
ESTADO		EQU		0x30	
;-------------------------------------------------------
			ORG 	0
			goto 	inicio

			ORG 	4
			goto 	ISR
			ORG 	5
;-------------------------------------------------------

inicio
			MOVLW	'ç'
			MOVWF	TOKEN
			
			MOVLW	b'00001011'
			MOVWF	ADE
			MOVLW	b'00001001'
			MOVWF	IZQ
			MOVLW	b'00000111'
			MOVWF	ATR
			MOVLW	b'00001110'
			MOVWF	DER
			MOVLW	b'00000000'
			MOVWF	STOP
			MOVLW	.32
			MOVWF	N

			BSF	STATUS,RP0 ; Cambiamos al banco 1
			MOVLW	b'10000000'
			MOVWF	TRISC ; Ponemos PORTC como salida
			MOVLW	.255
			MOVWF	TRISA

			MOVLW 	.25
			MOVWF 	SPBRG ; Asignamos el ratio de baudios para el modo asincrono (VER EN LA TABLA DEL MANUAL REDUCIDO QUE SE PUDE ENCONTRAR EN LA PAGINA 98) 

			BSF 	TXSTA, BRGH ; Activamos el BIT para que el modo asincrono sea a baja velocidad (también se ve en la tabla)
			BSF	TXSTA, TXEN ; Activamos el BIT que habilita la transmisión

			BSF	PIE1, RCIE ; Habilitamos el BIT de interrupcion de recepciones

			BCF	OPTION_REG, T0CS ; Ponemos el BIT T0CS a 0 para indicar que usamos el reloj interno

;##### Configuramos el preescaler asignado al Timer0 (1:256)####
			BSF	OPTION_REG, PSA
			BSF	OPTION_REG, PS0
			BCF	OPTION_REG, PS1
			BCF	OPTION_REG, PS2
;###############################################################

			BCF	STATUS,RP0 ; Cambiamos al banco 0

			BSF	RCSTA, SPEN ; Activamos el BIT para habilitar el puerto serie
			BSF 	RCSTA, CREN ; Habilitamos la recepción continua

			BSF 	INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF	INTCON,PEIE ; Habilitamos el BIT de interrupciones de perifericos - PAGINA 20 del manual resumido
			BSF	INTCON, T0IE ; Habilitamos el BIT de overflow de TMR0 - PAGINA 20 del manual resumido
		
			MOVLW	.4  ; 
			MOVWF	TMR0 ; Copiamos 4 en TMR0

			BCF	CONTROL,0
			CLRF	PORTC
			CLRF	ESTADO

main
	goto main
;-------------------------------------------------------

ISR
;################### TOKEN ###################
		;	MOVF	RCREG,0
		;	SUBWF	TOKEN,0
		;	BTFSC	STATUS,Z
;RETFIE
;#############################################

			BTFSC	PIR1, RCIF ; RCIF = 1?	
			goto isr_mover
			BTFSC	INTCON,T0IF ; T0IF = 1?
			goto isr_velocidad
RETFIE
;-------------------------------------------------------
isr_mover
			MOVF	RCREG,0 ; Mueve RCREG a WREG
			SUBLW	'W' ; Restamos W - WREG
			BTFSC	STATUS,Z ; Si el resultado es 0, Z -> 1, si Z = 0, salta.
			goto adelante	
			MOVF	RCREG,0 ; Mueve RCREG a WREG
			SUBLW	'A' ; Restamos A - WREG
			BTFSC	STATUS,Z ; Si el resultado es 0, Z -> 1, si Z = 0, salta.
			goto gira_izquierda
			MOVF	RCREG,0 ; Mueve RCREG a WREG
			SUBLW	'S' ; Restamos S - WREG
			BTFSC	STATUS,Z ; Si el resultado es 0, Z -> 1, si Z = 0, salta.
			goto atras
			MOVF	RCREG,0 ; Mueve RCREG a WREG
			SUBLW	'D' ; Restamos D - WREG
			BTFSC	STATUS,Z ; Si el resultado es 0, Z -> 1, si Z = 0, salta.
			goto gira_derecha
			MOVF	RCREG,0 ; Mueve RCREG a WREG
			SUBLW	'P' ; Restamos P - WREG
			BTFSC	STATUS,Z ; Si el resultado es 0, Z -> 1, si Z = 0, salta.
			goto parar
			MOVF	RCREG,0 ; Mueve RCREG a WREG
			MOVWF	VEL		; Copiamos WREG en VEL
RETFIE

isr_velocidad
			BCF 	INTCON, T0IF ;Ponemos a 0 el FLAG de interrupcion de T0IE
			BTFSC	CONTROL,0 ; CONTROL = 1?
			goto segundo_paso
			MOVF	VEL,0
			MOVWF	N_AUX
			DECFSZ	N_AUX,1
			goto	t_on
			BSF	CONTROL,0 ; Ponemos BIT 0 de control a 1 para comprobar si es la primera vez que entramos en isr_velocidad o la segunda			
RETFIE

segundo_paso
			MOVF	N,0
			SUBLW	VEL
			MOVWF	N_AUX
			DECFSZ	N_AUX,1
			goto	t_off
			BCF	CONTROL,0 ; Ponemos BIT 0 de control a 0 para comprobar si es la primera vez que entramos en isr_velocidad o la segunda
RETFIE

;-------------------------------------------------------
t_on
			MOVF	ESTADO,0
			MOVWF	PORTC 	
RETFIE
;--------
t_off
		;	MOVF	STOP,0
			CLRF	ESTADO
			CLRF	PORTC ; Copiamos STOP en PORTC
RETFIE
;--------
parar
		;	MOVF	STOP,0
			CLRF	ESTADO
			CLRF	PORTC ; Copiamos STOP en PORTC
RETFIE
;--------
adelante
			MOVF	ADE,0
			MOVWF	ESTADO ; Copiamos ADE en ESTADO	
RETFIE
;--------
gira_izquierda
			MOVF	IZQ,0
			MOVWF	ESTADO ; Copiamos IZQ en ESTADO
RETFIE
;--------
atras
			MOVF	ATR,0
			MOVWF	ESTADO ; Copiamos ATR en ESTADO
RETFIE
;--------
gira_derecha
			MOVF	DER,0
			MOVWF	ESTADO ; Copiamos DER en ESTADO
RETFIE
;-------------------------------------------------------

END