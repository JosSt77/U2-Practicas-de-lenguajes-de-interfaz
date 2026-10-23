; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 11. Operaciones lógicas
; Descripción: Programa que demuestra el uso de las instrucciones lógicas AND, OR, XOR y TEST 
; para la manipulación y evaluación de bits.
INCLUDE Irvine32.inc 

.data 
    ;se designan los mensajes para cuando se encieda o apague la alarma
    msgEncendida BYTE "alarma encendida", 0
    msgApagada   BYTE "alarma apagada", 0 

.code 
main PROC

    ; Estados de computadora:
    ; Bit 0 - Computadora encendida (0 Apagado, 1 Encendido)
    ; Bit 1 - Alarma encendida
    ; Bit 2 - Computadora conectada a internet

    ; 1 - Operación AND: Evaluación de estado de alarma
    mov eax, 0 ; Limpia el registro
    mov al, 00000111b ; Carga un estado de prueba en AL
    and al, 00000010b ; AND lógico con máscara para aislar el bit 1
    
    call WriteBin ; Muestra el resultado binario en consola
    call Crlf ; salto de línea
    nop ; Comando de detención sin realizar cambios para inspección

    ; 2 - Operación OR: Encender alarma
    mov eax, 0 ; Limpia el registro
    mov al, 00000101b ; Carga el estado inicial (Alarma apagada)
    or al, 00000010b ; OR lógico con máscara para forzar el encendido del bit 1
    
    call WriteBin ; Muestra el resultado binario
    call Crlf 
    nop 

    ; 3 - Operación XOR: Apaguen y enciendan la computadora
    ; XOR invierte los bits donde la máscara tiene 1
    mov eax, 0 ; Limpia el registro
    mov al, 00000101b ; Carga el estado inicial, PC encendida: bit 0 es 1
    
    xor al, 00000001b ; XOR lógico, invierte el bit 0 (Apaga la computadora)
    call WriteBin ; Muestra el nuevo estado
    call Crlf
    
    xor al, 00000001b ; XOR lógico: Invierte el bit 0 nuevamente
    call WriteBin ; Muestra el estado restaurado
    call Crlf
    nop 

    ; 4 - Operación TEST: Evaluar la alarma encendida y apagada
    ; TEST realiza un AND lógico solo para actualizar EFLAGS
    mov al, 00000101b ; Carga el estado inicial
    test al, 00000010b ; Consulta el bit 1 usando una máscara
    
    jnz alarma_encendida ; Si el resultado de TEST no es cero, el bit 1 está encendido y salta
    
    ; Bloque a ejecutar si la alarma está apagada
    mov edx, OFFSET msgApagada ; Carga en EDX la dirección de la cadena 'msgApagada'
    call WriteString ; Imprime en consola el mensaje
    call Crlf 
    jmp fin ; Salto incondicional a la etiqueta 'fin'

alarma_encendida: ; Se ejecuta si la alarma está encendida
    mov edx, OFFSET msgEncendida ; mensaje de alarma encendida
    call WriteString 
    call Crlf 

fin:
    exit 

main ENDP 

END main 