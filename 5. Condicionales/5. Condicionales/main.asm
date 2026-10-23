INCLUDE Irvine32.inc
.data
    ;SE ESTABLECEN DOS MENSAJES PARA INDICAR EL INICIO DE CADA CICLO
    msgWhile BYTE "Ciclo While", 0 
    msgDoWhile BYTE "Ciclo Do While", 0
.code
main PROC

    mov edx, OFFSET msgWhile ;MUESTRA EL MENSAJE DE INICIO DEL CICLO WHILE
    call WriteString
    call Crlf

    mov ebx, 1 ; VALOR INICIAL DE LA CONDICIÓN

cicloWhile:
    cmp ebx, 100 ; COMPARA PARA EJECUTAR LA CONDICIÓN DE SALIDA.

    jg finWhile ; SALTA A LA ETIQUETA FIN PARA TERMINAR EL PROGRAMA SIEMPRE Y CUANDO SE CUMPLA
    
    mov eax, ebx
    call WriteDec ; DESPLIEGA EN CONSOLA EL VALOR QUE ESTA ALMACENADO EN EAX.
    call Crlf ; SALTO DE LINEA

    inc ebx ; INCREMENTO DE +1 EN EL REGISTRO EBX
    jmp cicloWhile ; REGRESA AL CICLO WHILE.
finWhile:
    call Crlf ; SE AÑADE UN SALTO DE LÍNEA EN VEZ DE TERMINAR EL PROGRAMA

    mov edx, OFFSET msgDoWhile ; SE MUESTRA EL MENSAJE DE INICIO DEL CICLO DO WHILE
    call WriteString
    call Crlf

    mov ebx, 1 ; REINICIO DEL CONTADOR A SU VALOR INICIAL

cicloDoWhile:

    mov eax, ebx
    call WriteDec ;DESPLIEGA EL VALOR QUE ESTA ALMACENADO EN EAX.
    call Crlf

    inc ebx ; INCREMENTO DE +1 EN EL REGISTRO EBX
    cmp ebx, 100 ; COMPARA LA CONDICIÓN AL FINAL DE BLOQUE

    jle cicloDoWhile ; SALTA AL CICLO DO WHILE MIENTRAS EBX SEA MENOR O IGUAL A 100

    exit
main ENDP

END main