	list p = 16F876A
	include"p16f876a.inc"
	__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;CONTRASEÑAS: DIEGO -> 1234 || ANTOLINOS-> A310 || GARCIA-> 789D
;-------------------- VARIABLES -----------------------------------------------------------------
TECLA equ 0x20
XOR equ 0x21
columna equ 0x22
VALORB  equ 0x23
PT equ 0x24 		;Puntero para cambiar habilitacion de fila
CONT1 equ 0x25 		;Bucle retardo de 30ms
CONT2 equ 0x26
N 	  equ 0x29 		;Var para comprobacion de fila en la que estamos comprobando
FILA0 equ 0x34 		;Fila habilitada
FILA1 equ 0x33
FILA2 equ 0x32
FILA3 equ 0x31
NUM_0 equ 0x40   	;Valores ASCII de teclas
NUM_1 equ 0x41
NUM_2 equ 0x42
NUM_3 equ 0x43
NUM_4 equ 0x44
NUM_5 equ 0x45
NUM_6 equ 0x46
NUM_7 equ 0x47
NUM_8 equ 0x48
NUM_9 equ 0x49
LET_A equ 0x4A
LET_B equ 0x4B
LET_C equ 0x4C
LET_D equ 0x4D
ASTER equ 0x4E
ALMH equ 0x2F

N_TECLA equ 0x50 
PT_ID equ 0x57  	;puntero para ID en TX

DATO1 equ 0x51 		;datos metidos por teclado
DATO2 equ 0x52
DATO3 equ 0x53
DATO4 equ 0x54

N_DATO equ 0x55 	;Numero de datos que hemos metido por teclado
N_ACIERTOS equ 0x56 ; Numero de aciertos en la clave de un usuario

ESTADO 		equ 0x58
VUELTA		equ 0x59 
ENTRADA		equ 0x5A
N_TIEMPO 	equ 0x5B

N_RECIBIDO	equ	0x5E
RX_1		equ	0x5F
RX_2		equ	0x2A	
RX_3		equ 0x2B
RX_4		equ 0x2C
RX_5		equ	0x2D
QUIERO_ESPERAR	equ	0x2E
ESPERANDO	equ	0x2F

;-------------------------------------------------------------------------
	org 0
	goto inicio
	org 4
	goto ISR
	org 5
;---------------- INICIALIZACION DE NUESTRO PROGRAMA ---------------------	
inicio	
	movlw b'00001110'  ;filas habilitadas y deshabilitadas
	movwf FILA0
	movlw b'00001101'
	movwf FILA1
	movlw b'00001011'
	movwf FILA2
	movlw b'00000111'
	movwf FILA3
	
	movlw .0
	movwf N_DATO
	movwf N_ACIERTOS
	
	movlw .5
	movwf PT
	movlw .0
	movwf N
	movwf N_RECIBIDO
	clrf TECLA
	movlw 'S'
	movwf ESTADO ; ESTADOS: DES -> S | ACT-> R | DIS-> F | DETEC-> D |
	
;----------- BANCO 1 ---------------
	bsf STATUS,RP0
	
	movlw b'11110001' ;Ponemos RB[7:4] entrada, RB[3:1] salida, RB0 sensor
	movwf TRISB
	
	clrf TRISA
	bsf ADCON1,0
	bsf ADCON1,1
	bsf ADCON1,2
	bcf ADCON1,3

	movlw b'10000000'
	movwf TRISC

	bcf OPTION_REG,7
	bsf OPTION_REG,INTEDG

	bcf OPTION_REG,T0CS
	bcf OPTION_REG,PSA
	bsf OPTION_REG,PS0
	bsf OPTION_REG,PS1
	bsf OPTION_REG,PS2

	movlw .25
	movwf SPBRG
	bsf TXSTA,BRGH
	bsf TXSTA,TXEN
	bsf PIE1,RCIE
	
	bcf STATUS,RP0
;----------- BANCO 0 ---------------
	bsf RCSTA,SPEN
	bsf RCSTA,CREN

	clrf PORTC
	movlw .0
	movwf TMR0	
	movlw b'00000111'
	movwf PORTA
	
	movlw 0xF0
	movwf PORTB
	movf PORTB,0
	movwf VALORB
	
	clrf ENTRADA
	clrf VUELTA
	clrf N_TIEMPO

	movlw .65
	movwf ESPERANDO

	bsf INTCON,GIE
	bsf INTCON,RBIE
	bsf INTCON,PEIE
	bsf INTCON,INTE
