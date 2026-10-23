; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Comparación y prueba.
; Descripción: Programa que demuestra el funcionamiento de las instrucciones CMP y TEST, 
;evaluando cómo modifican las banderas ZF, SF, CF y OF

INCLUDE Irvine32.inc


.code
main PROC
	
	; CONDICIÓN 1: ZERO FLAG
	;La bandera ZF se activa (ZF = 1) cuando el resultado de una operación aritmética o de comparación es cero.
	mov eax, 10
	mov ebx, 10

	cmp eax, ebx ;CMP resta internamente sin guardar el resultado, en este caso activa Zero Flag
	call DumpRegs ; DumpRegs es una función que imprime el contenido de los registros y las banderas en la consola.

	mov eax, 10h ;Se usa ahora el valor hexadecimal 10h o 16 en decimal
	mov ebx, 10h
	cmp eax, 10h ; Se compara EAX directamente con el valor 10h, se activa el ZF

	call DumpRegs
	
	mov eax, 0 ; se limpia el contenido del registro eax
	mov al, 000000101b ;se asigna el valor de 0101 (5 en decimal) a la parte baja del regisro	eax
	cmp al, 5 ; se compara el valor con el valor de 5 decimal, se activa ZF

	call DumpRegs

	;CASO 2: SIGN FLAG
	; La bandera SF se activa cuando el resultado de una operación o comparación produce un número negativo.
	mov eax, 3
	mov ebx, 4
	cmp eax, ebx ;se compara 3 con 4 mediante una resta interna que resulta en negativo, se activa SF

	call DumpRegs

	mov eax, 0
	mov ebx, 0 ;se limpian los registros

	mov al, -5 ;se asigna el valor de -5 a la parte baja del registro eax
	mov bl, 1 ; se asigna el valor de 1 a la parte baja del registro ebx
	cmp al, bl ; compara-5 con 1, el resultado es negativo, se activa SF

	call DumpRegs

	;CASO 3: CARRY FLAG
	;La bandera CF se activa cuando una operación sin signo requiere un acarreo o un préstamo
	mov eax, 0
	mov ebx, 0

	mov al, 5 ; se asigna el valor de 5 a la parte baja del registro eax
	mov bl, 10 ; se asigna el valor de 10 a la parte baja del registro ebx
	cmp al, bl ;se compara 5 con 10, dado a que 5<10 se genera un acarreo por lo tanto se activa CF

	call DumpRegs

	;CASO 4: OVERFLOW
	;La bandera OF se activa cuando una operación con signo produce un resultado que excede el tamaño del registro
	mov eax, 0
	mov ebx, 0

	mov al, -128 ; se asigna el valor de -128 a al, el límite permitido para 8 bits con signo es de -128 a 127 
	mov bl, 1 ;se asigna 1  BL
	cmp al, bl ; Compara -128 con 1 el resultado es -129, esto excede el rango de 8 bits y se activa el desbordamiento (OF)

	call DumpRegs

	;CASO 5: TEST
	;realiza un AND bit a bit entre dos operandos sin modificar sus valores, únicamente actualizando las banderas en EFLAGS.
	mov eax, 0

	mov al, 5 ; 00000101b o 5 decimal
	test  al, 1 ;00000001b Evalua el bit 0 mediante un AND lógico

	call DumpRegs

	 
	mov al, 10000000b ; Asigna el valor de 128 decimal a al, el bit más significativo es 1
	test al, 10000000b ; realiza un AND lógico entre al y 10000000b, el resultado es 10000000b, lo que activa el SF
	;¿Porqué se activa el Sign Flag? El bit más significativo es el que se encuentra hasta la izquierda y es el que indica si el número es positivo o negativo. En este caso, el bit más significativo es 1, lo que indica que el número es negativo y por lo tanto se activa el Sign Flag. 

	call DumpRegs 

	exit
main ENDP
END main