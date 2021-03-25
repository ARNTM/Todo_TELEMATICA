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

        BSF     STATUS,RP0 ; Cambiamos al banco 1 para modificar TRISC y TRISB

        CLRF    TRISB ;Ponemos TRISB a 0 para configurarlo como salida (1 = 1nput - 0 = 0utput)
        MOVLW   b'00000100' ; Movemos el número a WREG para después copiarlo en TRISC
        MOVWF   TRISC ;Ponemos TRISC a 1 para configurarlo como entrada (1 = 1nput - 0 = 0utput)

        BCF     STATUS,RP0 ; Cambiamos al banco 0, ya que de normal trabajamos en este banco
       
bucle    
    	BTFSS	PORTC,2 ; Si el BIT 2 de PORTC está a 1, saltaremos a "goto encender", si no, "goto apagar"
		goto 	apagar ; Apagamos el LED
		goto 	encender ; Encendemos el LED

encender
		bsf	PORTB,5 ;Activamos el PIN 5 de PORTB
		goto bucle ;Volvemos a la comprobación

apagar	
		bcf	PORTB,5 ;Desactivamos el PIN 5 de PORTB
		goto bucle ;Volvemos a la comprobación

 
END

; Hecho por Los Telematicos