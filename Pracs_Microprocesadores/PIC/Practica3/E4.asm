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
			MOVLW	.255
			MOVF	TRISB ; Ponemos todo PORTB como entrada

			BCF		STATUS, RP0 ; Cambiamos al banco 

			BSF		INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF		INTCON, INTE ; Habilitamos el BIT de interrupciones externas de RB0 - PAGINA 20 del manual resumido
			MOVLW 	.0
			MOVWF	PORTC ; Inicializamos el PORTC en 0

main
			goto 	main
;-------------------------------------------------------
ISR
		
			CALL 	bucle_retardo ; Llamamos al bucle de retardo
			INCF	PORTC,1 ; Incrementamos en PORTC en 1 y lo guardamos sobre él mismo
			BCF		INTCON, INTF ; Borramos el FLAG de interrupción

RETFIE
;-------------------------------------------------------

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