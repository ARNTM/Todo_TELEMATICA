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
        
        BSF     STATUS,RP0 ; Cambiamos al banco 1 para modificar TRISA y ADCON1

		MOVLW   b'00000001' ; Movemos el número a WREG
        MOVWF   TRISA ; Configuramos el primer BIT de TRISA como entrada (1 = 1nput - 0 = 0utput)

		; -- VER PÁGINA 112 DEL MANUAL RESUMIDO --
		; PONEMOS TODOS LOS PIN EN DIGITAL --> 011X --> SE MIRA EN LA TABLA
		BSF	ADCON1, 0 ;X
		BSF	ADCON1,	1 ;1
		BSF	ADCON1,	2 ;1
		BCF	ADCON1,	3 ;0

        BCF     STATUS,RP0 ; Cambiamos al banco 0, ya que de normal trabajamos en este banco

       
bucle    
    	BTFSS	PORTA,0 ; Si el BIT 0 de PORTA está a 1, saltaremos a "goto encender", si no, "goto apagar"
		goto 	apagar ; Apagamos el LED
		goto 	encender; Encendemos el LED

encender
		BSF	PORTA,3 ;Activamos el PIN 3 de PORTA
		goto bucle ;Volvemos a la comprobación

apagar	
		BCF	PORTA,3 ;Desactivamos el PIN 3 de PORTA
		goto bucle ;Volvemos a la comprobación

 
END

; Hecho por Los Telematicos