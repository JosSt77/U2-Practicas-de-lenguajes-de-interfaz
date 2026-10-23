; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 7. Validación de formato de cadena
; Descripción: Se solicita una cadena com el siguiente formato: 3 letras, un guion y 3 dígitos.
; Se repite mediante un ciclo condicional que termina hasta que se ingresa una cadena válida.

INCLUDE Irvine32.inc

.data
    msgInicio BYTE "Ingrese una cadena: ", 0
    msgLongitud BYTE "La longitud de la cadena no es de 7 caracteres.", 0
    msgLetras BYTE "La cadena no cumple con la cantidad de 3 letras mayusculas al inicio.", 0
    msgSeparador BYTE "La cadena no cumple con el formato de un separador en la posicion 4.", 0
    msgDigitos BYTE "La cadena no cumple con la cantidad de 3 digitos al final.", 0
    msgCadenaValida BYTE "La cadena cumple con el formato deseado.", 0

    buffer BYTE 20 DUP(0) ; Espacio de memoria reservado para la entrada

.code
main PROC

solicitarCadena: ;inicia el ciclo para la solicitud de la cadena
    call Crlf ; Salto de linea por estética en cada intento
    
    mov edx, OFFSET msgInicio ;se muestra el mensaje de inicio
    call WriteString

    mov edx, OFFSET buffer ; EDX apunta a la direccion del buffer
    mov ecx, SIZEOF buffer ; ECX establece el limite maximo de lectura
    call ReadString ; Lee la entrada y retorna la cantidad de caracteres en EAX

    cmp eax, 7 ; primero compara la cantidad de caracteres leidos contra 7
    jne longitudInvalida ; Salta si la longitud no es igual a 7

    mov esi, 0 ; Indice inicial en la posicion 0
    mov ecx, 3 ; Contador para repetir 3 veces por las posiciones 0, 1 y 2

    corroborarLetras: ;ciclo para corroborar que los primeros 3 caracteres sean letras mayusculas
        mov al, buffer[esi] ; Lee el caracter actual
        cmp al, 'A' ; Verifica limite inferior A
        jb letrasInvalidas ; Salta si es menor que A
        cmp al, 'Z' ; Verifica limite superior Z
        ja letrasInvalidas ; Salta si es mayor que Z

        inc esi ; Avanza al siguiente caracter
        loop corroborarLetras ; Decrementa ECX

    mov al, buffer[3] ;comienza la validación del separador en la posicion 4
    cmp al, '-' ; Verifica si el caracter es un guion
    jne separadorInvalido ;en caso contrario salta a la etiqueta de error

    ;finalmente se valida que los ultimos 3 caracteres sean digitos
    mov esi, 4 ; El indice para los digitos empieza en la posicion 4
    mov ecx, 3 ; Contador para repetir 3 veces (posiciones 4, 5 y 6)

    cicloDigitos:
        mov al, buffer[esi] ; Lee el caracter actual
        cmp al, '0' ; Verifica limite inferior 0
        jb digitosInvalidos ; Salta si es menor que 0
        cmp al, '9' ; Verifica limite superior 9
        ja digitosInvalidos ; Salta si es mayor que 9

        inc esi ; Avanza al siguiente caracter
        loop cicloDigitos ; Decrementa ECX

    mov edx, OFFSET msgCadenaValida ; Mensaje de éxito si pasa todas las comprobaciones
    call WriteString
    call Crlf
    jmp fin ; Termina el programa al haber ingresado una cadena valida

;ZONAS DE LOS MENSAJES DE ERROR
longitudInvalida:
    mov edx, OFFSET msgLongitud ;muestra el mensaje de longitud erronea
    call WriteString
    call Crlf
    jmp solicitarCadena ; Regresa al inicio para volver a pedir la cadena

letrasInvalidas:
    mov edx, OFFSET msgLetras ;muestra el mensaje de letras inválidas
    call WriteString
    call Crlf
    jmp solicitarCadena ; Regresa al inicio para volver a pedir la cadena

separadorInvalido:
    mov edx, OFFSET msgSeparador ;muestra el mensaje de no uso de separador
    call WriteString
    call Crlf
    jmp solicitarCadena ; Regresa al inicio para volver a pedir la cadena

digitosInvalidos:
    mov edx, OFFSET msgDigitos ;muestra el mensaje de dígitos inválidos
    call WriteString
    call Crlf
    jmp solicitarCadena ; Regresa al inicio para volver a pedir la cadena

fin: ;etiqueta para el fin del programa
    exit
main ENDP
END main