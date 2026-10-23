; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 4. Saltos
; Descripción: Compara dos números mediante CMP y utiliza los saltos JE y JNE
; para determinar si los números son iguales o diferentes.

INCLUDE Irvine32.inc
.data
;Mensajes para indicar si los números son iguales o diferentes
msgIguales Byte "Los numeros son iguales", 0 
msgDiferentes Byte "Los numeros son diferentes", 0

.code
main PROC

	;se almacenan dos números en los registros EAX y EBX para compararlos
	mov eax, 10
	mov ebx, 10

	cmp eax, ebx; Se realiza la resta entre EAX - EBX
	
	je iguales ;si son iguales salta a la etiqueta "iguales"

	mov edx, OFFSET msgDiferentes ;en caso de ser diferentes se muestra el mensaje correspondiente
	call WriteString

	jmp fin ;Salta a la etiqueta fin con un salto incondicional

	iguales: ;inicio de la etiqueta "iguales"
		mov edx, OFFSET msgIguales ;muestra el mensaje correspondiente en caso de ser iguales
		call WriteString
	
	fin:
		call Crlf ;salto de línea
 exit
main ENDP
END main