;-------------------------------------------------------
			LIST p=16F876A
			include	"p16f876a.inc"
			__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
SEG			EQU		0x20
CENT		EQU		0x21
CONTCENT	EQU		0x22
CONT1		EQU		0x23
CONT2		EQU		0X24
;-------------------------------------------------------
			ORG		0
			goto	inicio	
			ORG		5
;-------------------------------------------------------

inicio	
			CLRF	SEG ; Inicializamos la variable SEG a 0
			CLRF	CENT ; Inicializamos la variable CENT a 0

dec_cent

			MOVLW	.100 ; Movemos el decimal 100 a WREG
			MOVWF	CONTCENT ; Copiamos WREG en CONTCENT

main

			CALL	bucle_retardo ; Llamamos a la subrutina "bucle_retardo"
			DECFSZ	CONTCENT,1 ; Decrementamos CONTCENT, si es igual a 0 saltamos a la LINEA 32
							   ; y haríamos un RETURN
			goto	main ; Saltamos a dec_cent (LINEA 26)
			INCF	SEG,1 ; Incrementamos SEG en 1, y lo guardamos en SEG
			CLRF	CENT ; Borramos CENT
			goto	dec_cent ; Saltamos a dec_cent (LINEA 21)

;-------------------------------------------------------

bucle_retardo

			MOVLW	.97 ; Movemos el decimal 97 a WREG (lo hemos tenido que calcular) 
			MOVWF	CONT2 ; Copiamos WREG en CONT2

ciclo2

			MOVLW	.33 ; Movemos el decimal 33 a WREG (lo hemos tenido que calcular) 
			MOVWF	CONT1 ; Copiamos WREG en CONT1

ciclo1
.
			DECFSZ	CONT1,1 ; Decrementamos CONT1, si es igual a 0 saltamos a la LINEA 53
							; y haríamos un RETURN
			goto	ciclo1  ; Saltamos a "ciclo2"
		
			DECFSZ	CONT2,1 ; Decrementamos CONT2, si es igual a 0 saltamos a la LINEA 57
							; y haríamos un RETURN
			goto	ciclo2  ; Saltamos a "ciclo2"
			
			INCF	CENT,1 ; Incrementa "CENT" en 1. El ,1 es para guardar el valor en CENT	
RETURN ; Salimos de la subrutina y hacemos "INCF ciclo,1" (LINEA 28)

;-------------------------------------------------------

END

; Hecho por Los Telematicos