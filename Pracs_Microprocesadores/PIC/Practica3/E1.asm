;-------------------------------------------------------
		LIST p=16F876A
		INCLUDE "p16f876a.inc"
		__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
CONT	EQU		0x20
;-------------------------------------------------------
		ORG 0
		goto inicio

		ORG 4
		goto ISR
		ORG 5
;-------------------------------------------------------
	
inicio
		BSF	INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
		BSF	INTCON, T0IE ; Habilitamos el BIT de overflow de TMR0 - PAGINA 20 del manual resumido

		BSF	STATUS,RP0 ; Cambiamos al banco 1

		BCF	OPTION_REG, T0CS ; Ponemos T0CS a 0 para usar el reloj interno
		BSF	OPTION_REG, PSA ; Asignamos el preescalado al Watchdog Timer (WDT)

		BCF	STATUS,RP0 ; Cambiamos al banco 0

		MOVLW	.151 ; Movemos el valor decimal 151 a WREG
		MOVWF	TMR0 ; Copiamos en TMR0 el valor de WREG

		MOVLW	.0 ; Movemos el valor decimal 0 a WREG
		MOVWF	CONT ; Copiamos en CONT el valor de WREG

main
		goto main ; Bucle principal

;-------------------------------------------------------
ISR

		MOVLW	.139 ; Movemos el valor decimal 139 a WREG
		MOVWF	TMR0 ; Copiamos en TMR0 el valor de WREG para volver a inicializarlo
		INCF 	CONT,1 ;Incrementamos en 1 CONT, y lo guardamos sobre si mismo
		BCF 	INTCON, T0IF ;Ponemos a 0 el FLAG de interrupcion de T0IE

RETFIE
;-------------------------------------------------------

END

; Hecho por Los Telematicos