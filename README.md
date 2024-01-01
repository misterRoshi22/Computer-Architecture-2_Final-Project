# Limited Version RISC-V Processor

This RISC-V processor is a simplified implementation supporting a restricted set of instructions and functionalities. It was developed as a final project for the Computer Architecture course.

## Overview
The processor is designed to execute a limited set of instructions and perform specific functionalities, catering to the essential aspects of a RISC-V architecture.

## Features
- **Instruction Set:** Supports a subset of RISC-V instructions.

| No. | NAME               | FORMAT | MNEMONIC  | Description (in Verilog)                          | OPCODE/FUNCT3/FUNCT7 or IMM in HEX |
|-----|--------------------|--------|-----------|---------------------------------------------------|-------------------------------------|
| 1   | Add                | R      | add       | R[rd] = R[rs1] + R[rs2]                           | 33/6/00                             |
| 2   | Add Immediate      | I      | addi      | R[rd] = R[rs1] + imm                              | 1B/0                                |
| 3   | And                | R      | and       | R[rd] = R[rs1] & R[rs2]                           | 33/5/00                             |
| 4   | And Immediate      | I      | andi      | R[rd] = R[rs1] & imm                              | 13/6                                |
| 5   | Branch On Equal    | SB     | beq       | PC=PC+{imm, 1b'0} if(R[rs1]==R[rs2])              | 63/1                                |
| 6   | Branch On Not Equal| SB     | bne       | PC=PC+{imm, 1b'0} if(R[rs1]!=R[rs2])              | 63/0                                |
| 7   | Jump And Link      | UJ     | jal       | R[rd]=PC+4; PC=PC+{imm, 1b'0}                     | 6F                                  |
| 8   | Jump And Link Reg  | I      | jalr      | R[rd]=PC+4; PC= R[rs1] + imm                      | 67/0                                |
| 9   | Load Byte (1)      | I      | lb        | R[rd]={24’bM[](7), M[R[rs1]+imm](7:0)}            | 03/2                                |
| 10  | Load Upper Imm.    | U      | lui       | R[rd] = {imm, 12’b0}                              | 38                                  |
| 11  | Load Word          | I      | lw        | R[rd] = {M[R[rs1]+imm](31:0)}                     | 03/0                                |
| 12  | xor                | R      | xor       | R[rd] = R[rs1] ^ R[rs2]                           | 33/7/00                             |
| 13  | Or                 | R      | or        | R[rd] = R[rs1] | R[rs2]                           | 33/3/00                             |
| 14  | Or Immediate       | I      | ori       | R[rd] = R[rs1] | imm                              | 13/7                                |
| 15  | Set Less Than      | R      | slt       | R[rd] = (R[rs1] < R[rs2]) ? 1 : 0                 | 33/4/00                             |
| 16  | Shift Left         | R      | sll       | R[rd] = R[rs1] << R[rs2]                          | 33/2/00                             |
| 17  | Shift Right        | R      | srl       | R[rd] = R[rs1] >> R[rs2]                          | 33/0/00                             |
| 18  | Store Byte         | S      | sb        | M[R[rs1]+imm](7:0) = R[rs2](7:0)                  | 23/2                                |
| 19  | Store Word         | S      | sw        | M[R[rs1]+imm](31:0) = R[rs2](31:0)               | 23/0                                |
| 20  | Subtract           | R      | sub       | R[rd] = R[rs1] - R[rs2]                           | 33/1/20                             |


- **Pipeline:** Incorporates a basic pipeline structure, outlining the stages and their functionalities.
- **Memory Access:** Provides simplified memory access and handling instructions.
- **Control Unit:** Implements a simple control unit to manage instruction execution flow.

## Supported Instructions
- List the supported instructions and their functionalities.
- Mention any specific peculiarities or modifications from the standard RISC-V ISA.

## Block Diagram
Include a high-level block diagram showcasing the architecture of the processor. Highlight the main components and their connections.

## How to Use
- **Installation:** Describe how to set up and run the processor.
- **Usage:** Provide examples or steps to assemble code and execute programs on the processor.

## Limitations
Mention any limitations or constraints of this limited version processor, such as the inability to support specific instruction types or functionalities.

## Future Improvements
Discuss potential enhancements or features that could be added to extend the functionality of the processor in future iterations.

## Contributors
Acknowledge the contributors involved in the development of this limited RISC-V processor.

## License
Specify the license under which this processor is distributed.

## References
Cite any references, textbooks, or resources used in the development of the processor.



