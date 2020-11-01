# thegail-vm
thegail-vm is a simulation of a very basic computer processor.

It's super simple to get started!


## Getting Started


Initialization: `let myProcessor = Processor()`

Writing instructions/data: `myProcessor.memory.write(addr: 0x0000, c: Byte(fromInt: 0x00))`

Reading from memory: `print(myProcessor.memory.read(addr: 0x0000).toint())`

After you've written all of the instructions/data, just `myProcessor.start()`


## Instruction Set


Each instruction is made up of three bytes. An instruction byte (key below) and two bytes that make up a memory address (high order byte first).


### Instruction Codes


    0x10 LOD Load from memory to accumulator
  
    0x11 STO Store from accumulator to memory
  
    0x20 ADD Add the contents of the specified memory address to the accumulator
  
    0x21 AWC Add the contents of the specified memory address to the accumulator, using the carry flag as a carry in
  
    0x22 SUB Subtract the contents of the specified memory address from the accumulator
  
    0x30 JMP Jump the program counter to the specified memory address
  
    0x31 JZ  Jump the program counter to the specified memory address, if the zero flag is set
  
    0x32 JNZ Jump the program counter to the specified memory address, if the zero flag is not set
  
    0x33 JC  Jump the program counter to the specified memory address, if the carry flag is set
  
    0x34 JNC Jump the program counter to the specified memory address, if the carry flag is not set
  
    0xFF HLT Stop the program counter, ending the program


### Flags


There are two "flags." A carry flag and a zero flag. The carry flag is set if an add or subtract instruction occurs and there is an overflow or an underflow.
This can be used when adding multi-byte numbers. The zero flag is set if the contents of the accumulator equal zero.
