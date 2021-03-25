;-------------------------------------------------------	
		LIST p=16F876A
		include "p16f876.inc"
		__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
CONTROL	EQU		0x20
DATO1	EQU		0x51
DATO2	EQU		0x52

L_1		EQU		0x28
A_1		EQU		0x27
B_1		EQU		0x26
NUM5_1	EQU		0x25	
G_1		EQU		0x24
NUM1	EQU		0x23
LF_1	EQU		0x22
CR_1	EQU		0X21

L_2		EQU		0x37
A_2		EQU		0x36
B_2		EQU		0x35
NUM5_2	EQU		0x34	
G_2		EQU		0x33
NUM2	EQU		0x32
LF_2	EQU		0x31
CR_2	EQU		0X30

L_3		EQU		0x45
A_3		EQU		0x44
B_3		EQU		0x43
NUM5_3	EQU		0x42	
G_3		EQU		0x41
E_3		EQU		0x40
R_3		EQU		0x3F
LF_3	EQU		0x3E
CR_3	EQU		0X3D

paso	EQU		0x50		
;-------------------------------------------------------
		ORG 0
		goto inicio
		
		ORG 4
		goto ISR
		ORG 5
;-------------------------------------------------------

 inicio 

		MOVLW	'L'
		MOVWF	L_1
		MOVWF	L_2
		MOVWF	L_3
		MOVLW	'A'
		MOVWF	A_1	
		MOVWF	A_2
		MOVWF	A_3
		MOVLW	'B'
		MOVWF	B_1
		MOVWF	B_2
		MOVWF	B_3
		MOVLW	'5'
		MOVWF	NUM5_1
		MOVWF	NUM5_2
		MOVWF	NUM5_3
		MOVLW	'_'
		MOVWF	G_1
		MOVWF	G_2
		MOVWF	G_3
		MOVLW	'1'
		MOVWF	NUM1
		MOVLW	'2'
		MOVWF	NUM2
		MOVLW	'e'
		MOVWF	E_3
		MOVLW	'r'
		MOVWF	R_3
		MOVLW	.10
		MOVWF	LF_1
		MOVWF	LF_2
		MOVWF	LF_3
		MOVLW	.13
		MOVWF	CR_1
		MOVWF	CR_2
		MOVWF	CR_3

		BSF		STATUS,RP0  ; Cambiamos al banco 1

		CLRF	TRISB ; Ponemos todo PORTB como salida
		MOVLW	b'10000000'
		MOVWF	TRISC ; Configuramos entradas y salidas de PORTC

		MOVLW	.12
		MOVWF	SPBRG ; Asignamos el ratio de baudios para el modo asincrono (VER EN LA TABLA DEL MANUAL REDUCIDO QUE SE PUDE ENCONTRAR EN LA PAGINA 98)

		BSF		TXSTA,BRGH ; Activamos el BIT para que el modo asincrono sea a baja velocidad (también se ve en la tabla)
		BSF		TXSTA,TXEN ; Activamos el BIT que habilita la transmisión
	
		BSF		PIE1,RCIE ; Activamos interrupcion de recepción

		BCF		STATUS,RP0  ; Cambiamos al banco 0

		
		BSF		RCSTA,SPEN ; Activamos el BIT para habilitar el puerto serie
		BSF		RCSTA,CREN ; Activamos el BIT para que esté recibiendo continuamente

		BSF		INTCON,GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
		BSF		INTCON,PEIE ; Habilitamos el BIT de interrupciones de perifericos - PAGINA 20 del manual resumido

		CLRF	PORTB ; Borramos PORTB
		CLRF	CONTROL

main
	goto	main
;-------------------------------------------------------

ISR
		BTFSC	PIR1,RCIF ; Si RCIF está desactivado saltaremos ISR_RCIF
		goto	ISR_RCIF
		goto	ISR_TXIF
;-------------------------------------------------------

ISR_RCIF
		BTFSS	CONTROL,0 ; Si el BIT 0 de dato es 1 saltamos guarda_dato1
		goto 	guarda_dato1

		MOVF	RCREG,0
		MOVWF	DATO2 ; Mueve el dato de RCREG a DATO2

		MOVF 	DATO1,0 ; Mueve DATO1 a WREG
		SUBLW 	'A' ; Resta el caracter A a WREG, si el resultado es 0 significa que hemos enviado una A
		BTFSS 	STATUS,Z ; Si Z es 1 salta devuelve_0
		goto	enviar_LAB5_er

		MOVF 	DATO2,0 ; Mueve DATO2 a WREG
		SUBLW 	'1' ; Resta el caracter 1 a WREG, si el resultado es 0 significa que hemos enviado un 1
		BTFSC 	STATUS,Z ; Si Z es 1 salta devuelve_1		
		goto	enviar_LAB5_1

		MOVF 	DATO2,0 ; Mueve DATO2 a WREG
		SUBLW 	'2' ; Resta el caracter 2 a WREG, si el resultado es 0 significa que hemos enviado un 2
		BTFSC 	STATUS,Z ; Si Z es 1 salta devuelve_2
		goto	enviar_LAB5_2

		goto	enviar_LAB5_er

		BCF 	CONTROL,0  ; Ponemos el BIT 0 de CONTROL a 0

RETFIE

;-------------------------------------------------------
ISR_TXIF
comparar_paso
		DECF	FSR,1 ; Decrementa FSR en 1
		MOVF	INDF,0 ; Copia el valor de la direccion de memoria de FSR en WREG
		MOVWF	TXREG ; Mueve WREG a TXREG
		DECFSZ	paso,1 ; Decrementa paso en 1 y salta RETFIE si es 0
RETFIE	
		BSF		STATUS,RP0 ; Cambiamos al banco 1
		BCF		PIE1,TXIE ; Deshabilitamos la interrupción de transmisión
		BCF		STATUS,RP0 ; Cambiamos al banco 0
RETFIE
;-------------------------------------------------------

guarda_dato1
		movf	RCREG,0
		MOVWF	DATO1 ; Mueve el dato de RCREG a DATO1
		BSF		CONTROL,0 ; Ponemos el BIT 0 de CONTROL a 1
RETFIE

enviar_LAB5_er
		MOVLW	.9
		MOVWF	paso ; Copiamos 9 en paso
		MOVLW	0x46
		MOVWF	FSR ; Apuntamos FSR a la dirección 0x46
		CALL 	habilita_txie

RETFIE

enviar_LAB5_1
		MOVLW	.8
		MOVWF	paso ; Copiamos 8 en paso
		MOVLW	0x29
		MOVWF	FSR ; Apuntamos FSR a la dirección 0x29
		CALL 	habilita_txie

RETFIE



enviar_LAB5_2
		MOVLW	.8
		MOVWF	paso ; Copiamos 8 en paso
		MOVLW	0x38
		MOVWF	FSR ; Apuntamos FSR a la dirección 0x38
		CALL 	habilita_txie

RETFIE

habilita_txie
		BSF		STATUS,RP0 ; Cambiamos al banco 1
		BSF		PIE1,TXIE ; Habilitamos la interrupción de transmisión
		BCF		STATUS,RP0  ; Cambiamos al banco 0
		BCF 	CONTROL,0 ; Ponemos el BIT 0 de CONTROL a 0
RETURN

END

; Hecho por Los Telematicos