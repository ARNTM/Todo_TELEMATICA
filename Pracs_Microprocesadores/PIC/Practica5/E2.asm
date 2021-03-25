;-------------------------------------------------------
			LIST p=16F876A
			INCLUDE "p16f876a.inc"
			__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
CONTROL		EQU	0x30
DATO1		EQU	0x31
DATO2		EQU	0x32
;-------------------------------------------------------
			ORG 0
			goto inicio
	
			ORG 4
			goto ISR
			ORG 5
;-------------------------------------------------------

inicio
			BSF 	STATUS,RP0 ; Cambiamos al banco 1

			MOVLW 	b'11111111'
			MOVWF 	TRISC ; Ponemos todo PORTC como entrada
	
			CLRF 	TRISB ; Ponemos todo PORTB como salida
	
			MOVLW 	.12
			MOVWF 	SPBRG ; Asignamos el ratio de baudios para el modo asincrono (VER EN LA TABLA DEL MANUAL REDUCIDO QUE SE PUDE ENCONTRAR EN LA PAGINA 98)
	
			BSF 	TXSTA, BRGH ; Activamos el BIT para que el modo asincrono sea a baja velocidad (también se ve en la tabla)
			BSF		TXSTA, TXEN ; Activamos el BIT que habilita la transmisión
			BSF 	PIE1, RCIE ; Activamos interrupcion de recepción
	
			BSF 	RCSTA, SPEN ; Activamos el BIT para habilitar el puerto serie
			BSF 	RCSTA, CREN  ; Activamos el BIT para que esté recibiendo continuamente
			
			BCF 	STATUS,RP0  ; Cambiamos al banco 1
	
			BSF 	INTCON, GIE  ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF 	INTCON, PEIE  ; Habilitamos el BIT de interrupciones de perifericos - PAGINA 20 del manual resumido
			BCF 	CONTROL,0 ; Ponemos el BIT 0 de CONTROL a 0

main
		goto main

ISR
			BTFSS 	PIR1,RCIF ; Si RCIF está activo saltaremos RETFIE 
RETFIE
			
			BTFSS 	CONTROL,0 ; Si el BIT 0 de CONTROL está activo, salta guarda_dato1
			goto guarda_dato1
	
			MOVF 	RCREG,0
			MOVWF 	DATO2 ; Mueve el dato de RCREG a DATO2
			
			MOVF 	DATO1,0 ; Mueve DATO1 a WREG
			SUBLW 	'A' ; Resta el caracter A a WREG, si el resultado es 0 significa que hemos enviado una A
			BTFSS 	STATUS,Z ; Si Z es 1 salta devuelve_0
			goto 	devuelve_0
	
			MOVF 	DATO2,0 ; Mueve DATO2 a WREG
			SUBLW 	'1' ; Resta el caracter 1 a WREG, si el resultado es 0 significa que hemos enviado un 1
			BTFSC 	STATUS,Z ; Si Z es 1 salta devuelve_1		
			goto 	devuelve_1
	
			MOVF 	DATO2,0 ; Mueve DATO2 a WREG
			SUBLW 	'2' ; Resta el caracter 2 a WREG, si el resultado es 0 significa que hemos enviado un 2
			BTFSC 	STATUS,Z ; Si Z es 1 salta devuelve_2
			goto 	devuelve_2
			
			goto 	devuelve_0
	
			BCF 	CONTROL,0  ; Ponemos el BIT 0 de CONTROL a 0
RETFIE
;-------------------------------------------------------

guarda_dato1 ; Guarda el primer caracter
		MOVF 	RCREG,0
		MOVWF 	DATO1 ; Mueve el dato de RCREG a DATO1
		BSF 	CONTROL,0  ; Ponemos el BIT 0 de CONTROL a 1
RETFIE


devuelve_0 ; Devuelve 0
		MOVLW 	'0'
 		MOVWF 	TXREG
		BCF 	CONTROL,0  ; Ponemos el BIT 0 de CONTROL a 0
RETFIE


devuelve_1 ; Devuelve 1
		MOVLW 	'1'
		MOVWF 	TXREG
		BCF 	CONTROL,0  ; Ponemos el BIT 0 de CONTROL a 0
RETFIE


devuelve_2 ; Devuelve 2
		MOVLW 	'2'
		MOVWF 	TXREG
		BCF 	CONTROL,0  ; Ponemos el BIT 0 de CONTROL a 0
RETFIE
;-------------------------------------------------------

END

; Hecho por Los Telematicos
