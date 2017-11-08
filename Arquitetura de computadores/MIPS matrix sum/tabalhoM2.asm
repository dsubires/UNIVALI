# Disciplina: Arquitetura de Computadores
# Atividade: Trabalho M2
# Grupo: - David Subires Parra, James Amorim e Luis Eduardo Borgert
	
	.data

### inicio declaracao dos vetores ###
# To declare an array of integer-sized elements, recall that on the MIPS architecture, each integer requires 4 bytes (or 32 bits). 
# Also, each word on the MIPS architecture is 4 bytes. Therefore, we may use the .word directive to declare an array of integers: 
Array_A: .word 0:100
Array_B: .word 1:100
Array_C: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
### fim declaracao dos vetores ###

Msg1:     .asciiz "\nEntre com o tamanho do índice das matrizes (máx. = 10):"
Msg2:     .asciiz "\nO tamanho deve ser maior que 0 e menor ou igual a 10:"
Msg3:     .asciiz "\nEnter 0 to iterate the matrix in line-column or 1 in column-line:"
Msg4:	  .asciiz "\nInput was 0 (iterate matrix line-column)\n"
Msg5:     .asciiz "\nInput was 1 (iterate matrix column-line)\n"
MsgToReset: .asciiz "Quieres salir de la aplicacion y/n:"

input: .space 1


.text

main:

	# $s0 tamanho do incide das matrizes
	# $s1 mode to iterate the martix, 0 --> line-column and 1 --> column-line
	# $s2 address of ArrayA 
	# $s3 address of ArrayB
	# $s4 address of ArrayC
	
	# $t0 value of element. ArrayA[i]
	# $t1 value of element. ArrayB[i]
	# $t2 value of sum. ArrayC[i] = ArrayA[i] + ArrayB[i]
	# $t3 index of elements. i
	# $t4 number of elements of arrays. Array.size
	# $t5 index of elements. j 
	# $t6 number of elements iterated. counter
	# $t7 memory address


### inicio entrada do tamanho dos vetores e verificacao ###
	# escreve string
	li   $v0, 4			# chamada 4
      	la   $a0, Msg1			# Digite o tamanho do incice das matrizes (max = 10):
      	syscall 
	
Loop1:	# loop for set the correctly size of array
      	li   $v0, 5			# chamada 5
      	syscall                    
      	add  $s0, $v0, $zero		# salva $v0 em $s0
      	slti $t0, $s0, 11		# se $s0 < 11, $t0 = 1
      	slt $t1, $zero, $s0		# se 0 < $s0, $t1 = 1
      	beq  $t0, $zero, Exit1		# se $t0 == 0, va para o Exit1
      	beq  $t1, $zero, Exit1		# se $t1 == 0, va para o Exit2
      	j Loop2				#jump to skip Exit1

Exit1:  # escreve string
	li   $v0, 4			# chamada 4
      	la   $a0, Msg2			# Valor invalido, entre outro valor:
      	syscall
      	
      	j    Loop1			# volta para Loop1
### fim entrada do tamanho dos vetores e verificacao ###
      	
Loop2:  # loop to establish the way in which the matrices are iterated
	# 0:line-column or 1:column-line
	li $v0,4
      	la $a0, Msg3		#show message for input a number
      	syscall	
     	li   $v0, 5		#input a number
      	syscall   
      	add $s1, $v0, $zero
      	addi $s2, $zero, 1
      	beq $s1, $zero, LineColumn	#input == 0
      	beq $s1, $s2, ColumnLine	#input == 1
      	j Loop2			#input != 0 && input != 1  
      	                 
      	                 
      	                 
      	                
LineColumn:
	li   $v0, 4			# chamada 4
      	la   $a0, Msg4			# input = 0. Line-column
      	syscall
      	
      	move $t0, $zero			# reset the variable of sum. suma = 0
      	move $t3, $zero			# reset the variable of index. i = 0
      	la $s2, Array_A			# cargamos la dirección del arrayA en $s2
      	la $s3, Array_B			# cargamos la dirección del arrayB en $s3
      	la $s4, Array_C			# cargamos la dirección del arrayC en $s4
      	mul $t4, $s0, $s0		# calculamos el numero total de elementos. $t4 = $s0 * $s0
LoopLineColumn:
	lw $t0,0($s2) 			# Carga del elemento referenciado por la dirección s2, en t0. $t0 = Array_A[i]
	lw $t1,0($s3) 			# Carga del elemento referenciado por la dirección s3, en t1. $t1 = Array_B[i]
	add $t2, $t0, $t1		# Sumamos los elementos de a y b y los guardamos en $t2. $t2 = $t0 + $t1
	sw $t2, 0($s4)			# Guardamos el valor de la suma en el array c. Array_C[i] = $t2
	addi $t3,$t3,1 			# Incremento del indice. i++
	addi $s2,$s2,4 			# Incrementamos la dirección base sumándole 4 bytes para que así apunte al siguiente elemento del vector.
	addi $s3,$s3,4 			# Incrementamos la dirección base sumándole 4 bytes para que así apunte al siguiente elemento del vector.
	addi $s4,$s4,4 			# Incrementamos la dirección base sumándole 4 bytes para que así apunte al siguiente elemento del vector.
	blt $t3,$t4,LoopLineColumn 		# Repite el bucle si no se ha llegado al ultimo elemento. if (i<array.size) go to Loop      	
      	j END
      	

