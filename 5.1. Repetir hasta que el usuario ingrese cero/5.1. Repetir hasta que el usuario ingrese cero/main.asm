; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5.1. Repetir hasta que el usuario ingrese cero.
; Descripción: Se solicita al usario que ingrese cero para terminar el programa, en caso
;contrario la petición se repetirá utilizando un ciclo do-while.
INCLUDE Irvine32.inc
.data
    msgIngresar  BYTE "Ingrese un numero (en caso de querer terminar el programa ingresar 0): ", 0
    msgFinal   BYTE "El programa ha finalizado al ingresar 0", 0
.code
main PROC

ciclo:

    mov edx, OFFSET msgIngresar; mostrar mensaje de ingreso de datos
    call WriteString 
    call ReadInt; leer un numero entero desde la consola
    mov ebx, eax

    cmp ebx, 0; comparar si el numero ingresado es 0
    je terminar; saltar al final si el numero ingresado es 0

    call WriteInt; Imprimir el número ingresado si no es 0
    call Crlf; Salto de linea

    jne ciclo; saltar al inicio del ciclo si el numero ingresado no es 0

terminar:
    mov edx, OFFSET msgFinal; mostrar un mensaje de finalizacion del programa
    call WriteString


    exit
main ENDP

END main