addi $2, $5, 30     # Cargar 30 en $5 (sumando $2 + 30)
nop
nop
nop
nop
nop
slti $5, $6, 40     # Set $6 = 1 si $5 < 40
nop
nop
nop
nop
nop
add  $7, $1, $3     # $7 = $1 + $3
nop
nop
nop
nop
nop
beq  $7, $2, 3      # Saltar 3 líneas si $2 == $7
nop
nop
nop
nop
nop
addi $5, $8, -25    # $8 = $5 - 25
nop
nop
nop
nop
nop
ori  $0, $9, 11     # $9 = $0 OR 11
nop
nop
nop
nop
nop
andi $1, $10, 10    # $10 = $1 AND 10
nop
nop
nop
nop
nop
sw   $4, $7, 5      # Guardar $7 en Mem[$4 + 5]
nop
nop
nop
nop
nop
