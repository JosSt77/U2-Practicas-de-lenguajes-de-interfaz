; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 10. Obtención de una cadena decimal
; Descripción: Un archivo tiene un tamaño de 100000 bytes. Se han recibido 125 bloques de 512 bytes. Desarrolla un programa en MASM 
;			x86 de 32 bits que calcule y muestre su avance. Calcula
;              Bytes descargados y pendientes.
;              Porcentaje entero de avance.
;              Grupos completos de 1024 bytes y residuo del agrupamiento.
;           Implementa
;           Realiza los cálculos en main y guarda los resultados en variables DWORD. Crea un procedimiento convertirDecimal que reciba 
;			el número en EAX y la dirección del buffer en ESI. Utiliza DIV, residuos, PUSH/POP y ASCII; reserva 11 bytes y agrega 00h. 
;			Muestra cada resultado con WriteString, sin usar WriteDec.

INCLUDE Irvine32.inc

.data
	;Mensajes que se mostrarán a lo largo de la ejecución
	msgInicio BYTE "Avance de la descarga:", 0 
	msgBytesDescargados BYTE "Bytes descargados: ", 0 
	msgBytesPendientes BYTE "Bytes pendientes: ", 0
	msgPorcentaje BYTE "Porcentaje de avance de la descarga: ", 0
	msgGruposCompletos BYTE "Grupos completos de 1024 bytes: ", 0 
	msgResiduo BYTE "Residuo de los agrupamientos: ", 0 

	;Variables DwORd que guardarán los resultados
	bytesDescargados DWORD ? 
	bytesPendientes DWORD ?
	porcentajeDescarga DWORD ? 
	gruposCompletos DWORD ? 
	residuo DWORD ? 

	bufferConversion BYTE 11 DUP(0) ; Reserva un espacio de memoria de 11 bytes inicializados en 0

