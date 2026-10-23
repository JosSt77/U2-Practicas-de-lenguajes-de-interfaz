; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 9. PUSH y POP
; Descripción: Demostración del funcionamiento de una pila mediante las instrucciones PUSH y POP, 
; en ellas se utiliza el principio LIFO, además se utilizan las subrutinas con CALL y RET.
INCLUDE Irvine32.inc

.code
main PROC

	;BLOQUE 1: PUSH Y POP
	mov eax, 20 ;carga el valor de 20 decimal en eax

	push eax ;guarda el valor de eax en la pila y por lo tanto ESP decrementa 4 bytes

	nop ;  Instrucción que hace que programa se detenga en este punto y realice cambios

	mov ebx, 0 ; Limpia el registro de EBX

	pop ebx ; Extrae el valor de la cima de la pila y lo guarda en EBX
			; con ello ebx incrementa 4 bytes

	nop

	;BLOQUE 2: ORDEN DE LIFO (LAST IN, FIRST OUT)
	mov eax, 10 ;ESP + 8
	push eax ; Apila el valor 10 (es el primer elemento ingresado)

	mov eax, 20 ;ESP + 4
	push eax ;Apila el valor 10 (es el segundo elemento ingresado)

	mov eax, 30 ; ESP 
	push eax ;si se ejecuta el código en esta instancia y si queremos recuperar los registros de valor 
			;10 y 20, tendriamos que restar 8 y 4 respectivamente para indicar el indice con el cual
			;se está trabajando (estamos trabajando con direcciones de 4 bytes

	nop

	pop eax ;Recupera el último valor apilado: 30
	pop ebx ;Recupera el valor previo: 20
	pop ecx ;Recupera el primer valor apilado: 10

	;BLOQUE: CONSERVAR REGISTROS
	;Se cargan valores en eax y ebx
	mov eax, 100 
	mov ebx, 200

	push eax ;Guarda el valor de 100 en la pila
	push ebx ;Guarda el valor de 200 en la pila

	mov eax, 999 ; Modifica el valor de eax y ebx
	mov ebx, 666

	pop ebx ;Restaura el valor original de ebx (200) desde la pila
	pop eax ;Restaura el valor original de eax (100) desde la pila

	;BLOQUE 4: CALL Y RET
	
	mov eax, 111 ; Se cargan valores iniciales en eax y ebx
	mov ebx, 222

	call aumentarDiez ; se guarda la dirección de retorno en la pila y salta a la función aumentarDiez

	nop

	exit

main ENDP ;Finalización del procedimiento main

aumentarDiez PROC ;Procedimiento que suma 10 al registro eax respaldandolo y restaurando el registro ebx
	push ebx ; se respalda el valor de ebx en la pila

	mov ebx, 10 ; se carga el valor de 10 en ebx

	add eax, ebx ; se suma el valor de ebx a eax: 111+10

	pop ebx ; se restaura el valor origianl de ebx(222) desde la pila

	ret ;recupera la dirección de retorno guardada en la pila y regresa al main
aumentarDiez ENDP
END main