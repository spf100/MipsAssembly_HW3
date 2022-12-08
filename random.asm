# Main program, asks for number of N and starting seed
# $s5 is count, $s4 is N, $t3 is starting r and will change to new r as subroutine is used
         .text
         .globl  main
main:
         ori   $s5, $0, 0        # make count start at 0
         la    $a0,prompt3       # print "How many random integers:"
         li    $v0,4             # service 4
         syscall

         li    $v0,5             # read int into $v0
         syscall
         move  $s4,$v0           # value of how many random integers to be printed

         la    $a0,prompt        # print string "starting seed generator:"
         li    $v0,4             # service 4
         syscall

         li    $v0,5             # read int into $v0
         syscall                 # service 5
         move $t3,$v0            # value of starting r or generator seed



loop:    beq  $s5,$s4, end       # if count is equal to the number N, program end
         jal     rng             # read calculated r from subroutine
         nop                     #
         move    $a0,$v0         # save new r in $a0

         li      $v0,1           # print the sum from $a0
         syscall
         addiu   $s5,$s5, 1      # add 1 to count
         move    $t3, $a0        # copy new r value into old r value for next subroutine usage

         la      $a0,prompt2     # print string new line for clarity
         li      $v0,4           # service 4
         syscall

         j       loop            # go back up to loop


end:     li      $v0,10          # exit
         syscall


# random number generator or subroutine
# (a*r +c) mod m
# $t0 is a, $t1 is c, $t2 is m
# $t4 is to store calculated r, and into $v0 to pass to main program

         .text
         .globl  pread
rng:
         lw $t0, first
         lw $t1, second
         lw $t2, third
         mult $t0, $t3
         mflo $t4
         addu $t4, $t4,$t1
         and  $t4, $t4, $t2
         move $v0, $t4           # new r is calculated and stored into $v0
         jr    $ra               # return
         nop                     #

         .data
first:	.word 214013
second:	.word 2531011
third:	.word 2147483647

prompt:
         .asciiz "Random generator seed: "
prompt2:
         .asciiz "\n"
prompt3:
         .asciiz "How many random integers: "