SetVariablesToIterate:

	slt $s5, $t6, $t4		# si el contador es menor que el numero de elementos, seteamos $s5 a 1
	beq $s5, $zero, END		# si el contador NO es menor que el numero de elementos, ya hemos recorrido toda la matriz, go to exit

	add $t5, $zero,$zero		# reseteamos j a cero. j=0
	addi $t3, $t3, 1		# sumamos uno a i. i++
	
	
	j LoopColumnLine

ColumnLine:
	li   $v0, 4			# chamada 4
      	la   $a0, Msg5			# Valor invalido, entre outro valor:
      	syscall
      	
      	move $t0, $zero			# reset the variable of sum. suma = 0
      	move $t3, $zero			# reset the variable of index. i = 0
      	move $t5, $zero			# reset the variable of index. j = 0
      	move $t6, $zero			# reset the variable of counter. counter = 0
      	mul $t4, $s0, $s0		# calculamos el numero total de elementos. $t4 = $s0 * $s0
      	
LoopColumnLine:
	
      	la $s2, Array_A			# cargamos la dirección del arrayA en $s2
      	la $s3, Array_B			# cargamos la dirección del arrayB en $s3
      	la $s4, Array_C			# cargamos la dirección del arrayC en $s4
      					
					# para calcular el índice en el modo ColumnaLinea, la fórmula será: posición=j*n+i
	mul $t7, $t5, $s0		# multiplicamos j por n. 
	add $t7, $t7, $t3		# sumamos i
	mul $t7, $t7, 4			# multiplicamos por 4 (cada número ocupa 4 bytes)
	
	add $s2,$s2,$t7			# Incrementamos la dirección base sumándole (j*n+i)*(4)
	add $s3,$s3,$t7 		# Incrementamos la dirección base sumándole (j*n+i)*(4)
	add $s4,$s4,$t7 		# Incrementamos la dirección base sumándole (j*n+i)*(4)

	lw $t0,0($s2) 			# Carga del elemento referenciado por la dirección s2, en t0. $t0 = Array_A[i]
	lw $t1,0($s3) 			# Carga del elemento referenciado por la dirección s3, en t1. $t1 = Array_B[i]
	add $t2,$t0,$t1			# Sumamos los elementos de a y b y los guardamos en $t2. $t2 = $t0 + $t1
	sw $t2,0($s4)			# Guardamos el valor de la suma en el array c. Array_C[i] = $t2
	
	
	addi $t5,$t5,1 			# Incremento del indice. j++
	addi $t6, $t6,1			# Incremento del counter. counter++
	

	slt $s6, $t5, $s0		# si el indice j es menor que el ancho de la matriz (n) seteamos $s5 a 1 
	beq $s6, $zero, SetVariablesToIterate #si el indice j no es menor al ancho de la matriz, go to SetVariablesToIterate
	blt $t6,$t4,LoopColumnLine	# Repite el bucle si no se ha llegado al ultimo elemento. if (i<array.size) go to Loop      	
      	
END:


	li   $v0, 4			# MOSTRAR MENSAJE PARA SALIR O NO
      	la   $a0, MsgToReset		# MOSTRAR MENSAJE PARA SALIR O NO 
      	syscall

        la $a0,input	   # CARGAMOS EN $a0 LA DIRECCION DEL BUFFER DONDE SE ALMACENARA LA RESPUESTA
        li $a1,10          # CARGAMOS EN $a0 LA DIRECCION DEL BUFFER DONDE SE ALMACENARA LA RESPUESTA
        li $v0,8           # CARGAMOS EN $a0 LA DIRECCION DEL BUFFER DONDE SE ALMACENARA LA RESPUESTA
        syscall 	   # CARGAMOS EN $a0 LA DIRECCION DEL BUFFER DONDE SE ALMACENARA LA RESPUESTA
        
        lb $t1, 0($a0)     # CARGAMOS EN $t1 LA RESPUESTA INTRODUCIDA POR EL USUARIO
        bne $t1, 'y', main # SI LA RESPUESTA ES y, FINALIZA LA EJECUCION. EN CUALQUIER OTRO CASO VUELVE A EMPEZAR
        
        li  $v0, 10 	   # TERMINATE EXECUTION
	syscall 


	
      	
      	
      	

      	
      	

      	

      	
