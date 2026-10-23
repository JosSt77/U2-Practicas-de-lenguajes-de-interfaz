; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 8. Operaciones aritméticas
; Descripción: Se realizan las operaciones aritmeticas ADD, SUB, MUL, IMUL, DIV, IDIV
; además se plantea el uso de las banderas CarryFlag y OverFlow Flag junto con el uso
; de CDQ
INCLUDE Irvine32.inc
.data
.code
main proc 
	; 1. ADD y SUB: OPERACIONES DE SUMA Y RESTA
	;SE CARGAN LOS VALORES EN EAX Y EBX
	mov eax, 50 
	mov ebx, 20 

	add eax, ebx ; SE SUMA EBX A EAX: 50+20
	sub eax, 15 ; SE RESTA 15 AL REGISTRO EAX: 70-15

	nop; Instrucción que hace que programa se detenga en este punto y realice cambios

	; 2. CF: ACARREO EN UNA SUMA SIN SIGNO

	mov eax, 0 ;LIMPIA EL REGISTRO EAX
	mov al, 255 ; CARGA FFh EN AL, ESTE ES EL LÍMITE MÁXIMO PARA 8 BITS SIN SIGNO

	mov al, 1 ;SE REEMPLAZA EL VALOR DE AL POR 1

	nop


	; 3. OF: DESBORDAMIENTO EN SUMA CON SIGNO
	mov eax, 0 ;LIMPIA EL REGISTRO
	mov al, 127 ;CARGA 127 EN AL, ESTE ES EL LÍMITE MÁXIMO PARA 8 BITS CON SIGNO

	add al, 1 ; SE SUMA 1 A AL: 127+1
			  ; ESTO EXCEDE EL RANGO DEL SIGNO Y ACTIVA OF

	nop

	; 4. MUL: PRODUCTO DE VALORES DENTRO DE 32 BITS SIN SIGNO
	;SE CARGAN VALORES EN EAX Y EBX
	mov eax, 25
	mov ebx, 3

	mul ebx ;MULTIPLICA EAX POR EBX SIN SIGNO: 25*3
			;GUARDA EL RESULTADO EN EAX

	nop

	;5. IMUL: PRODUCTO DE VALORES CON SIGNO DENTRO DE 32 BITS 

	mov eax, -5 ;CARGA UN VALOR ENTERO CON SIGNO EN EAX

	imul eax, eax, 3 ; SE MULTIPLICA EAX POR 3 CON SIGNO: -5*3
					 ; GUARDA EL RESULTADO EN EAX

	;6. MUL: PRODUCTO DE VALORES QUE EXCEDEN 32 BITS

	mov eax, 65537
	mov ebx, 655537

	mul ebx ;MULTIPLICA EAX POR EBX, EL RESULTADO EXCEDE LOS 32 BITS
			;POR LO TANTO EL RESULTADIO SE DISTRUBUYE EN EDX, EAX
	
	nop

	;7. DIV: DIVISIÓN DE NÚMERO SIN SIGNO
	mov eax, 125 ;SE ASIGNA EL DIVIDENDO
	mov edx, 0 ; SE LIMPIA EDX PARA FORMAR EL DIVIDENDO COMPLETO SIN SIGNO
	mov ebx, 12 ;SE CARGA EL DIVISOR EN EBX

	div ebx ; DIVIDE EBX:EAX ENTRE EBX, EL COCIENTE SE GUARDA EN EAX Y EL RESIDUO EN EDX

	nop
	

	;8. IDIV: DIVISIÓN CON NÚMEROS NEGATIVOS

	mov eax, -125 ;SE CARGA UN DIVIDENDO NEGATIVO EN EAX
	cdq ;SE EXIENTE EL BIT DE SIGNO DE EAX HACIA EDX (CON LA FORMA FFFFFFFFh)
		;PARA REALIZAR CORRECTAMENTE LA DIVISIÓN CON SIGNO

	mov ebx, 12 ;CARGA EL DIVISOR DE 12 EN EBX

	idiv ebx ;DIVIDE EDX:EAX ENTRE EBX CON SIGNO, GUARDA EL COCIENTE EN EAX Y EL RESIDUO EN EDX

	nop
	exit
main ENDP

END main