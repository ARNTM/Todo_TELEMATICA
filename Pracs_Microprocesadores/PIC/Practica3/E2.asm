;-------------------------------------------------------
		LIST p=16F876A
		INCLUDE "p16f876a.inc"
		__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
CONT	EQU	0x20
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

		BSF		STATUS,RP0 ; Cambiamos al banco 1
		CLRF	TRISC ; Ponemos todo TRISC como salida
		BCF		OPTION_REG, T0CS ; Ponemos T0CS a 0 para usar el reloj interno
		BCF		OPTION_REG, PSA ; Asignamos el preescalado a Timer0
		BSF		OPTION_REG, PS0 ; Ponemos PS0 a 1
		BSF		OPTION_REG, PS1 ; Ponemos PS1 a 1
		BSF		OPTION_REG, PS2 ; Ponemos PS2 a 1
								; Esto lo hacemos para que la escala del contador sea 1:256
								; (256-N)*Preescaler*T_Cycle -> Dividimos el tiempo total entre
								; cada preescaler y el resultado tiene que ser menor de 255

		BCF		STATUS,RP0 ; Cambiamos al banco 0

		MOVLW	.119 ; Movemos el valor decimal 119 a WREG
		MOVWF	TMR0 ; Copiamos en TMR0 el valor de WREG

		MOVLW	.0 ; Movemos el valor decimal 0 a WREG
		MOVWF	CONT ; Copiamos en CONT el valor de WREG

main
		goto main ; Bucle principal
;-------------------------------------------------------
ISR

		MOVLW	.120 ; Movemos el valor decimal 139 a WREG
		MOVWF	TMR0 ; Copiamos en TMR0 el valor de WREG para volver a inicializarlo
		INCF 	CONT,1 ;Incrementamos en 1 CONT y lo guardamos en CONT
		MOVF 	CONT,0 ; Copiamos CONT en WREG
		MOVWF 	PORTC ; Copiamos WREG en PORTC
		BCF 	INTCON, T0IF ;Ponemos a 0 el FLAG de interrupcion de T0IE

RETFIE
;-------------------------------------------------------

END

; Hecho por Los Telematicos