;-------------------------------------------------------
			LIST p=16F876A
			INCLUDE "p16f876a.inc"
			__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
CONT1       EQU     0x20    
CONT2       EQU     0x21
CENTESI     EQU     0x23
SEGUNDOS    EQU     0x24
CONT3       EQU     0x25
VALORC	    EQU	    0x26
XOR 		EQU     0x27
;-------------------------------------------------------
			ORG 0
			goto inicio
	
			ORG 4
			goto ISR
			ORG 5
;-------------------------------------------------------

inicio
			BSF 	STATUS, RP0 ; Cambiamos al banco 1
	
			CLRF	TRISC ; Ponemos todo PORTC como salida
			MOVLW	b'11111111'
			MOVWF	TRISB
	
			BCF		STATUS, RP0 ; Cambiamos al banco 0
	
			MOVLW 	.0
			MOVWF	PORTC ; Inicializamos PORTC a 0
			MOVF	PORTB,0 ; Copiamos el valor de PORTB en WREG
			MOVWF	VALORC ; Copiamos WREG en VALORC
	
			BSF	INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF	INTCON, RBIE ; Habilitamos el BIT de interrupciones del puerto RB - PAGINA 20 del manual resumido

main
			goto main
;-------------------------------------------------------
ISR
			CALL bucle_retardo ;Llamamos al bucle de retardo
	
			MOVF	PORTB,0 ; Copiamos PORTB en WREG
			XORWF	VALORC,0 ; Hacemos la XOR de WREG con VALORC
			MOVWF	XOR ; Copiamos el resultado en XOR
	
			MOVF	PORTB,0 ; Copiamos PORTB en WREG
			MOVWF	VALORC ; Copiamos WREG en VALORC
			BCF		INTCON, RBIF ; Borramos el FLAG de interrupción
	
			BTFSC	XOR,4 ; Si el BIT 4 de XOR es 0 saltamos la instrucción
			goto	sumar
			BTFSC	XOR,5 ; Si el BIT 5 de XOR es 0 saltamos la instrucción
			goto	restar
			BTFSC	XOR,6 ; Si el BIT 6 de XOR es 0 saltamos la instrucción
			goto	reseteo
RETFIE
;-------------------------------------------------------

sumar
			BTFSS	PORTB,4 ; Comprobamos el BIT 4 de PORTB para ver si está presionado
			INCF	PORTC,1 ; Incrementamos en 1 el valor de PORTC y lo guardamos sobre él mismo
RETFIE

restar
			BTFSC	PORTB,5  ; Comprobamos el BIT 5 de PORTB para ver si hemos soltado ya el pulsador
			DECF	PORTC,1 ; Decrementamos en 1 el valor de PORTC y lo guardamos sobre él mismo
RETFIE

reseteo
			BTFSS	PORTB,6  ; Comprobamos el BIT 6 de PORTB para ver si está presionado
			CLRF	PORTC ; Borramos PORTC
RETFIE


; Bucle de retardo del ejercicio 2 de la práctica 1 (Está ajustado a 30ms)
bucle_retardo
            MOVLW   .3
            MOVWF   CONT3
           
centesi
            MOVLW   .40
            MOVWF   CONT1
           
retardo
            DECFSZ  CONT1, 1
 
        	goto    retardo
            NOP
            DECFSZ  CONT2, 1
 
        	goto    centesi
            INCF    CENTESI,1
            DECFSZ  CONT3, 1
 
RETURN

END

; Hecho por Los Telematicos