addi $5, $2, 30     # Cargar 30 en $5 (sumando $2(20) + 30)
slti $6, $1, 40     # Set $6 = 1 si $1(10) < 40
add  $7, $1, $3     # $7 = $1(11) + $3(9)
beq  $20, $21, 6    # Saltar 3 líneas si $20(1) == $21(1)
nop
nop
nop
addi $15, $1, 1     # No se deberia ejecutar
addi $15, $1, 2     # No se deberia ejecutar
addi $15, $1, 3     # No se deberia ejecutar
addi $8, $1, -2     # $8 = $1(11) - 2
ori  $9, $0, 11     # $9 = $0(10) OR 11
andi $10, $1, 10    # $10 = $1 AND 10
sw   $1, $4, 5      # Guardar a la ram $1 en Mem[$4 + 5]
lw   $22, $4, 5     # Guardar al banco de registros la dirección Mem[$4 + 5] de la ram
j    1
nop