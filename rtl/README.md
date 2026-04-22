# RTL Implementation

This folder contains the RTL design files for the 2×2 edge ML accelerator. It includes the top-level module, submodules for DMA feeding, matrix multiplication, and ReLU plus quantization, along with any synthesis-ready Verilog code used for hardware implementation.

## Contents
- `edge_accel_top.v`  
  Top-level RTL module that integrates all submodules.
- `simple_dma_feeder.v`  
  Loads input matrices and generates the feeder handshake signal.
- `mac_array_2x2.v`  
  Performs 2×2 matrix multiplication using four parallel MAC operations.
- `relu_quant.v`  
  Applies ReLU activation and quantization to the MAC outputs.
- `mac_int8.v`  
  Supporting MAC module for integer-based arithmetic and future scalability.
- Any additional RTL support files used in the design.

## Purpose
The RTL design implements the hardware datapath for the edge ML accelerator.  
It receives input control signals, loads matrices, computes matrix multiplication, and produces the final quantized outputs.  
The design is structured in a modular way to improve readability, reusability, and scalability.

## Functional Overview
The RTL pipeline is organized into the following stages:

### 1. DMA Feeder
- Accepts the `start` signal.
- Loads the input matrices.
- Asserts `feeder_done` when input loading is complete.

### 2. MAC Array
- Performs 2×2 matrix multiplication.
- Computes `c00`, `c01`, `c10`, and `c11`.
- Asserts `mat_done` when computation is complete.

### 3. ReLU and Quantization
- Applies ReLU activation.
- Performs right-shift quantization.
- Produces final outputs `q00`, `q01`, `q10`, and `q11`.

### 4. Top-Level Control
- Coordinates the complete flow.
- Receives `start` and `rst_n`.
- Generates the final `done` signal.

## Design Features
- Modular RTL architecture.
- Clean control handshake between pipeline stages.
- 2×2 matrix multiplication using four parallel outputs.
- Combinational post-processing for ReLU and quantization.
- Synthesis-ready Verilog implementation.
- Suitable for future expansion to larger array sizes.

## Verification Summary
The RTL implementation was verified against a software golden model and TensorFlow Lite reference.  
For the test matrices shown below, the RTL outputs matched the expected results exactly.

### Test Matrices
- A = `[[1, 2], [3, 4]]`
- B = `[[5, 6], [7, 8]]`

### Expected Matrix Multiplication Output
- C = `[[19, 22], [43, 50]]`

### Expected Quantized Output
- Q = `[[9, 11], [21, 25]]`

## Simulation Results
Vivado behavioral simulation confirmed correct operation of the RTL pipeline.  
The console and waveform outputs showed proper handshake timing and exact matching results for all outputs.

Example output:
```text
C matrix:
c00=19 c01=22
c10=43 c11=50

Q matrix:
q00=9 q01=11
q10=21 q11=25

PASS: matrix multiply correct
```

<img width="1067" height="281" alt="Screenshot 2026-04-21 225550" src="https://github.com/user-attachments/assets/87bcad6a-3965-42bc-8a1a-76f1b79d1133" />


## How to Use
1. Add the RTL files to your FPGA or simulation project.
2. Set `edge_accel_top.v` as the top module.
3. Run behavioral simulation in Vivado or your preferred simulator.
4. Verify the waveform signals:
   - `start`
   - `feeder_done`
   - `mat_done`
   - `done`
   - `c00`, `c01`, `c10`, `c11`
   - `q00`, `q01`, `q10`, `q11`
  
   <img width="1069" height="688" alt="Screenshot 2026-04-21 140215" src="https://github.com/user-attachments/assets/be254edb-bf2c-4a16-a4b8-8bb3a2e9ecd7" />

Using Iverilog

<img width="1919" height="970" alt="1" src="https://github.com/user-attachments/assets/2b127714-2868-4739-9c12-28afe6c08f78" />

<img width="1891" height="511" alt="2" src="https://github.com/user-attachments/assets/8f6b3485-c03e-4bc9-af1e-3d9a99e3c6fe" />




## Notes
- Keep module names and port names consistent across RTL and testbench.
- The design is intended for educational and research use.
- The architecture can be extended to support larger matrix dimensions and more complex ML operations.

## Future Scope
- Scale the accelerator to 4×4, 8×8, or NxN matrix sizes.
- Add AXI-based memory streaming for real hardware integration.
- Extend support to convolution and fully connected layers.
- Optimize the design for power, area, and throughput.
- Deploy the design on FPGA for real-time edge AI inference.

## Author
Manikanta Subbarao B

## Contact
- Email: (manikantasubbarao36@zohomail.in.in)
