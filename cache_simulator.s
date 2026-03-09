.data
array: .word 5,10,15,20,25,30,35,40

.text
.globl main
main:

la x1, array
li x2, 8
li x3, 0

li x10, 0xF0000000     # LED matrix base

li x11, 0x00FF0000    # RED  (Cache MISS)
li x12, 0x0000FF00     # GREEN (Cache HIT)

# -------- FIRST ACCESS (MISS) --------
loop1:

slli x4, x3, 2
add x5, x1, x4
lw x6, 0(x5)           # memory access (MISS)

slli x7, x3, 2
add x8, x10, x7        # LED in first row

sw x11, 0(x8)          # RED LED

addi x3, x3, 1
blt x3, x2, loop1


# reset counter
li x3, 0


# -------- SECOND ACCESS (HIT) --------
loop2:

slli x4, x3, 2
add x5, x1, x4
lw x6, 0(x5)           # memory access (HIT)

slli x7, x3, 2
addi x7, x7, 100       # move to second row

add x8, x10, x7
sw x12, 0(x8)          # GREEN LED

addi x3, x3, 1
blt x3, x2, loop2


li a7,10
ecall