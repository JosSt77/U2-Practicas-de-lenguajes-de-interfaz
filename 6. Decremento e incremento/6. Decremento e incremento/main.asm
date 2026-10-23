; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6. Decremento e incremento
; Descripción: Programa que solicita al usuario un PIN de acceso permitiendo un máximo de 3 intentos. 
;se hace uso de comparaciones y condicionales para permitir el acceso o bloquear el sistema.
INCLUDE Irvine32.inc
.data
	;se declaran los distinos mensajes que se utilizarán a lo largo del programa
	msgPIN BYTE "Ingrese el PIN: ", 0
	msgIntentos BYTE "Intentos restantes: ", 0
	msgError BYTE "PIN incorrecto.", 0
	msgAcceso BYTE "Acceso permitido", 0
	msgBloqueado BYTE "Autodestruccion comenzada...", 0

	pinCorrecto = 1234 ;se establece el pin correcto

.code
	main PROC
	mov ebx, 3 ; NUMERO DE INTENTOS PARA INGRESAR

intentar: ;se inicia el ciclo
	;se lee el PIN
	mov edx, OFFSET msgPIN
	call WriteString
	call ReadInt

	cmp eax, pinCorrecto ;cse compara el valor en eax con el pin
	je acceso ; si son iguales, salta a la etiqueta de acceso

	mov edx, OFFSET msgError ;en caso contrario, muestra el mesnaje de pin incorrecto
	call WriteString
	call Crlf

	dec ebx ;como el pin fue incorrecto, se decrementa el contador de intentos

	jz bloqueado ;en caso de que el contador llegue a 0, se bloqueará el programa

	mov edx, OFFSET msgIntentos ;muestra el mensaje de intentos restantes
	call WriteString

	mov eax, ebx
	call WriteDec ;muesra el número de intentos restantes
	call Crlf

	jmp intentar ;salta de nuevo al ciclo para que el usuario pueda ingresar el pin nuevamente

acceso: ;bloque de código que se ejecuta si el pin es correcto
	mov edx, OFFSET msgAcceso ;muestra el mensaje de acceso permitido
	call WriteString
	call crlf ;salto de línea
	jmp fin ;salta a la etiqueta fin para terminar el programa

bloqueado:
	mov edx, OFFSET msgBloqueado ;muestra el mensaje de acceso bloqueado
	call WriteString
	call Crlf ;salto de línea
	jmp fin ;salta a la etiqueta fin para terminar el programa

fin: ;bloque de código que se ejecuta al final del programa
	exit
main ENDP

END main