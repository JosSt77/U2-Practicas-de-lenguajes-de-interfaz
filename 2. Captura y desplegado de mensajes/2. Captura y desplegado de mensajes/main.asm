; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: PRACTICA 2. CAPTURA Y DESPLEGADO DE MENSAJE
; Descripción: Captura el nombre del usuario, lo almacena en un buffer, despliega el texto ingresado
; y muestra la cantidad total de caracteres leídos.
INCLUDE Irvine32.inc
.data
mensaje BYTE "Escribe tu nombre: ", 0 ; Mensaje de instrucción para el usuario
nombre BYTE 30 DUP(0) ;reservamos un espacio de memoria llamado buffer para establecer el límite de caracteres
caracteresEscritos BYTE "Caracteres escritos: ", 0 ;Cadena de texto explicativa con terminador nulo

.code
main PROC

;Despliega la solicitud de nombre al usuario
 mov edx, OFFSET mensaje
 call WriteString

 mov edx, OFFSET nombre ;entrega la dirección del primer caracter del buffer  
 mov ecx, SIZEOF nombre ; Entrega la cantidad de bytes que se pueden escribir

 call ReadString ; Permite el ingreso de datos mediante consola (lee lo escrito por el usuario 

 ; Retorna lo escrito en el buffer
 mov edx, OFFSET nombre ; Carga de nuevo la dirección del buffer 'nombre' en EDX
 call WriteString ; Imprime el nombre ingresado por el usuario
 call Crlf ; Realiza un salto de línea en la consola (Carriage Return y Line Feed)
 
; Despliega el total de caracteres leídos
 mov edx, OFFSET caracteresEscritos ; Carga la dirección del mensaje 'caracteresEscritos'
 call WriteString
 call WriteDec ; Imprime en formato decimal sin signo el valor almacenado en EAX

 exit


main ENDP


END main