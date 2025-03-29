.data
input:	.word 655     # int input

.text
.globl main

main:
    # Load input into $a0
    la 	$a0, input     

    # Call sum_min_arrays function
    jal  cslab_hash   # Jump to function
    # Result will be in $v0

    # Print the result
    move   $a0, $v0       # Move result to $a0
    li     $v0, 1         # Syscall code for printing integer
    syscall               # Make syscall

    # Exit program
    li   $v0, 10          # Syscall code for exit
    syscall               # Make syscall

cslab_hash:
    addi 	$sp, $sp, -8
    sw	    $s0, 4($sp)
    sw 	    $ra, 0($sp)
    lw  	$s0, 0($a0) #φορτώνουμε την input στον $s0
    ori	    $t0, $zero, 0x1505 #φορτώνουμε στην $t0 το hash=5381 => 0x1505(hex)

LOOP:
    beq	    $s0, $zero, END	#Εάν το input ($s0) είναι 0, πήγαινε στο end
    andi	$t1, $s0, 0xFF	#input AND 1111 1111 => store στον $t1 (c)	
    sll	    $t2, $t0, 4	#Κάνε shift left logical 4 το hash ($t0) και αποθύκευσε το στον $t2
    add	    $t3, $t2, $t0	#Πρόσθεσε στoν $t2 το hash ($t0)
    add	    $t0, $t3, $t1	#Πρόσθεσε το c και τον $t3. Αυτό είναι το νέο hash
    srl	    $s0, $s0, 8	#Κάνε shift right logical το input.
    j	    LOOP

END: 
    or	    $v0, $zero, $t0 #επιστρέφουμε την hash ($t0) στον $v0
    lw 	    $ra, 0($sp)
    lw 	    $s0, 4($sp)  
    addi 	$sp, $sp, 8 
    jr 	    $ra


Ο κώδικας σε C
#include <stdio.h>

unsigned int cslab_hash(unsigned int input){
unsigned int hash = 5381;
 int c;
 while (input != 0) {
c = (input & 0xFF);
hash = ((hash << 4) + hash) + c;
input = input >> 8;
 }
 return hash;
}

int main() {
    unsigned int i = cslab_hash(655);
    printf("%u\n", i); // Use %u for unsigned int
    return 0;
}