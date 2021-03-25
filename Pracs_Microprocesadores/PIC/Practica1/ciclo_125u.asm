;-------------------------------------------------------	
			LIST p=16F876A
			include "p16f876a.inc"
;-------------------------------------------------------
ciclo		EQU		0x20
CONT1		EQU		0x21	
;-------------------------------------------------------	
			ORG		0
			goto 	inicio
			ORG 	5
;-------------------------------------------------------
	
inicio
			CLRF	ciclo	; Inicializamos la variable ciclo a 0

retardo

			CALL bucle_retardo ; Llamamos a la subrutina "bucle_retardo"
			INCF ciclo,1 ; Incrementa "ciclo" en 1. El ,1 es para guardar el valor en CICLO

goto retardo ; Vuelve "retardo"

;-------------------------------------------------------

bucle_retardo

			MOVLW	.39 ; Viendo el cronograma que nos dan, 
						; si sabemos que cada instrucción dura 1us 
						; y cada salto 2us, calculamos lo que nos 
						; queda para que nuestro ciclo dure 125us
						; en este caso 39
			MOVWF	CONT1 ; Movemos el decimal 39 a CONT1

bucle

			DECFSZ	CONT1,1	; Decrementamos CONT1, si es igual a 0 saltamos "goto bucle"
							; y haríamos un RETURN

goto	bucle ; Volvemos a "bucle"

RETURN ; Salimos de la subrutina y hacemos "INCF ciclo,1" (LINEA 19) 

;-------------------------------------------------------

END

; Hecho por Los Telematicos