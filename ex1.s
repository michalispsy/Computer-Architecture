.data
x:      .word -7, -4, -3, -2, -1, 0   # Array x
y:      .word 70, 60, 50, 40, 30, 10       # Array y
n:      .word 6                      # Size of the arrays

.text
.globl main

main:
    # Load addresses of x and y into $a0 and $a1
    la   $a0, x           # Load address of x into $a0
    la   $a1, y           # Load address of y into $a1

    # Load n into $a2
    lw   $a2, n           # Load n = 6 into $a2

    # Call sum_min_arrays function
    jal  sum_min_arrays   # Jump to function
    # Result will be in $v0

    # Print the result
    move $a0, $v0         # Move result to $a0
    li   $v0, 1           # Syscall code for printing integer
    syscall               # Make syscall

    # Exit program
    li   $v0, 10          # Syscall code for exit
    syscall               # Make syscall

# sum_min_arrays function (same as before)
sum_min_arrays:
addi 	$sp, $sp, -8
sw 	$s1, 4($sp) 
sw 	$s0, 0($sp) 
lw 	$s0, 0($a0)
lw 	$s1, 0($a1) 
add 	$t3, $zero, $zero
addi 	$a2, $a2, -1

LOOP: 
slt 	$t4, $t3, $a2 
beq	$t4, $zero, END 
addi 	$a0, $a0, 4
addi 	$a1, $a1, 4
lw 	$t5, 0($a0) 
lw 	$t6, 0($a1) 
slt 	$t4, $t5, $s0
beq	$t4, $zero, CHECK2
add 	$s0, $t5, $zero

CHECK2: 
slt 	$t4, $t6, $s1 
beq	$t4, $zero, NEXT 
add 	$s1, $t6, $zero 

NEXT: 
addi 	$t3, $t3, 1
j 	LOOP 

END: 
add 	$v0, $s0, $s1 
lw 	$s0, 0($sp) 
lw 	$s1 , 4($sp) 
addi 	$sp, $sp, 8 
jr 	$ra


