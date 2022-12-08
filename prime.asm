main:
# Display message to user for a number
li $v0, 4
la $a0, msg
syscall

# read keyboard into $v0 (number x is upper bound number to find primes)
li $v0, 5
syscall
sw $v0, userEntry

# move the number from $v0 to $t0
move $t0, $v0 # $t0 = n

# store 2 in $t1 and $t2
li $t1, 2 # i
li $t2, 2 # j

L3: # for (int i=2; i<n; i++)
# store 0 in $t3
li $t3, 0 # p = 0;

L2: # for (int j=2; j<i; j++)
# do div of two numbers
div $t2, $t1

# store the remainder in $t4
mfhi $t4

# branch if remainder is not 0 to L1
bne $t4, 0, L1 # if (i % j == 0)

# set $t3 as 1
li $t3, 1 # p = 1

# if p=1 break to next i
beq $t3, 1, L4

L1: # if (i % j == 0)
# add 1 to t2
addi $t2, $t2, 1 # j++

# repeat code while j < i
blt $t2, $t1, L2

# print integer function call 1
# put the answer into $a0
li $v0, 1
move $a0, $t1
syscall # System.out.println(i)
#print comma
li $v0, 4
la $a0, comma
syscall

L4:
# add 1 to t1
addi $t1, $t1, 1 # i++

# repeat code while i < n
blt $t1, $t0, L3 # for (int i=2; i<n; i++)

.data
userEntry:	.word 0
msg: 	.asciiz "Please enter an integer: "
comma: .asciiz ","
