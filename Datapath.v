module Datapath(
  input clk,
  input reset,
  input [31:0] instruction,
  input [31:0] PC,
  input RegWrite, ALUSrc,MEMRead, MEMwrite, MEMToReg, Branch,
  input [1:0] ALUOp,
  output Zero,
  output [31:0] ALUResult,
  output [31:0] WriteData,
  output [31:0] WriteBackData,
  output [31:0] BranchTarget );

  wire [4:0] rs1 = instruction[19:15];
  wire [4:0] rs2 = instruction[24:20];
  wire [4:0] rd = instruction[11:7];
  wire [6:0] funct7 = instruction[31:25];
  wire [2:0] funct3 = instruction[14:12];
  wire [6:0] opcode = instruction[6:0];

  wire [31:0] readData1, readData2;

  RegisterFile rf( .clk(clk), .RegWrite(RegWrite), .rs1(rs1), .rs2(rs2), .rd(rd), .writeData(WriteBackData), .readData1(readData1),.readData2(readData2));

  assign WriteData = readData2;

  reg [31:0] imm;
  always@(*)begin
    case(opcode)
      7'b0010011, 7'b0000011://I-Type
        imm = {{20{instruction[31]}},instruction[31:20]};
      7'b0100011://S-Type
        imm = {{20{instruction[31]}}, instruction[31:25], instruction[117]};
      7'b1100011: //B-Type
        imm= {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:0], 1'b0};
      default:
        imm = 32'd0;
    endcase
  end

  reg [3:0] ALUControl;
  always@(*)begin
    case(ALUOp)
      2'b00: ALUControl = 4'b0010; //ADD for load/store/addi
      2'b01: ALUControl = 4'b0110; //SUB for BEQ
      2'b10: begin //R_Type
        case({funct7, funct3})
          {7'b0000000, 3'b000}: ALUControl = 4'b0010; //ADD
          {7'b0100000, 3'b000}: ALUControl = 4'b0110; //SUB
          {7'b0000000, 3'b111}: ALUControl = 4'b0000; //AND
          {7'b0000000, 3'b110}: ALUControl = 4'b0001; //OR
          {7'b0000000, 3'b010}: ALUControl = 4'b0111; //SLT
          default:              ALUCOntrol = 4'b0000;
        endcase
      end
      default: ALUControl = 4'b0000;
    endcase
  end

  wire [31:0] ALUInput2 = (ALUSrc) ? imm : readData2;

  ALU alu(
    .A(readData1), .B(ALUInput2), .ALUControl(ALUControl), .Result(ALUResult), .Zero(Zero)
  );

  assign BranchTarget = PC + imm;

  assign WriteBackData = (MemToReg) ? 32'd0: ALUResult;

endmodule
          
          
      
  
  
  
