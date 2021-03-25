;-------------------------------------------------------
		LIST p=16F876A
		INCLUDE "p16f876a.inc"
		__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
N		EQU		0x20
;-------------------------------------------------------
			ORG 0
			goto inicio
	
			ORG 4
			goto ISR
			ORG 5
;-------------------------------------------------------

inicio

			BSF		INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
			BSF		INTCON, T0IE ; Habilitamos el BIT de overflow de TMR0 - PAGINA 20 del manual resumido
		 
			BSF 	STATUS,RP0 ; Cambiamos al banco 1

			BCF		OPTION_REG, T0CS ; Ponemos el BIT T0CS a 0 para indicar que usamos el reloj interno

;##### Configuramos el preescaler asignado al Timer0 (1:256)####
			BCF		OPTION_REG, PSA
			BSF		OPTION_REG, PS0
			BSF		OPTION_REG, PS1
			BSF		OPTION_REG, PS2
;###############################################################

			CLRF	TRISB ; Ponemos PORTB como salida
	
			MOVLW	b'11111111'
			MOVWF	TRISC ; Ponemos PORTC como entrada
			MOVWF	TRISA ; Ponemos PORTA como entrada

;##### Configuramos las entradas de PORTA como analógicas ####	
			BCF		ADCON1, ADFM ; Alineamos a la izquierda
			BCF		ADCON1, PCFG0
			BCF		ADCON1, PCFG1
			BCF		ADCON1, PCFG2
			BCF		ADCON1, PCFG3
;#############################################################
	
			BCF		STATUS,RP0 ; Cambiamos al banco 0
	
			BSF		ADCON0, ADON ; Habilitamos la conversión A/D
	
			MOVLW	.61
			MOVWF	TMR0 ; Ponemos TMR0 a 61
	
			MOVLW	.2
			MOVWF	N ; Ponemos N a 2

main
	goto main

;-------------------------------------------------------
ISR
			MOVLW	.61
			MOVWF	TMR0 ; Ponemos TMR0 a 61
			BCF 	INTCON, T0IF ; ;Ponemos a 0 el FLAG de interrupcion de T0IE
	
			DECFSZ 	N,1 ; Decrementamos N en 1 si es 0, saltamos RETFIE
RETFIE		
			MOVLW	.2 
			MOVWF	N ; Ponemos N a 2
			BTFSS	PORTC,RC1 ; Si RC1 es 1 saltamos la siguiente instrucción
			goto	convertir_AN2
			goto	convertir_AN0


convertir_AN2
;##### Seleccionamos el canal 2 ####
			BCF		ADCON0,CHS2
			BSF		ADCON0,CHS1
			BCF		ADCON0,CHS0
;###################################
	
			BSF		ADCON0,GO ; Ponemos el BIT GO a 1 para comenzar la conversión

	es1_0
			BTFSC	ADCON0,GO  ; Comprobamos si el BIT GO se ha puesto a 0, ya que automaticamente cambia al finalizar la conversión
	goto es1_0

			MOVF	ADRESH,0 ; Movemos los 8 bits más significativos de la convesión a WREG
			MOVWF	PORTB ; Copiamos WREG en PORTB
	
RETFIE

convertir_AN0
;##### Seleccionamos el canal 0 ####
			BCF		ADCON0,CHS2
			BCF		ADCON0,CHS1
			BCF		ADCON0,CHS0
;###################################
	
			BSF		ADCON0,GO ; Ponemos el BIT GO a 1 para comenzar la conversión

	es1_1
			BTFSC	ADCON0,GO  ; Comprobamos si el BIT GO se ha puesto a 0, ya que automaticamente cambia al finalizar la conversión
	goto es1_1

			MOVF	ADRESH,0  ; Movemos los 8 bits más significativos de la convesión a WREG
			MOVWF	PORTB  ; Copiamos WREG en PORTB

RETFIE
;-------------------------------------------------------

END

; Hecho por Los Telematicos