main
	goto main
;-------------- INTERRUPCIONES -----------------------------------------
ISR	
	btfsc INTCON,RBIF
	goto ISR_RBIF
	btfsc INTCON,INTF
	goto ISR_RB0
    btfsc INTCON,T0IF
	goto ISR_TMR0
	btfsc PIR1,RCIF
	goto ISR_RCIF
	goto ISR_TXIF

RETFIE
;-------------- TECLADO MATRICIAL ------------------------------------
ISR_RBIF
	call bucle_retardo
	btfss QUIERO_ESPERAR,2 ;PARA QUE NO ENTRE EN T0IF POR DESBORDE DE TMR0 SI NO CONTAMOS 15s
	bcf INTCON,T0IF

	movf PORTB,0
	xorwf VALORB,0 		;comprobamos cuál es el valor de PORTB que ha cambiado
	movwf XOR
	movf PORTB,0
	movwf VALORB
	bcf INTCON,RBIF

	btfsc XOR,RB4  		;IDENTIFICAMOS QUE COLUMNA ES LA ACTIVADA
	goto columna_0
	btfsc XOR,RB5
	goto columna_1
	btfsc XOR,RB6
	goto columna_2
	btfsc XOR,RB7
	goto columna_3
RETFIE
;---------- VALOR COLUMNA ------------------------------------------
columna_0
	btfsc PORTB,RB4 	;Comprobamos que RBX=0 --> pasa, si RBX=1 --> RETFIE
RETFIE
	movlw .0
	movwf columna 		;Asignamos valores determinados a columna
	call identifica_tecla
RETFIE

columna_1
	btfsc PORTB,RB5
RETFIE
	movlw .1
	movwf columna
	call identifica_tecla
RETFIE

columna_2
	btfsc PORTB,RB6
RETFIE
	movlw .2
	movwf columna
	call identifica_tecla
RETFIE

columna_3
	btfsc PORTB,RB7
RETFIE
	movlw .3
	movwf columna
	call identifica_tecla
RETFIE
;------------ COMPROBACIÓN FILA -----------------------------------------------
identifica_tecla
	incf N,1  			;VOY CONTANDO EL NUMERO DE CAMBIO DE FILAS
	movlw .5 			;CUANDO N=5 YA SE HA COMPROBADO LA ULTIMA FILA
	subwf N,0
	btfsc STATUS,Z 		;si Z=1 es ultima fila vamos a goto
	goto ultimafila  
	movlw 0x30  		;vamos habilitando y deshabiliando las diferentes filas, 1º FILA0
	movwf FSR
	decf PT,1
	movf PT,0
	addwf FSR,1
	movf INDF,0
	movwf PORTC
	movf columna,0
	addwf PCL,F   		;Nos dirigimos al goto que nos indica columna
	goto EUREKA_RB4
	goto EUREKA_RB5
	goto EUREKA_RB6
	goto EUREKA_RB7
RETFIE
numerodedato
	movwf TECLA
	movf N_DATO,0
	addwf PCL,F
	nop
	goto PRIMERDATO
	goto SEGUNDODATO
	goto TERCERDATO
	goto CUARTODATO

EUREKA_RB4
	btfsc PORTB,RB4   	;Si RBX=0 tecla en esta fila, si RBX=1 no es la fila
goto identifica_tecla
	
	movlw 0x31   		;Valores de las teclas
	movwf NUM_1
	movlw 0x34
	movwf NUM_4
	movlw 0x37
	movwf NUM_7
	movlw 0x2A
	movwf ASTER
	
	incf N_DATO,1
	btfss PORTC,RC0 	;Comprobamos las diferentes filas, para ver
	movf NUM_1,0 		;cual es la fila habilitada
	btfss PORTC,RC1
	movf NUM_4,0
	btfss PORTC,RC2
	movf NUM_7,0
	btfss PORTC,RC3
	movf ASTER,0
	goto numerodedato
RETFIE

EUREKA_RB5
	btfsc PORTB,RB5
