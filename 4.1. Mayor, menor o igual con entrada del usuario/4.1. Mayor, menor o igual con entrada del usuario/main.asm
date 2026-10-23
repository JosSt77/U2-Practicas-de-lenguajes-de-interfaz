; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4.1. Mayor, menor o igual con entrada del usuario.
; Descripción: Lee dos valores tecleados por el usuario, los compara mediante cmp y utiliza saltos
; condicionales como JG y JL para mostrar el resultado de quien es mayor o menor o si son iguales.

INCLUDE Irvine32.inc

.data
;Mensajes para pedir la entrada de datos
msgIngresar1 BYTE "Ingresa el primer valor: ", 0
msgIngresar2 BYTE "Ingresa el segundo valor: ", 0
;Mensajes para mostrar el resultado de la comparación
msgMayor   BYTE "El primer numero es mayor.", 0
msgMenor   BYTE "El primer numero es menor.", 0
msgIguales BYTE "Los numeros son iguales.", 0

.code
main PROC

    mov edx, OFFSET msgIngresar1 ;Se despliega el mensaje para ingresar el primer valor
    call WriteString 
    call ReadInt ;ReadInt lee un valor entero y lo almacena en EAX
    mov ecx, eax ;Se guarda el valor en ecx porque se volverá a usar ReadInt y se sobreescribirá el valor en EAX

    mov edx, OFFSET msgIngresar2 ;Se despliega el mensaje para ingresar el segundo valor
    call WriteString 
    call ReadInt ;se lee el segundo valor entero en EAX
    mov ebx, eax ;se guarda el valor en ebx para generar la comparación
    
    mov eax, ecx ;se coloca el valor del primer número en eax para realizar la comparación

    cmp eax, ebx; resta los valores de EAX y EBX 

    jg mayor; Salta a la etiqueta EAX > EBX 

    jl menor; Salta a la etiqueta  si EAX < EBX 

    ;en caso de que la comparación de mayor o menor no se cumpla, se va directamente al mensaje de iguales
    mov edx, OFFSET msgIguales
    call WriteString
    jmp fin ;salta a la etiqueta fin para terminar el programa

    mayor:
        mov edx, OFFSET msgMayor ;muestra el mensaje de que el primer número es mayor
        call WriteString 
        jmp fin
    
    menor:
        mov edx, OFFSET msgMenor ; muestra el mensaje de que el primer número es menor
        call WriteString 

    fin: 
        call Crlf
        exit

main ENDP
END main