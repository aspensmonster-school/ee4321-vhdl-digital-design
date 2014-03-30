Operation Table:

|Operation	|Operation Type	|Opcode|
|---------------|:-------------:|:----:|
| A+B           | add_sub       |000XXX|
| A-B           | add_sub       |001XXX|
| A>=B(signed)  | comp          |011001|
| A<B(signed)   | comp          |011010|
| A != B        | comp          |011011|
| A = B         | comp          |011100|
| A >= B        | comp          |011101|
| A < B         | comp          |011110|
| A NOR B       | logical       |10XX00|
| A AND B       | logical       |10XX01|
| A OR B        | logical       |10XX10|
| A XOR B       | logical       |10XX11|
| A rol B       | shift_rot     |11X000|
| A ror B       | shift_rot     |11X001|
| A sll B       | shift_rot     |11X010|
| A srl B       | shift_rot     |11X011|
| A sra B       | shift_rot     |11X111|
