.globl main

.data
newline: .asciiz "\n"
err_string: .asciiz "INPUT ERROR"

prompt_type: .asciiz "Random Numbers (r/R) or ASCII string (a/A)? "
prompt_ascii: .asciiz "Enter a ASCII string (max 100 characters): "
prompt_seed: .asciiz "Enter the seed: "
prompt_numbers: .asciiz "How many numbers? "

ascii: .space 101
seed: .word 1
num: .word 2

rand_last: .asciiz "Last value drawn: "
rand_odd: .asciiz "# of Odd: "
rand_power: .asciiz "Power of 2: "
rand_mult: .asciiz "Multiple of 8: "
rand_values: .asciiz "Values <= 512: "

ascii_length: .asciiz "Length of string: "
ascii_space: .asciiz "# of space characters: "
ascii_upper: .asciiz "# of uppercase letters: "
ascii_symbols: .asciiz "# of symbols: "
ascii_pairs: .asciiz "# of character pairs: "

.text

main:
    	#Print Prompt
	addi $v0, $0, 4
	la $a0, prompt_type
	syscall
	
	#Enter Character
	li $v0, 12
	syscall
	
	move $t0, $v0
	
	#Print endl
	addi $v0, $0, 4
	la $a0, newline
	syscall
	
	#Loading Letters
	li $t1, 'A'
	li $t2, 'a'
	li $t3, 'R'
	li $t4, 'r'
	
	#If and else
	beq $t0, $t1, A
	beq $t0, $t2, A

	beq $t0, $t3, R
	beq $t0, $t4, R
	addi $v0, $0, 4
	la $a0, err_string
	syscall
	#Terminate the program
	li $v0, 10
	syscall
	
	A:
	
	#Print Prompt
	addi $v0, $0, 4
	la $a0, prompt_ascii
	syscall
	
	#Enter String
	li $v0, 8
	addi $a1, $0, 101
	la  $a0, ascii 
	syscall
	
	#Count Setting
	li $t0, -1
	la $t1, ascii
	
	#Counting String
	while:
	lb $t2, 0($t1)
	beqz $t2, fin

	addi $t1, $t1, 1
	addi $t0, $t0, 1
	j while
	fin:
	
	#Print Lenght Prompt
	addi $v0, $0, 4
	la $a0, ascii_length
	syscall

	#Print Total
	li $v0, 1
	move $a0, $t0
	syscall	

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall
	
	#Space Settings
	la $s1, ascii
	addi $t3, $0, 0
	addi $t4, $0, 1
	
	#Counting Space
	while1:
	lb $t2, 0($s1)
	beqz $t2, fin1 
	addi $s1, $s1, 1
	beq $t2, ' ', spacec
	j while1
	
	spacec:
	add $t3, $t3, $t4
	j while1
	fin1:
	
	#Print Space Prompt
	addi $v0, $0, 4
	la $a0, ascii_space
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t3
	syscall	

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall
	
	#Upper Settings
	la $s1, ascii
	li $s2, 'A'
	li $s3, 'Z'
	move $t3, $zero
	
	#Counting Upper character
	while2:
	lb $t2, 0($s1)
	beqz $t2, fin2 
	addi $s1, $s1, 1
	bge $t2, $s2, upper
	j while2
	
	upper: 
	ble $t2, $s3, upper2
	j while2
	
	upper2:
	add $t3, $t3, $t4
	j while2
	
	fin2:
	
	#Print Upper Prompt
	addi $v0, $0, 4
	la $a0, ascii_upper
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t3
	syscall	

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall	

	#Upper Settings
	la $s1, ascii
	li $s2, 0x21
	li $s3, 0x2F
	li $s4, 0x3A
	li $s5, 0x40
	li $s6, 0x5B
	li $s7, 0x60
	li $t0, 0x7B
	li $t1, 0x7E
	move $t3, $zero
	
	#Counting Upper character
	while3:
	lb $t2, 0($s1)
	beqz $t2, fin3
	addi $s1, $s1, 1
	bge $t2, $t0, symbol4
	bge $t2, $s6, symbol3
	bge $t2, $s4, symbol2
	bge $t2, $s2, symbol1
	j while3
	
	symbol1:
	ble $t2, $s3, last
	j while3
	
	symbol2:
	ble $t2, $s5, last
	j while3
	
	symbol3:
	ble $t2, $s7, last
	j while3
	
	symbol4:
	ble $t2, $t1, last
	j while3
	
	last:
	add $t3, $t3, $t4
	j while3
	
	fin3:	

	#Print Upper Prompt
	addi $v0, $0, 4
	la $a0, ascii_symbols
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t3
	syscall	

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall	
	
	#2 Same Settings
	la $s1, ascii
	move $t3, $zero
	
	#Counting 2 Same
	while4:
	lb $t7, 0($s1)
	lb $t2, 1($s1)
	beqz $t2, fin4
	addi $s1, $s1, 1
	beq $t7, $t2, match
	j while4
	
	match:
	add $t3, $t3, $t4
	j while4

	fin4:
	
	#Print 2 Same Prompt
	addi $v0, $0, 4
	la $a0, ascii_pairs
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t3
	syscall	

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall
	
	#Terminate the program
	li $v0, 10
	syscall
	
	j DONE
	
	R:
	addi $v0, $0, 4
	la $a0, prompt_seed
	syscall
	
	#Enter Number
	li $v0, 5
	syscall
	
	sw $v0, seed
	lw $t0, seed
	
	#Enter Number Again
	addi $v0, $0, 4
	la $a0, prompt_numbers
	syscall
	
	#Enter Number
	li $v0, 5
	syscall
	
	sw $v0, num
	lw $t1, num
	
	bgtz $t1, DONE
	addi $v0, $0, 4
	la $a0, err_string
	syscall
	
	#Terminate the program
	li $v0, 10
	syscall
	DONE:	
	
	#Setting Seed	
	li $a0, 1	
	move $a1, $t0	
	li $v0, 40		
	syscall
		
	#Loop Math
	addi $s0, $0, 0
	addi $s1, $0, 1
	addi $s2, $0, 2
	
	add $t1, $t1, $s1
	
	sub $t8, $t1, $s1
	
	#Odd Counter
	addi $t3, $0, 0 
	
	#8 Counter
	addi $t4, $0, 0
	addi $t5, $0, 8
	
	#Value Counter
	addi $t6, $0, 512
	addi $t7, $0, 0
	
	#Power Counter
	addi $t9, $0, 0
	addi $s5, $0, 4
	addi $s6, $0, 16
	addi $s7, $0, 32
	addi $k0, $0, 64
	addi $k1, $0, 128
	addi $a2, $0, 256
	addi $a3, $0, 512
	addi $v1, $0, 1024
	
	#Prompt Last
	addi $v0, $0, 4
	la $a0, rand_last
	syscall
			
	#Random Number Loop
	random:
	
	#Random Number Generator
	li	$a0, 1		
	li	$a1, 1023	
	li	$v0, 42		
	syscall	
	
	add $a0, $a0, $s1
	
	addi $s0, $s0, 1
	beq $s0, $t1, finish
	
	#Odd Check
	div $a0, $s2
	mfhi $s3
	beq $s3, $s1, odd
	
	j next1
	odd: add $t3, $t3, $s1
	next1:
	
	#8 Check
	div $a0, $t5
	mfhi $s4
	beqz $s4, eight
	j next2
	eight: 
	add $t4, $t4, $s1
	j next2
	next2:
		
	#Value Check
	ble $a0, $t6, value
	j next3
	value: add $t7, $t7, $s1
	next3:	
	
	#Power Check
	beq $v1, $a0, fnext #1024
	beq $a3, $a0, fnext #512
	beq $a2, $a0, fnext #256
	beq $k1, $a0, fnext #128
	beq $k0, $a0, fnext #64
	beq $s7, $a0, fnext #32
	beq $s6, $a0, fnext #16
	beq $t5, $a0, fnext #8
	beq $s5, $a0, fnext #4
	beq $s2, $a0, fnext #2
	beq $s1, $a0, fnext #1
	j next7
	fnext:
	add $t9, $t9, $s1
	j next7
	next7:
	
	#Last Num
	beq $s0, $t8, lastn
	j cont
	lastn: 
	li $v0, 1
	syscall
	cont:
	
	j random
	
	finish:
	
	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall
	
	#Prompt Odd
	addi $v0, $0, 4
	la $a0, rand_odd
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t3 
	syscall

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall

	#Prompt Power of 2
	addi $v0, $0, 4
	la $a0, rand_power
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t9
	syscall

	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall

	#Prompt Mult of 8
	addi $v0, $0, 4
	la $a0, rand_mult
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t4 
	syscall
	
	#Print Endline
	addi $v0, $0, 4
	la $a0, newline
	syscall
	
	#Prompt Value <= 512
	addi $v0, $0, 4
	la $a0, rand_values
	syscall
	
	#Print Total
	li $v0, 1
	move $a0, $t7 
	syscall
	
	#Terminate the program
	li $v0, 10
	syscall
