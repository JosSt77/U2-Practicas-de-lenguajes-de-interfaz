; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 1. Ciclos numéricos
; Descripción: Imprime una secuencia de números del 5 al 1 utilizando la instrucción loop

INCLUDE Irvine32.inc

.data
.code
main PROC
    mov ecx, 5 ; Inicializar el contador en ECX para su uso en la funcion loop
    
ciclo:
    mov eax, ecx ; copiamos el valor de ECX (contador) en el registro EAX
    
    call WriteDec ; Imprime el valor almacenado en EAX
    call Crlf ; Salto de linea
    loop ciclo ; Realiza el decremento de ECX y repite el ciclo.
    
    exit
main ENDP

END main