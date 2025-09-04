This repository contains the design and implementation of a custom RISC-V processor written in Verilog HDL and synthesized using Xilinx Vivado 2024.2. The processor is based on a five-stage pipelined architecture (Instruction Fetch, Instruction Decode, Execute, Memory Access, Write Back) and implements the RV32I instruction set.

The project also demonstrates a Smart Irrigation System as a case study, showing how the custom processor can be applied in embedded IoT systems.

---

## Features

- Implements the RISC-V RV32I ISA
- Five-stage pipelined architecture
- Core modules include:
  - Arithmetic Logic Unit (ALU)
  - Control Unit (CU)
  - Register File (RF)
  - Instruction Fetch Unit (IFU)
  - Datapath (DP)
- Hazard detection and forwarding mechanisms
- Testbenches provided for verification
- FPGA deployment ready using Vivado and Vitis

---

## Repository Structure

Custom-RISCV-Processor/
│── ALU.v # Arithmetic Logic Unit
│── ControlUnit.v # Instruction decoding and control signals
│── RegisterFile.v # 32-register storage with read/write ports
│── IFU.v # Program Counter and instruction memory
│── Datapath.v # Integrated execution path
│── Processor.v # Top-level CPU module