.code
main PROC

	; Se realiza el calculo de Bytes descargados
	mov eax, 125 ; Bloques recibidos en eax
	mov ebx, 512 ; Tamaño de cada bloque en eax
	mul ebx ; Multiplica eax por ebx
	mov bytesDescargados, eax ; como el resultado de la multiplicación queda en eax, se mueve para que quede
							  ; almacenado en la variable bytesDescargado

	; Se realiza el calculo de Bytes pendientes
	mov ebx, eax ; Copia los bytes descargados a ebx
	mov eax, 100000 ; eax toma el tamaño total de archivos
	sub eax, ebx ; Se realiza una resta de los bytes descargados al total: eax-ebx
	mov bytesPendientes, eax ; el resultado se almacena en eax, se mueve para que quede almacenado en bytesPedientes

	; Se calcula el porcenajte de avance 
	mov eax, bytesDescargados ; Carga los bytes descargados en eax
	mov ebx, 100 ; ebx toma el valor del multiplicador
	mul ebx      ; se multiplica eax por ebx
	mov ebx, 100000 ; Se carga el tamaño total del archivo en ebx para usarlo como divisor
	div ebx      ; Se divide edx:eax entre ebx
	mov porcentajeDescarga, eax ; Como el cociente queda en eax, este se mueve a porcentajeDescarga

	; Se calculan los grupos completos de 1024 bytes y su residuo
	mov eax, bytesDescargados ; Carga los bytes descargados en eax
	mov edx, 0   ; Limpia edx 
	mov ebx, 1024 ; Carga el tamaño del grupo en ebx
	div ebx      ; Divide edx:eax entre ebx.
	mov gruposCompletos, eax ; Almacena la cantidad de grupos completos en la variable
	mov residuo, edx ; Almacena los bytes sobrantes en la variable residuo

	;Una vez se hizo el proceso, se procede a mostrar los valores por consola
	mov edx, OFFSET msgInicio ; Imprime el mensaje de inicio
	call WriteString ; 
	call Crlf ; Realiza un salto de línea
	call Crlf ; 

	mov edx, OFFSET msgBytesDescargados ; Muestra el mensaje de bytes descargados
	call WriteString 
	mov eax, bytesDescargados ; Carga el valor a convertir en eax
	mov esi, OFFSET bufferConversion ; Pasa la dirección del buffer al índice esi
	call convertirDecimal ; se llama a la subrutina para realizar el proceso de convertir un valor a texti ASCII
	mov edx, OFFSET bufferConversion ; Carga la dirección del buffer
	call WriteString ; Imprime la cadena numérica
	call Crlf

	mov edx, OFFSET msgBytesPendientes ; Mensaje de bytes pendientes
	call WriteString 
	mov eax, bytesPendientes ; Carga el valor a convertir en eax
	mov esi, OFFSET bufferConversion ; Pasa la dirección del buffer
	call convertirDecimal ; Convierte el valor a texto
	mov edx, OFFSET bufferConversion ; Carga la cadena procesada
	call WriteString
	call Crlf 

	mov edx, OFFSET msgPorcentaje ; mensaje del porcentaje
	call WriteString
	mov eax, porcentajeDescarga ; Carga el porcentaje calculado
	mov esi, OFFSET bufferConversion ; buffer
	call convertirDecimal ; Convierte el valor a texto
	mov edx, OFFSET bufferConversion ; cadena procesada
	call WriteString ; se imprime
	call Crlf

	; Mostrar Grupos Completos
	mov edx, OFFSET msgGruposCompletos ;mensaje de grupos completos
	call WriteString ; Imprime el mensaje
	mov eax, gruposCompletos ; Carga los grupos obtenidos
	mov esi, OFFSET bufferConversion ; buffer
	call convertirDecimal ; valor a texto
	mov edx, OFFSET bufferConversion 
	call WriteString 
	call Crlf

	; Mostrar Residuo
	mov edx, OFFSET msgResiduo ; Mensaje del residuo
	call WriteString ; Imprime el mensaje
	mov eax, residuo ; Carga el residuo de los grupos
	mov esi, OFFSET bufferConversion ; Pasa la dirección del buffer
	call convertirDecimal ; Convierte el valor a texto
	mov edx, OFFSET bufferConversion ; Carga la cadena procesada
	call WriteString
	call Crlf 

	exit
main ENDP

convertirDecimal PROC ;este procedimiento toma un número de eax y lo convierne a una cadena de caracteres ASCII
					  ;almacenando el resultado en la dirección apuntada por esi

	;se guardan los valores en la pila para no perderlos
	push eax
	push ebx 
	push ecx 
	push edx
	push esi 

	mov ecx, 0 ; Inicializa el contador de dígitos en 0

extraer_digitos:
	mov edx, 0 ; Limpia edx
	mov ebx, 10 ; Establece el divisor en 10 para extraer el último dígito
	div ebx ; Divide edx:eax entre 10. Cociente en eax, residuo en edx
	push edx ; Apila el residuo obtenido
	inc ecx ; Incrementa el contador 
	cmp eax, 0 ; Verifica si el cociente ya es 0
	jne extraer_digitos ; Si no es 0, salta para extraer el siguiente dígito

construir_cadena:
	pop edx ; Desapila el dígito por el orden LIFO
	add dl, '0' ; Convierte el dígito numérico a su equivalente en carácter ASCII sumando '0'
	mov [esi], dl ; Almacena el carácter en la posición actual de memoria del buffer
	inc esi ; Avanza el puntero del buffer a la siguiente posición
	loop construir_cadena ; Decrementa ecx y repite el proceso hasta que ecx sea 0

	mov dl, 0 ; Carga el byte nulo en el registro de 8 bits dl
	mov [esi], dl ; Agrega el terminador nulo al final de la cadena en el buffer

	;Restaura los valores originales desde la pila
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret ;Retorna al flujo principal
convertirDecimal ENDP

END main