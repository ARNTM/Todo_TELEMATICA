	list p = 16F876A
	include"p16f876a.inc"
	__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF

TECLA	equ	0x20
XOR		equ 0x21
columna equ 0x22
VALORB  equ 0x23
PT		equ 0x24

CONT1	equ	0x25
CONT2	equ	0x26
CONT3	equ	0x27
CENTESI	equ	0x28

N		equ	0x29

FILA0	equ 0x34
FILA1	equ	0x33
FILA2	equ	0x32
FILA3	equ 0x31

NUM_0 	equ 0x40
NUM_1	equ	0x41
NUM_2	equ	0x42
NUM_3 	equ 0x43
NUM_4	equ	0x44
NUM_5	equ	0x45
NUM_6 	equ 0x46
NUM_7	equ	0x47
NUM_8	equ	0x48
NUM_9 	equ 0x49
LET_A	equ	0x4A
LET_B	equ	0x4B
LET_C	equ 0x4C
LET_D	equ 0x4D
ASTER	equ 0x4E
ALMH	equ 0x4F
	
	org 0
	goto inicio
	org 4
	goto ISR
	org 5

inicio	
	
	movlw 0x31   ;Valores de las teclas
	movwf NUM_1
	movlw 0x32
	movwf NUM_2
	movlw 0x33
	movwf NUM_3
	movlw 0x34
	movwf NUM_4
	movlw 0x35
	movwf NUM_5
	movlw 0x36
	movwf NUM_6
	movlw 0x37
	movwf NUM_7
	movlw 0x38
	movwf NUM_8
	movlw 0x39
	movwf NUM_9
	movlw 0x30
	movwf NUM_0
	movlw 0x41
	movwf LET_A
	movlw 0x42
	movwf LET_B
	movlw 0x43
	movwf LET_C
	movlw 0x44
	movwf LET_D
	movlw 0x23
	movwf ALMH
	movlw 0x2A
	movwf ASTER
	
	movlw b'11111110'  ;filas habilitadas y deshabilitadas
	movwf FILA0
	movlw b'11111101'
	movwf FILA1
	movlw b'11111011'
	movwf FILA2
	movlw b'11110111'
	movwf FILA3

	movlw .5
	movwf PT
	movlw .0
	movwf N
	clrf TECLA

	bsf STATUS,RP0	
	movlw b'11110000' ;Ponemos RB[7:4] entrada, RB[3:0] salida
	movwf TRISB	
	clrf TRISC
	bcf OPTION_REG,7
	bcf STATUS,RP0

	movlw 0xF0
	movwf PORTB
	movf PORTB,0
	movwf VALORB

	bsf INTCON,GIE
	bsf INTCON,PEIE
	bsf INTCON,RBIE	
	
main
	goto main

ISR
	call bucle_retardo
	
	movf PORTB,0 
	xorwf VALORB,0 ;comprobamos cuál es el valor de PORTB que ha cambiado
	movwf XOR
	movf PORTB,0
	movwf VALORB
	bcf INTCON,RBIF
	
	btfsc XOR,RB4  ; IDENTIFICAMOS QUE COLUMNA ES LA ACTIVADA
	goto columna_0
	btfsc XOR,RB5
	goto columna_1
	btfsc XOR,RB6
	goto columna_2
	btfsc XOR,RB7
	goto columna_3
RETFIE

;---------- VALOR COLUMNA ------------		

columna_0
	btfsc PORTB,RB4 ;Comprobamos que RBX=0 --> pasa, si RBX=1 --> RETFIE
RETFIE
	movlw .0
	movwf columna ;Asignamos valores determinados a columna
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

;------------ COMPROBACIÓN FILA ---------------

identifica_tecla	
	incf N,1  ;VOY CONTANDO EL NUMERO DE CAMBIO DE FILAS
	movlw .5 ; CUANDO N=5 YA SE HA COMPROBADO LA ULTIMA FILA
	subwf N,0
	btfsc STATUS,Z ;si Z=1 es ultima fila vamos a goto
