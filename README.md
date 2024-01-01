# Limited Version RISC-V Processor

This RISC-V processor is a simplified implementation supporting a restricted set of instructions and functionalities. It was developed as a final project for the Computer Architecture course.

## Overview

The processor design represents a fundamental implementation adhering to the principles of the RISC-V architecture, specifically tailored to execute a constrained yet critical set of instructions. It encompasses a streamlined approach focusing on essential functionalities to achieve operational efficiency.

This RISC-V processor is structured with a limited instruction set, deliberately chosen to cover fundamental arithmetic, logic, memory access, and branching operations. The primary aim is to encapsulate core functionalities while maintaining simplicity in design and execution.

The processor's architecture embodies a 5-stage pipeline, allowing for sequential instruction execution through distinct stages: Instruction Fetch (IF), Instruction Decode (ID), Execute (EXE), Memory (MEM), and Write-back (WB). Each stage plays a pivotal role in processing instructions, managing data flow, and ensuring effective synchronization to enable efficient execution.

With a focus on simplicity and effectiveness, this processor design aims to demonstrate the core principles of RISC-V architecture, offering a foundational understanding of essential processor functionalities and pipeline structures.


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
The 5-stage pipelined RISC-V processor is designed with the following sequential stages:

#### 1. Instruction Fetch (IF) Stage:
- Fetches instructions from memory based on the program counter (PC).
- Determines PC values using control signals and the PC MUX.
- Writes fetched instructions onto the IF/ID Register at the negative edge.

#### 2. Instruction Decode (ID) Stage:
- Contains seven modules, including the register file and immediate generator.
- Uses control signals from OpCode and funct-3 to determine further execution controls.
- Handles branching through a comparator and branch-related modules.

#### 3. Execute (EXE) Stage:
- Hosts the ALU (Arithmetic Logic Unit) and forwarding logic.
- Performs arithmetic/logic operations using operands obtained from preceding stages.
- Utilizes forwarding paths to mitigate Read-After-Write (RAW) hazards.

#### 4. Memory (MEM) Stage:
- Executes load/store instructions based on the address calculated in the EXE stage.
- Performs read/write operations on memory based on control signals (MemRead/MemWrite).

#### 5. Write-back (WB) Stage:
- Concludes an instruction's lifecycle.
- Uses a MUX to select data to be written into registers based on control signals (MemToReg).

Each stage is interconnected via registers, facilitating smooth information flow and synchronization between stages. Dedicated units such as the Hazard Detection Unit and Branch Controller manage hazards and mispredictions to ensure robust functionality within the pipeline.

- **ALUOp:** Provides simplified memory access and handling instructions.
  
| Operation | Description                          | Verilog Operation                |
|-----------|--------------------------------------|----------------------------------|
| 0         | AND                                  | ALU_Result = A & B               |
| 1         | OR                                   | ALU_Result = A \| B              |
| 2         | ADD                                  | ALU_Result = $signed(A) + $signed(B) |
| 3         | XOR                                  | ALU_Result = A ^ B               |
| 4         | SLL - Shift Left Logical             | ALU_Result = (A << B)            |
| 5         | SRL - Shift Right Logical            | ALU_Result = (A >> B)            |
| 6         | SUB                                  | ALU_Result = $signed(A) - $signed(B) |
| 7         | LUI - Load Upper Immediate           | ALU_Result = B                   |
| 8         | SLT - Set on Less Than               | ALU_Result = (A < B) ? 1 : 0     |



## Block Diagram
![top level block diagram](https://github.com/misterRoshi22/RISC-V-Processor/assets/109997866/29609d61-c64a-4956-8bff-ea2d047e7716)

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



