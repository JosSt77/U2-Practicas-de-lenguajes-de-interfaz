; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 14. Captura y almacenamiento de datos numéricos.
; Descripción: Captura con ReadString la cantidad de tarjetas ESP32 recibidas (uno o dos dígitos, de 1 a 99), valida
;			que cada carácter sea un dígito, convierte la cadena a número con la fórmula acumulado x 10 + dígito y la guarda
;			en cantidadRecibida. Después la suma a la existencia inicial de 25 unidades, guarda el resultado en
;			existenciaActual y lo muestra con WriteString. Ante una entrada inválida solicita la cantidad de nuevo.
INCLUDE Irvine32.inc

.data
;Se establecen los mensajes que se mostrarán a lo largo del código
msgIngresoDatos BYTE "Ingrese las unidades recibidas: ", 0
msgCadenaInvalida BYTE "El programa solo acepta cadenas entre 1 y 99.", 0dh, 0ah, 0
msgResultado BYTE "Unidades Actuales: ", 0

;Buffer donde ReadString guarda la entrada como texto
bufferInput BYTE 10 DUP(0)

;Variables numéricas del programa
cantidadRecibida DWORD ?
existenciaInicial DWORD 25
existenciaActual DWORD ?

;Buffer para la cadena decimal que se mostrará como resultado
bufferOutput BYTE 12 DUP(0)

.code
main PROC

IngresarDatos:
	mov edx, OFFSET msgIngresoDatos ; Muestra el mensaje que solicita la cantidad
	call WriteString

	mov edx, OFFSET bufferInput ; EDX recibe la dirección del buffer donde se guardará la entrada
	mov ecx, 9
	call ReadString 

	cmp eax, 0 ; Se compara con 0
	je MostrarError ;si es 0, salta a la etiqueta del error

	cmp eax, 2 ; se compara con 2
	ja MostrarError ; si es mayor salta a mostrar error

	mov ecx, eax ; Se establece el contador
	mov esi, 0 ; Se establece el indice
	mov ebx, 0 ; Se establece el acumulador

ConvertirCadena: ;Se valida y convierte cada carácter, de izquierda a derecha
	mov al, bufferInput[esi] ; Copia a AL el carácter de la posición actual
	cmp al, '0' ; Si el carácter es menor que 0 se rechaza la entrada
	jb MostrarError
	cmp al, '9' ; Si el carácter es mayor que 9 se rechaza la entrada
	ja MostrarError

	sub al, '0' ; Convierte el carácter ASCII en su valor numérico de 0 a 9 quitandole un 0

	imul ebx, ebx, 10 ; Multiplica el acumulado por diez para abrir una posición decimal
	add bl, al ; Suma el dígito al acumulado

	inc esi ; Avanza a la siguiente posición del buffer

	loop ConvertirCadena ; Se repite el ciclo hasta revisar todos los caracteres

	cmp ebx, 1 ; Se valida que el número esté en el rango de 1
	jb MostrarError
	cmp ebx, 99 ; Se valida que el número esté en el rango de 99
	ja MostrarError

	mov cantidadRecibida, ebx ; Guarda la cantidad validada en la variable DWORD
	mov eax, cantidadRecibida
	add eax, existenciaInicial ; Suma la cantidad recibida a la existencia inicial de 25
	mov existenciaActual, eax ; Guarda el resultado en existenciaActual

	mov edx, OFFSET msgResultado ; Se muestra el mensaje del resultado
	call WriteString

	mov eax, existenciaActual ; EAX recibe el número a convertir
	mov edi, OFFSET bufferOutput ; EDI recibe la dirección del buffer destino
	call ConvertirDecimalToString ; Construye la cadena decimal en el buffer

	mov edx, OFFSET bufferOutput ; Se carga la direeción de la cadena convertirda
	call WriteString ; Muestra la existencia actual
	call Crlf

	exit

MostrarError: ;Función cuando marque error
	mov edx, OFFSET msgCadenaInvalida ; muestra mensaje de cadena invalida
	call WriteString
	jmp IngresarDatos ;salta a ingresar datos

main ENDP


ConvertirDecimalToString PROC ;Se crea el proceso para convertir de decimal a string
	;Se meten en la pila los valores
	push eax
	push ebx
	push ecx
	push edx

	mov ecx, 0 ; Contador
	mov ebx, 10 ; Divisor

ExtraerDigitos:
	mov edx, 0 ; Limpiar registro
	div ebx ; 
	add dl, '0' ; Convertir residuo a ASCII

	push dx ; Guardar dígito en la pila

	inc ecx ; Incrementar contador

	cmp eax, 0 ; comparar si quedan más digitos
	jne ExtraerDigitos ;salta al inicio de esta función

GuardarEnBuffer:
	pop dx ; Sacar de la pila en orden LIFO
	mov [edi], dl ; Escribir al buffer
	inc edi
	loop GuardarEnBuffer

	mov byte ptr [edi], 0 ; Colocar carácter nulo al final

	;Se saca de la pila
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret ;se retorna al main
ConvertirDecimalToString ENDP

END main