;-------------------------------------------------------
		LIST p=16F876A
		INCLUDE "p16f876a.inc"
		__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
		ORG 0
		goto inicio
		ORG 5
;-------------------------------------------------------

inicio

		BSF		STATUS,RP0 ; Cambiamos al banco 1 para modificar TRISC y TRISB

		CLRF	TRISC ;Ponemos TRISC a 0 para configurarlo como salida (1 = 1nput - 0 = 0utput)
		MOVLW	b'11111111' ; Movemos el número a WREG para después copiarlo en TRISB
		MOVWF	TRISB ;Ponemos TRISB a 1 para configurarlo como entrada (1 = 1nput - 0 = 0utput)

		BCF		STATUS,RP0 ; Cambiamos al banco 0, ya que de normal trabajamos en este banco
bucle

		MOVF	PORTB,0 ; Copiamos PORTB en el WREG (por eso ponemos PORTB,0 - si pusieramos PORTB,1 el valor de PORTB lo volveriamos a meter en PORTB)
		MOVWF 	PORTC ; Copiamos WREG en PORTC

goto bucle

END

; Hecho por Los Telematicos