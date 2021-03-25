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


		BSF		STATUS,RP0 ; Cambiamos al banco 1 para modificar TRISB

		CLRF	TRISB ;Ponemos TRISB a 0 para configurarlo como salida (1 = 1nput - 0 = 0utput)

		BCF		STATUS,RP0 ; Cambiamos al banco 0, ya que de normal trabajamos en este banco

bucle

		MOVLW	b'10111001' ; Movemos el número a WREG
		MOVWF 	PORTB ;Movemos WREG a PORTB para que se enciendan los leds que queremos
		; Los leds los deberiamos ver de la siguiente manera
		; ENCENDIDO - APAGADO - ENCENDIDO - ENCENDIDO - ENCENDIDO - APAGADO - APAGADO - ENCENDIDO

goto bucle

END

; Hecho por Los Telematicos