goto identifica_tecla
	movlw 0x32
	movwf NUM_2
	movlw 0x35
	movwf NUM_5
	movlw 0x38
	movwf NUM_8
	movlw 0x30
	movwf NUM_0
	
	incf N_DATO,1
	btfss PORTC,RC0
	movf NUM_2,0
	btfss PORTC,RC1
	movf NUM_5,0
	btfss PORTC,RC2
	movf NUM_8,0
	btfss PORTC,RC3
	movf NUM_0,0
	goto numerodedato
RETFIE

EUREKA_RB6
	btfsc PORTB,RB6
goto identifica_tecla
	movlw 0x33
	movwf NUM_3
	movlw 0x36
	movwf NUM_6
	movlw 0x39
	movwf NUM_9
	movlw 0x23
	movwf ALMH

	incf N_DATO,1
	btfss PORTC,RC0
	movf NUM_3,0
	btfss PORTC,RC1
	movf NUM_6,0
	btfss PORTC,RC2
	movf NUM_9,0
	btfss PORTC,RC3
	movf ALMH,0
	goto numerodedato
RETFIE

EUREKA_RB7
	btfsc PORTB,RB7
goto identifica_tecla
	movlw 0x41 			
	movwf LET_A
	movlw 0x42
	movwf LET_B
	movlw 0x43
	movwf LET_C
	movlw 0x44
	movwf LET_D

	incf N_DATO,1
	btfss PORTC,RC0
	movf LET_A,0
	btfss PORTC,RC1
	movf LET_B,0
	btfss PORTC,RC2
	movf LET_C,0
	btfss PORTC,RC3
	movf LET_D,0
	goto numerodedato
RETFIE

HABILITAR_FILAS
	bcf PORTC,RC0 		;Habilitamos todas las filas
	bcf PORTC,RC1
	bcf PORTC,RC2
	bcf PORTC,RC3
RETURN

ultimafila
	movlw .5 			;Ponemos PT a su valor original
	movwf PT
	clrf N 				;Reseteamos el contador N
	movlw 0xFF
	movwf PORTC 		;Le asignamos el valor 0xFF a PORTC
	call HABILITAR_FILAS
RETFIE
;------------ GUARDADO DE 4 TECLAS  PULSADAS ----------------------------------------
PRIMERDATO
	movf TECLA,0
	movwf DATO1
	movlw .5 			;Ponemos PT a su valor original
	movwf PT
	clrf N 				;Reseteamos el valor del contador N
	call HABILITAR_FILAS
RETFIE

SEGUNDODATO
	movf TECLA,0
	movwf DATO2
	movlw .5 			;Ponemos PT a su valor original
	movwf PT
	clrf N 				;Reseteamos el valor del contador N
	call HABILITAR_FILAS
RETFIE

TERCERDATO
	movf TECLA,0
	movwf DATO3
	movlw .5 			;Ponemos PT a su valor original
	movwf PT
	clrf N 				;Reseteamos el valor del contador N
	call HABILITAR_FILAS
RETFIE

CUARTODATO
	movlw .5 			;Ponemos PT a su valor original
	movwf PT
	clrf N 				;Reseteamos el valor del contador N
	call HABILITAR_FILAS
	clrf N_DATO
	
	clrf N_ACIERTOS
	movf TECLA,0 ;------------REALIZAMOS LA COMPROBACION DE QUE CONTRASEÑA HEMOS METIDO-------------
	movwf DATO4
	
	movf DATO1,0
	sublw '1'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO2,0
	sublw '2'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO3,0
	sublw '3'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO4,0
	sublw '4'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf N_ACIERTOS,0
	sublw .4
	btfsc STATUS,Z
	goto ES_DIEGO
	
	clrf N_ACIERTOS
	
	movf DATO1,0
	sublw 'A'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO2,0
	sublw '3'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO3,0
	sublw '1'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO4,0
	sublw '0'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf N_ACIERTOS,0
	sublw .4
	btfsc STATUS,Z
	goto ES_ANTOLINOS
	
	clrf N_ACIERTOS
	
	movf DATO1,0
	sublw '7'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO2,0
	sublw '8'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO3,0
	sublw '9'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf DATO4,0
	sublw 'D'
	btfsc STATUS,Z
	incf N_ACIERTOS,1
	movf N_ACIERTOS,0
	sublw .4
	btfsc STATUS,Z
	goto ES_GARCIA
	
	clrf N_ACIERTOS
	goto NO_VALIDO
