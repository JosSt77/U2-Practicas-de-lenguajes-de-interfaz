; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6.1. Control de Estacionamiento
; Descripción: Ingresar un 1 si un carro entra, ingresar un 2 si un carro sale.
;Cuando entren 10 carros mandar un mensaje de que el estacionamiento está lleno y terminar un programa
INCLUDE Irvine32.inc

.data
    ;se establecen los mensajes que se mostrarán a lo largo de la ejecución del programa
    msgInicial BYTE "Ingrese 1 (entra) o 2 (sale): ", 0
    msgEntrada BYTE "Un vehiculo ha ingresado", 0
    msgSalida BYTE "Un vehiculo ha salido", 0
    msgFull BYTE "El estacionamiento esta lleno", 0
    msgInvalido BYTE "Opcion no valida. Intente de nuevo.", 0

    limiteEstacionamiento = 10 ;Constante que almacena la capacidad máxima del estacionamiento

.code
main PROC
    mov ebx, 0 ; Inicializamos el contador de vehículos en 0

FlujoEstacionamiento: ;Se crea el ciclo del flujo de estacionamiento
    call Crlf 
    mov edx, OFFSET msgInicial
    call WriteString
    call ReadInt ; Se lee la opción (1 o 2)

    cmp eax, 1 ; Comparamos si ingresó 1 (entra carro)
    je vehiculoEntra
    
    cmp eax, 2 ; Comparamos si ingresó 2 (sale carro)
    je vehiculoSale

    mov edx, OFFSET msgInvalido ;Se muestra un mensaje de opción invalida en caso de que no sea ni 1 ni 2
    call WriteString
    call Crlf

    jmp FlujoEstacionamiento ;Si no es 10 se vuelven a pedir los datos

vehiculoEntra:    
    inc ebx ; Se suma 1 al contador de carros
    mov edx, OFFSET msgEntrada ;Se muestra el mensaje de entrada de un carro
    call WriteString
    call Crlf
    
    cmp ebx, limiteEstacionamiento ; Se verifica si ya se alcanzó el límite del estacionamiento
    je estLleno ; Si es igual a 10, salta a estLleno y bloquea el incremento

    jmp FlujoEstacionamiento ; Vuelve a pedir datos

vehiculoSale:
    cmp ebx, 0 ; Se verifica que el contador de carros no esté en 0 antes de restar
    je FlujoEstacionamiento ; Si ya está en 0, se ignora y se vuelve a pedir datos

    dec ebx ; Se resta 1 al contador de carros
    mov edx, OFFSET msgSalida ;Se muestra el mensaje de salida de un carro
    call WriteString
    call Crlf
    
    jmp FlujoEstacionamiento ;Vuelve a pedir datos

estLleno: ;En caso de que el estacionamiento esté lleno
    call Crlf
    mov edx, OFFSET msgFull ;Muestra el mensaje de estacionamiento lleno
    call WriteString
    call Crlf
    jmp fin 

fin:
    exit
main ENDP

END main