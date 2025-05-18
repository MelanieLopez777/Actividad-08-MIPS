lw   $2, $1, 0   # Cargo el numero 5381
lw   $3, $1, 8   # Cargo el numero de chars, en este caso 3 - 1
addi $1, $1, 14  # Sumar 10 al 4 para poder cargar los caracteres
nop
nop
lbu  $5, $1, 0   # Cargo la letra en ascci
sll  $6, $2, 5
nop
nop
add  $6, $6, $2
nop
nop
add  $6, $6, $5
nop
nop
beq  $4, $3, 5
addi $4, $4, 1
addi $1, $1, -1
addi $2, $6, 0
j   6
nop
nop
nop
sw $2, $1, 5