RETFIE

ES_DIEGO
	call comprobar_estado

	movlw 'D'
	movwf 0x78
	movlw 'I'
	movwf 0x77
	movlw 'E'
	movwf 0x76
	movlw 'G'
	movwf 0x75
	movlw 'O'
	movwf 0x74
	movlw 0x20
	movwf 0x73
	movlw 's'
	movwf 0x72
	movlw '0'
	movwf 0x71
	movlw '1'
	movwf 0x70
	movf ESTADO,0
	movwf 0x6F
	movlw .10
	movwf 0x6D
	movlw .13
	movwf 0x6E

	movlw .12
	movwf PT_ID
	movlw 0x79
	movwf FSR
	call HABILITA_TXIE
RETFIE

ES_ANTOLINOS
	call comprobar_estado

	movlw 'A'
	movwf 0x7C
	movlw 'N'
	movwf 0x7B
	movlw 'T'
	movwf 0x7A
	movlw 'O'
	movwf 0x79
	movlw 'L'
	movwf 0x78
	movlw 'I'
	movwf 0x77
	movlw 'N'
	movwf 0x76
	movlw 'O'
	movwf 0x75
	movlw 'S'
	movwf 0x74
	movlw 0x20
	movwf 0x73
	movlw 's'
	movwf 0x72
	movlw '0'
	movwf 0x71
	movlw '1'
	movwf 0x70
	movf ESTADO,0
	movwf 0x6F
	movlw .10
	movwf 0x6D
	movlw .13
	movwf 0x6E

	movlw .16
	movwf PT_ID
	movlw 0x7D
	movwf FSR
	call HABILITA_TXIE
RETFIE

ES_GARCIA
	call comprobar_estado

	movlw 'G'
	movwf 0x79
	movlw 'A'
	movwf 0x78
	movlw 'R'
	movwf 0x77
	movlw 'C'
	movwf 0x76
	movlw 'I'
	movwf 0x75
	movlw 'A'
	movwf 0x74
	movlw 0x20
	movwf 0x73
	movlw 's'
	movwf 0x72
	movlw '0'
	movwf 0x71
	movlw '1'
	movwf 0x70
	movf ESTADO,0
	movwf 0x6F
	movlw .10
	movwf 0x6D
	movlw .13
	movwf 0x6E	

	movlw .13
	movwf PT_ID
	movlw 0x7A
	movwf FSR
	call HABILITA_TXIE
RETFIE

NO_VALIDO
	movlw 'N'
	movwf 0x78
	movlw 'O'
	movwf 0x77
	movlw 0x20
	movwf 0x76
	movlw 'V'
	movwf 0x75
	movlw 'A'
	movwf 0x74
	movlw 'L'
	movwf 0x73
	movlw 'I'
	movwf 0x72
	movlw 'D'	
	movwf 0x71
	movlw 'O'
	movwf 0x70
	movlw .10
	movwf 0x6F
	movlw .13
	movwf 0x6D
	
	movlw .11
	movwf PT_ID
	movlw 0x79
	movwf FSR
	call HABILITA_TXIE
RETFIE

;--------------- COMPROBACION DE ESTADOS --------------------------------
comprobar_estado
	movf ESTADO,0       ;COMPRUEBO SI ES DESACTIVADO
	sublw 'S'   		;desactivado
	btfsc STATUS,Z
	goto CAMBIAR_ACTIVADO_LOCAL

	movf ESTADO,0       ;COMPRUEBO SI ES ACTIVADO
	sublw 'R' 			;activado
	btfsc STATUS,Z
	goto CAMBIAR_DESACTIVADO

	movf ESTADO,0       ;COMPRUEBO SI ES DETECTADO
	sublw 'D' 			;detectado
	btfsc STATUS,Z
	goto CAMBIAR_DESACTIVADO

	movf ESTADO,0       ;COMPRUEBO SI ES DISPARADO, aunque se puede no poner
	sublw 'F' 			;disparado
	btfsc STATUS,Z
	RETURN        		;SI ES DISPARADO NO DEBERIA HACER NADA
RETURN

CAMBIAR_DESACTIVADO   	;CAMBIAMOS AL ESTADO DESACTIVADO
	movlw 'S'
	movwf ESTADO
	movlw b'00000111'
	movwf PORTA
	bcf QUIERO_ESPERAR,2
	bcf INTCON,T0IE