goto ultimafila  ; 	
	movlw 0x30  ;vamos habilitando y deshabiliando las diferentes filas, 1º FILA0
	movwf FSR	
	decf PT,1
	movf PT,0
	addwf FSR,1
	movf INDF,0
	movwf PORTB 
	movf columna,0
	addwf PCL,F   ;Nos dirigimos al goto que nos indica columna
	goto EUREKA_RB4
	goto EUREKA_RB5
	goto EUREKA_RB6
	goto EUREKA_RB7
RETFIE

EUREKA_RB4	
	btfsc PORTB,RB4   ;Si RBX=0 tecla en esta fila, si RBX=1 no es la fila
goto identifica_tecla
	btfss PORTB,RB0  ;Comprobamos las diferentes filas, para ver
	movf NUM_1,0	 ;cual es la fila habilitada
	btfss PORTB,RB1
	movf NUM_4,0
	btfss PORTB,RB2
	movf NUM_7,0
	btfss PORTB,RB3
	movf ASTER,0
	movwf TECLA
	movf TECLA,0
	movwf PORTC  ;movemos el valor de la tecla a PORTC
	movlw .5	;Ponemos PT a su valor original	
	movwf PT
	clrf N		;Reseteamos el valor del contador N
	call HABILITAR_FILAS 
RETFIE

EUREKA_RB5
	btfsc PORTB,RB5
goto identifica_tecla
	btfss PORTB,RB0
	movf NUM_2,0
	btfss PORTB,RB1
	movf NUM_5,0
	btfss PORTB,RB2
	movf NUM_8,0
	btfss PORTB,RB3
	movf NUM_0,0
	movwf TECLA	
	movf TECLA,0 
	movwf PORTC
	movlw .5
	movwf PT
	clrf N
	call HABILITAR_FILAS
RETFIE
	
EUREKA_RB6
	btfsc PORTB,RB6
goto identifica_tecla
	btfss PORTB,RB0
	movf NUM_3,0
	btfss PORTB,RB1
	movf NUM_6,0
	btfss PORTB,RB2
	movf NUM_9,0
	btfss PORTB,RB3
	movf ALMH,0
	movwf TECLA	
	movf TECLA,0
	movwf PORTC
	movlw .5
	movwf PT
	clrf N
	call HABILITAR_FILAS
RETFIE
	
EUREKA_RB7
	btfsc PORTB,RB7
goto identifica_tecla
	btfss PORTB,RB0
	movf LET_A,0
	btfss PORTB,RB1
	movf LET_B,0
	btfss PORTB,RB2
	movf LET_C,0
	btfss PORTB,RB3
	movf LET_D,0
	movwf TECLA
	movf TECLA,0 ;podríamos pasar directamente el valor de WREG a PORTC
	movwf PORTC
	movlw .5
	movwf PT
	clrf N
	call HABILITAR_FILAS
RETFIE

HABILITAR_FILAS
	bcf PORTB,RB0 ;Habilitamos todas las filas
	bcf PORTB,RB1
	bcf PORTB,RB2
	bcf PORTB,RB3
RETURN

ultimafila
	movlw .5 ;Ponemos PT a su valor original
	movwf PT
	clrf N ;Reseteamos el contador N
	movlw 0xFF	
	movwf PORTC ;Le asignamos el valor 0xFF a PORTC
	call HABILITAR_FILAS
RETFIE

;------------ BUCLE RETARDO 30ms ---------------

bucle_retardo ;Bucle retardo de 30ms
     movlw   .3
     movwf   CONT3         
centesi
     movlw   .40
     movwf   CONT1   
retardo
     decfsz  CONT1, 1

     goto    retardo
     nop
     decfsz  CONT2, 1

     goto    centesi
     incf    CENTESI,1
     decfsz  CONT3, 1
RETURN 

END

; Hecho por Los Telematicos