; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 15. Manipulación de archivos
; Descripción: Se crea un archivo de texto llamado "Inventario.txt" y se escribe dentro de él
; la cadena "125", luego se cierra el archivo de forma segura. Se valida cada paso para mostrar
; mensajes de exito o error.
INCLUDE Irvine32.inc

.data 

nombreArchivo BYTE "Inventario.txt", 0 ; Nombre del archivo a crear
texto BYTE "125", 0 ; Cadena de texto a escribir en el archivo
archivoHandle DWORD ? ; Variable para almacenar el identificador del archivo

; Mensajes que se mostrarán a lo largo del programa
mensajeExito BYTE "Archivo guardado correctamente",0
mensajeError BYTE "No se pudo guardar el archivo", 0

.code
main PROC

; 1. Crear archivo txt.
mov edx, OFFSET nombreArchivo ; EDX recibe la dirección del nombre del archivo
call CreateOutputFile ; Se crea un archivo y se devuelve el identificador a eax

cmp eax, INVALID_HANDLE_VALUE ; Se compara si el identificador devuelto es inválido
je error ; Si hay error en la creación salta a la etiqueta de error

mov archivoHandle, eax ; Se guarda el identificador válido en la variable

; 2. Escribir caracteres en archivo txt
mov eax, archivoHandle ; EAX recibe el identificador del archivo abierto
mov edx, OFFSET texto ; EDX recibe la dirección de la cadena a escribir
mov ecx, SIZEOF texto-1 ; ECX recibe la cantidad de bytes a escribir excluyendo el 0 nulo
call WriteToFile ; Escribe en el archivo y devuelve los bytes escritos en EAX

jc errorEscritura ; Si se activa la bandera de acarreo, salta a 'errorEscritura'

cmp eax, SIZEOF texto-1 ; Se compara si los bytes escritos son iguales a los esperados
jne errorEscritura ; Si no coinciden, salta a la etiqueta de errores de escritura

; 3. Cerrar archivo txt
mov eax, archivoHandle ; EAX recibe el identificador del archivo a cerrar
call CloseFile ; Se cierra el archivo y libera los recursos

test eax, eax ; Se realiza una prueba lógica para verificar si el cierre falló

jz error ; Si el resultado es cero, salta a la etiqueta error

mov edx, OFFSET mensajeExito ; Se muestra el mensaje de exito
call WriteString
jmp fin ; Salta al final ya que se haya realizo el proceso exitosamente

errorEscritura: ; Función cuando falla la escritura
	mov eax, archivoHandle ; Recupera el identificador del archivo
	call CloseFile ; Ciera el archivo para no bloquear la memoria

error: ; Función que muestra mensaje de error
	mov edx, OFFSET mensajeError ; Se muestra el mensaje de error
	call WriteString

fin:
	exit
main ENDP

END main