RETURN

CAMBIAR_ACTIVADO_LOCAL
	bsf QUIERO_ESPERAR,0
	bcf QUIERO_ESPERAR,1
	bcf QUIERO_ESPERAR,2
RETURN
;-------------- HABILITACION DE TRANSMISION ----------------------------
HABILITA_TXIE
	bsf STATUS,RP0
	bsf PIE1,TXIE
	bcf STATUS,RP0
RETURN
;------------- SENSOR DE MOVIMIENTO EN RB0 -----------------------------

ISR_RB0
	movf ESTADO,0 		;COMPROBAMOS SI ESTAMOS EN ACTIVADO
	sublw 'R'
	bcf INTCON,INTF
	btfsc STATUS,Z
	call CAMBIAR_DETECTADO	
RETFIE

CAMBIAR_DETECTADO
	movlw 'D'
	movwf ESTADO
	movlw b'00000100'
	movwf PORTA
	
	movlw 's'    
	movwf 0x72
	movlw '0'
	movwf 0x71
	movlw '1'
	movwf 0x70
	movf ESTADO,0
	movwf 0x6F
	movlw .10
	movwf 0x6D
	movlw .13
	movwf 0x6E

	movlw .6
	movwf PT_ID
	movlw 0x73
	movwf FSR	
	call HABILITA_TXIE
	bsf QUIERO_ESPERAR,1
	bcf QUIERO_ESPERAR,2
	bcf INTCON,T0IF
RETURN

;-------------- INTERRUPCION TMR0 ------------------------------------
ISR_TMR0
	movlw .60	
	movwf TMR0
	bcf INTCON,T0IF
	movf VUELTA,0 		;MOVEMOS N_TIEMPO SOBRE SI MISMA, SI ES 0 VA A GOTO
	sublw .2
	btfsc STATUS,Z
	call CAMBIAR_DISPARADO 
	decfsz N_TIEMPO,1 	;DECREMENTAMOS HASTA CONSEGUIR QUE N_TIEMPO=0
RETFIE
	movlw .150
	movwf N_TIEMPO
	incf VUELTA
RETFIE
            			; VEMOS CUAL HA SIDO NUESTRA ESPERA
CAMBIAR_DISPARADO 		; SI HEMOS ESPERADO 15s CAMBIAMOS A DISPARADO
	clrf VUELTA
	movlw 'F'
	movwf ESTADO
	movlw b'00000001' 	;VALOR ROJO PARA EL LED.
	movwf PORTA
	movlw 's'    
	movwf 0x72
	movlw '0'
	movwf 0x71
	movlw '1'
	movwf 0x70
	movf ESTADO,0
	movwf 0x6F
	movlw .10
	movwf 0x6D
	movlw .13
	movwf 0x6E

	movlw .6
	movwf PT_ID
	movlw 0x73
	movwf FSR	
	call HABILITA_TXIE	
	bcf INTCON,T0IE
	bcf QUIERO_ESPERAR,1
	bcf QUIERO_ESPERAR,2
RETURN

CAMBIAR_ACTIVADO 		;SI HEMOS ESPERADO 10s CAMBIAMOS A ACTIVADO
	bcf INTCON,T0IE
	clrf QUIERO_ESPERAR
	movlw 'R'
	movwf ESTADO
	movlw b'0000010'
	movwf PORTA
	movlw 's'    
	movwf 0x72
	movlw '0'
	movwf 0x71
	movlw '1'
	movwf 0x70
	movf ESTADO,0
	movwf 0x6F
	movlw .10
	movwf 0x6D
	movlw .13
	movwf 0x6E
	movlw .6
	movwf PT_ID
	movlw 0x73
	movwf FSR	
	call HABILITA_TXIE		
