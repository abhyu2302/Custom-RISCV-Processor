`timescale 1ns/1ps

module tb_processor;
  reg clk, rst;
  wire [31:0] imem_addr;
  reg [31:0] imem_data;
  wire [31:0] dmem_addr, dmem_wdata;
  wire dmem_we;
  reg [31:0] dmem_rdata;

  // Instantiate the DUT
  Processor dut (
    .clk(clk),
    .rst(rst),
    .instr_addr(imem_addr),
    .instr(inmem_data),
    .mem_addr(dmem_addr),
    .mem_wdata(dmem_wdata),
    .mem_we(dmem_we),
    .mem_rdata(dmem_rdata)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset logic
  initial begin
    rst = 1;
    #20 rst = 0;
  end

  // Instruction Memory Model
  always @(posedge clk) begin
    case (imem_addr)
      32'h0: imem_data <= 32'h...; // Example instruction
      // add more PC cases
      default: imem_data <= 32'h0000_0000;
    endcase
  end

  // Data Memory Model + MMIO for logger and exit
  always @(posedge clk) begin
    if (dmem_we) begin
      if (dmem_addr == 32'h1000_0000) begin
        $display("TB OUTPUT: %c", dmem_wdata[7:0]);
      end else if (dmem_addr == 32'h2000_0000 && dmem_wdata == 32'h75BCD15) begin
        $display("SIMULATION PASSED at time %0t", $time);
        $finish;
      end else begin
        // Real memory modeling if needed
      end
    end
  end

  initial begin
    #100000; // Simulation time limit
    $display("TIMEOUT: SIMULATION DID NOT FINISH");
    $finish;
  end
endmodule
