module Processor(
  input clk,
  input reset);

  wire [31:0] PC:
  wire [31:0] instruction;
  wire RegWrite, ALUSrc, MemRead, MemToReg, Branch;
  wire [1:0] ALUOp;
  wire Zero; 
  wire [31:0] ALUResult, WriteData, WriteBackData, BranchTarget;

  IFU IFU(
    .clk(clk),
    .reset(reset),
    .branch(Branch & Zero),
    .branchAddr(BranchTarget),
    .PC(PC),
    .instruction(instruction)
  );

  wire [6:0] opcode = instruction[6:0];

  ControlUnit CU(
    .opcode(opcode),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .Branch(Branch),
    .ALUOp(ALUOp)
  );

  DataPath DP(
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .PC(PC),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .Branch(Branch),
    .ALUOp(ALUOp),
    .Zero(Zero),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .WriteBackData(WriteBackData),
    .BrancgTarget(BranchTarget)
  );

endmodule
    
    
    