RETFIE
;--------------- RECEPCION SISTEMA REMOTO ------------------------------------------------
ISR_RCIF
	btfss QUIERO_ESPERAR,2
	bcf INTCON,T0IF

	movlw .0
	subwf N_RECIBIDO,0
	btfsc STATUS,Z
	goto guarda_recibido1
	
	movlw .1
	subwf N_RECIBIDO,0
	btfsc STATUS,Z
	goto guarda_recibido2

	movlw .2
	subwf N_RECIBIDO,0
	btfsc STATUS,Z
	goto guarda_recibido3

	movlw .3
	subwf N_RECIBIDO,0
	btfsc STATUS,Z
	goto guarda_recibido4
	
	movf RCREG,0
	movwf RX_5
	
	movf RX_1,0
	sublw 'c'
	btfsc STATUS,Z
	goto comprueba_s
	clrf N_RECIBIDO
RETFIE

guarda_recibido1
	movf RCREG,0
	movwf RX_1
	incf N_RECIBIDO
RETFIE

guarda_recibido2
	movf RCREG,0
	movwf RX_2
	incf N_RECIBIDO
RETFIE

guarda_recibido3
	movf  RCREG,0
	movwf RX_3
	incf N_RECIBIDO
RETFIE

guarda_recibido4
	movf  RCREG,0
	movwf RX_4
	incf N_RECIBIDO
RETFIE

comprueba_s
	clrf N_RECIBIDO
	movf RX_2,0	
	sublw 's'
	btfsc STATUS,Z
	goto comprueba_0
RETFIE

comprueba_0
	movf RX_3,0
	sublw '0'
	btfsc STATUS,Z
	goto comprueba_1
RETFIE

comprueba_1
	movf RX_4,0
	sublw '1'
	btfsc STATUS,Z
	goto comprueba_ultimo
RETFIE

comprueba_ultimo
	movf RX_5,0
	sublw 'R'
	btfsc STATUS,Z
	goto CAMBIAR_ACTIVADO_REMOTO
	movf RX_5,0
	sublw 'S'
	btfsc STATUS,Z
	call CAMBIAR_DESACTIVADO
RETFIE

CAMBIAR_ACTIVADO_REMOTO
	movlw 'R'
	movwf ESTADO
	movlw b'0000010'
	movwf PORTA
	bcf INTCON,T0IE
RETFIE
;------------ INTERRUPCION DE TRANSMISION A SISTEMA REMOTO -------------
ISR_TXIF
	decf FSR,1			
	movf INDF,0
	movwf TXREG
	call bucle_retardo
	btfss QUIERO_ESPERAR,2  ;limpio T0IF si QUIERO_ESPERAR=0 
	bcf INTCON,T0IF			;hago esto para que no entre en T0IF
	decfsz PT_ID,1			;a no ser que estemos contando 15s
RETFIE
	bsf STATUS,RP0
	bcf PIE1,TXIE
	bcf STATUS,RP0
	btfsc QUIERO_ESPERAR,0
	goto ARMANDO_EL_JALEO
	btfsc QUIERO_ESPERAR,1
	goto AZUL_MAS_RAPIDO	
RETFIE

AZUL_MAS_RAPIDO
	bcf QUIERO_ESPERAR,1
	bsf QUIERO_ESPERAR,2	
	movlw .150  			;GUARDAMOS N=150 PARA CONTAR 15s CON TMR0 EN 2 VECES
	movwf N_TIEMPO
	movlw .61 
	movf TMR0
	bsf INTCON,T0IE
RETFIE

ARMANDO_EL_JALEO
retraso
	call bucle_retardo_10S 	
	decfsz ESPERANDO,1		
	goto retraso		
	movlw .65				
	movwf ESPERANDO
retraso1					
	call bucle_retardo_10S 	
	decfsz ESPERANDO,1		
	goto retraso1			
	movlw .65
	movwf ESPERANDO
	clrf QUIERO_ESPERAR
	goto CAMBIAR_ACTIVADO	
RETFIE
;------------ BUCLE RETARDO 30ms --------------------------------------
bucle_retardo        
centesi
     movlw   .40
     movwf   CONT1  
retardo
     decfsz  CONT1, 1
     goto    retardo
     nop
     decfsz  CONT2, 1
     goto    centesi
RETURN
;------------ BUCLE RETARDO 10s --------------------------------------
bucle_retardo_10S     
centesi_2
	btfss QUIERO_ESPERAR,1
	bcf INTCON,T0IF
     movlw   .129
     movwf   CONT1  
retardo_2
     decfsz  CONT1, 1
     goto    retardo_2
     nop
     decfsz  CONT2, 1
     goto    centesi_2
RETURN
END

; Hecho por Los Telematicos