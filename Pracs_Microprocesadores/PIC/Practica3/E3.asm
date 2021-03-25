;-------------------------------------------------------
		LIST p=16F876A
		INCLUDE "p16f876a.inc"
		__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF
;-------------------------------------------------------
N		EQU	0x20
STATE1	EQU	0x34
STATE2	EQU	0x33
STATE3	EQU	0x32
STATE4	EQU	0x31
PT		EQU	0x35
;-------------------------------------------------------
		ORG 0
		goto inicio

		ORG 4
		goto ISR
		ORG 5
;-------------------------------------------------------
	
inicio
		MOVLW	b'00001100' ; Cargamos los 4 estados
		MOVWF	STATE1		; 
		MOVLW	b'00000110'	; 
		MOVWF	STATE2		;
		MOVLW	b'00000011'	;
		MOVWF	STATE3		;
		MOVLW	b'00001001'	;
		MOVWF	STATE4		;

		MOVLW	.4 ; Cargamos el 4 en PT
		MOVWF	PT ;

		BSF		STATUS, RP0 ; Cambiamos al banco 1

		MOVLW	.255	; 
		MOVWF	TRISB	; Ponemos todo PORTB como entrada
		CLRF	TRISC	; Ponemos todo PORTC como salida

		BCF		OPTION_REG, T0CS ; Ponemos T0CS a 0 para usar el reloj interno
		BCF		OPTION_REG, PSA ; Asignamos el preescalado a Timer0
		BSF		OPTION_REG, PS0 ; Ponemos PS0 a 1
		BSF		OPTION_REG, PS1 ; Ponemos PS1 a 1
		BSF		OPTION_REG, PS2 ; Ponemos PS2 a 1
								; Ver E2
		BCF		STATUS, RP0 ; Cambiamos al banco 0

		BSF		INTCON, GIE ; Habilitamos el BIT de interrupciones - PAGINA 20 del manual resumido
		BSF		INTCON, T0IE ; Habilitamos el BIT de overflow de TMR0 - PAGINA 20 del manual resumido


		MOVLW	.61  ; 
		MOVWF	TMR0 ; Copiamos 61 en TMR0

		CALL 	ActualizaN 	; Actualizamos N, ya que esta es variable a través de los botones
							; N es la velocidad con la que varían los estados.

main
		goto main
;-------------------------------------------------------
ISR
		
		MOVLW	.120 ;
		MOVWF	TMR0 ; Copiamos 120 en TMR0
		BCF 	INTCON, T0IF ;Ponemos a 0 el FLAG de interrupcion de T0IE
		MOVF	N,1 ; Movemos N sobre si misma, si N es 0 se activará el BIT Z
		BTFSC	STATUS,Z ; Si el BIT Z es 0 salta a la LINEA 69, si no, comprueba_N
		goto	comprueba_N ;Comprueba N, esto es para que no salte estados.
		DECFSZ 	N,1 ; Decrementa N en 1 y salta si es 0, si es 0 actualizaremos N
RETFIE
		CALL 	ActualizaN ; Actualiza el valor de N
		
		MOVLW	0x30 ; 
		ADDWF	PT,0 ; Suma 0x30 más el valor actual de PT y lo guardas en WREG
		MOVWF	FSR  ; Mueve el valor WREG al puntero de registros 
		MOVF	INDF,0 ; Mueve el contenido de la dirección a la que apunte FRS a WREG

		CALL 	Cambio_PT ;Salta a la subrutina Cambio_PT
RETFIE
		MOVLW	.4 ;
		MOVWF	PT ; Vuelve a inicializar PT en 4
RETFIE

;-------------------------------------------------------
ActualizaN

		MOVF	PORTB,0 ; Copiamos PORTB en WREG
		MOVWF	N ; Copiamos WREG en N
		BCF		STATUS,C ; Ponemos a 0 el BIT de acarreo
		RRF		N,1 ; Desplazamos el numero a la derecha, ya que nos interesa tener los 5 BITS más significativos
		BCF		STATUS,C ; Ponemos a 0 el BIT de acarreo
		RRF		N,1 ; Desplazamos el numero a la derecha, ya que nos interesa tener los 5 BITS más significativos
		BCF		STATUS,C ; Ponemos a 0 el BIT de acarreo
		RRF		N,1 ; Desplazamos el numero a la derecha, ya que nos interesa tener los 5 BITS más significativos
					; Si inicialmente en PORTB habíamos metido un "10110001" al final nos quedaría un "00010110" que es lo que nos interesa.

RETURN  ;Salimos de la subrutina

comprueba_N

		CALL 	ActualizaN ; Actualiza N

RETFIE

Cambio_PT

		MOVWF	PORTC ; Mueve WREG al PORTC
		DECFSZ	PT ; Decrementa PT

RETURN

END

; Hecho por Los Telematicos