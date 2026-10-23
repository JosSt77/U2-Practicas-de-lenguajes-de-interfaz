; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 13. Obtención de una cadena hexadecimal
; Descripción: Convierte el valor numérico en una cadena de texto con su representación hexadecimal. Se extrae cada nibble 
;			con la máscara 0Fh, se convierte a su código ASCII, se guarda en un buffer de nueve bytes de derecha a izquierda 
;			y se desplaza el valor cuatro bits para obtener el siguiente dígito.
INCLUDE Irvine32.inc
.data
;Se establecen los mensajes que se mostrarán a lo largo del código
msgHexadecimal BYTE "Numero hexadecimal: 12AB34CD", 0
msgResultado   BYTE "Cadena obtenida: ", 0 

;se establece un buffer de 9 bytes por el terminador nulo
bufferHex BYTE 9 DUP(0)

.code 
main PROC 

	mov edx, OFFSET msgHexadecimal ; Muestra el número hexadecimal a convertir
	call WriteString
	call Crlf ; Salto de línea

	mov eax, 12AB34CDh ; Carga el valor numérico a convertir 
	mov esi, 7 ; ESI apunta a la posición 7 del buffer en donde se escribe el último dígito
	mov ecx, 8 ; Se establece el contador que repetirá el proceso con los 8 dígitos


convertir: ;se esteblece la función con la cual se extraerá y convertirá cada dígito
	mov dl, al ; Copia el byte inferior de EAX en DL para trabajar con él
	and dl, 0Fh ; Con el uso de la 0Fh se conserva el nibble inferior

	cmp dl, 9 ;Se compara el nibble con 9 para saber si es dígito o letra 
	jbe esNumero ;Si es número, salta a convertirse a un dígito de 0 a 9

	sub dl, 10 ; Se resta 10 para saber si la posición está dentro de 10 a 15
	add dl, 'A' ; Se suma el código de A para obtener el carácter A-F
	jmp guardarDigito ; Salta para almacenar el carácter obtenido

esNumero:
	add dl, '0'; cuando el valor está entre 0 a 9, se suma 0 para obtener el código ascii

guardarDigito:
	mov bufferHex[esi], dl; Almacena el carácter ASCII en la posición actual del buffer
	shr eax, 4; Desplaza EAX cuatro bits a la derecha para colocar el siguiente nibble
	dec esi ; Decrementa la posición para retroceder dentro de la escritura de 7 a 0
	loop convertir ; Se genera el ciclo para convetir los 8 dígitos

	mov edx, OFFSET msgResultado ; Se muestra el mensaje del resultado
	call WriteString
	mov edx, OFFSET bufferHex ; Carga la dirección en donde se almacena la cadena convertida
	call WriteString ; Muestra la cadena
	call Crlf 

	exit

main ENDP

END main
