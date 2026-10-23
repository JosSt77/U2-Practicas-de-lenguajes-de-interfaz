; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 12. Desplazamiento y rotación
; Descripción: Demostración de las instrucciones de desplazamiento SHL, SHR, SAR y rotación ROL, ROR, RCL, RCR,
;              incluyendo el uso de constantes y el registro CL para definir la cantidad de posiciones a mover.
INCLUDE Irvine32.inc

.code 
main PROC 
	mov eax, 0        ; Limpia el registro

	; 1 - SHL: DESPLAZAMIENTO DE UN BIT HACIA LA IZQUIERDA
	; Mueve los bits a la izquierda e inserta un 0. El último bit sale hacia CF.
	mov al, 00000110b ; Carga el valor binario en AL (6 decimal)
	shl al, 1         ; Desplaza los bits de AL una posición a la izquierda
	
	call DumpRegs     ; Muestra el estado de los registros y banderas en consola
	call WriteBin     ; Muestra el valor de AL en formato binario
	call Crlf         ; Salto de línea

	; 2 - SHR: DESPLAZAMIENTO DE UN BIT HACIA LA DERECHA
	; Mueve los bits a la derecha e inserta un 0. Se usa para valores sin signo.
	mov al, 00001100b ; Carga el valor binario en AL (12 decimal)
	shr al, 1         ; Desplaza los bits de AL una posición a la derecha
	
	call DumpRegs     ; Muestra el estado de los registros actualizados
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 3 - DESPLAZAMIENTO CON SIGNO (SAR)
	; Desplaza a la derecha replicando el bit de signo para conservarlo en operaciones en complemento a dos.
	mov al, -8        ; Carga el valor negativo -8 en AL
	sar al, 1         ; Desplaza a la derecha conservando el signo (divide -8 entre 2)
	
	call DumpRegs     ; Muestra el estado de los registros y banderas
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 4 - DESPLAZAMIENTO CON CONSTANTE
	; Indica mediante un valor inmediato cuántas posiciones desplazar.
	mov al, 00001100b ; Carga el valor binario en AL (12 decimal)
	shl al, 2         ; Desplaza AL dos posiciones a la izquierda

	call DumpRegs     ; Muestra el estado de los registros y banderas
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 5 - DESPLAZAMIENTO CON CL
	; El registro CL actúa como contador e indica la cantidad de posiciones a desplazar.
	mov al, 00010100b ; Carga el valor binario en AL (20 decimal)
	mov cl, 2         ; Carga la cantidad de desplazamientos deseada en CL
	shr al, cl        ; Desplaza AL a la derecha tantas posiciones como indique el registro CL

	call DumpRegs     ; Muestra el estado de los registros y banderas
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 6 - ROL: ROTACIÓN HACIA LA IZQUIERDA
	; Los bits que salen por el extremo izquierdo vuelven a entrar por el derecho.
	mov al, 10000001b ; Carga el valor base de prueba
	rol al, 1         ; Rota los bits de AL una posición hacia la izquierda
	
	call DumpRegs     ; Muestra el estado de los registros (CF = 1)
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 7 - ROR: ROTACIÓN HACIA LA DERECHA
	; Los bits que salen por el extremo derecho vuelven a entrar por el izquierdo.
	mov al, 10000001b ; Carga el valor base de prueba
	ror al, 1         ; Rota los bits de AL una posición hacia la derecha
	
	call DumpRegs     ; Muestra el estado de los registros
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 8 - RCL: ROTACIÓN HACIA LA IZQUIERDA CON ACARREO
	; Incorpora la bandera CF (Carry Flag) al recorrido; el recorrido es de 9 bits en total para AL.
	mov al, 10000001b ; Carga el valor base de prueba
	rcl al, 1         ; Rota AL una posición a la izquierda pasando a través de la bandera CF
	
	call DumpRegs     ; Muestra el estado de los registros
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	; 9 - RCR: ROTACIÓN HACIA LA DERECHA CON ACARREO
	; Incorpora la bandera CF al recorrido hacia la derecha.
	mov al, 10000001b ; Carga el valor base de prueba en AL
	rcr al, 1         ; Rota AL una posición a la derecha pasando a través de la bandera CF
	
	call DumpRegs     ; Muestra el estado de los registros
	call WriteBin     ; Muestra el resultado binario
	call Crlf

	exit

main ENDP

END main 