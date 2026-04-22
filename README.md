# .Edge-ML-accelerator
RTL-based 2×2 Edge ML Accelerator with DMA feeder, MAC array, ReLU quantization, software golden model, and Vivado verification for FPGA-based edge AI acceleration.

Overview
This repository contains the RTL implementation and verification assets for a 2×2 edge machine learning accelerator. The design performs matrix multiplication using a 2×2 MAC array, followed by ReLU activation and quantization, with results verified against a software golden model and TensorFlow Lite FP32 reference. The project demonstrates a complete hardware-software co-verification flow and is intended as a foundation for scalable FPGA-based edge AI acceleration.

Features
	2×2 matrix multiplication accelerator in RTL.

	DMA feeder for input matrix loading.

	Parallel MAC computation for four output values.

	ReLU and quantization post-processing.

	Software golden model for reference checking.

	TensorFlow Lite FP32 model generation and validation.

	Vivado behavioral simulation verification.

	Modular design suitable for future scaling.

Project Structure
edge_ml_accel/
├── rtl/
│   ├── edge_accel_top.v
│   ├── simple_dma_feeder.v
│   ├── mac_array_2x2.v
│   ├── relu_quant.v
│   └── mac_int8.v
├── tb/
│   └── tb_edge_accel.v
├── sw/
│   ├── golden_model.py
│   ├── create_fp32_model.py
│   ├── tflite_check_1.py
│   └── model_fp32.tflite
└── report/
    └── project_report.pdf

Verification Summary
The design was verified using both software and RTL simulation. The input matrices used for validation were:
A = [[1, 2],
     [3, 4]]

B = [[5, 6],
     [7, 8]]

The expected outputs were:
C = [[19, 22],
     [43, 50]]

Q = [[9, 11],
     [21, 25]]

Simulation Results
Vivado XSim behavioral simulation produced the following output:

Starting simulation...
C matrix:
c00=19 c01=22
c10=43 c11=50
Q matrix:
q00=9 q01=11
q10=21 q11=25
PASS: matrix multiply correct

Software Integration
The repository includes software-side scripts used to validate the RTL implementation:

	golden_model.py generates the expected matrix multiplication and quantized outputs.

	create_fp32_model.py creates the TensorFlow Lite FP32 model.

	tflite_check_1.py compares the TFLite output with the expected RTL result.

The TFLite verification output matched the expected RTL output exactly:

TFLite FP32 output: [19 22 43 50]
Expected RTL C:      [19 22 43 50]
MATCH: True

Future Scope
	Extend the design to 4×4, 8×8, or NxN matrix sizes.

	Replace the fixed feeder with AXI-based memory streaming.

	Add support for larger neural network layers.

	Optimize for power, area, and throughput.

	Implement FPGA deployment for real-time edge inference.

Conclusion
This project demonstrates the design and verification of a compact edge ML accelerator in RTL. The results from software, TensorFlow Lite, and Vivado simulation all match exactly, proving the correctness of the implementation. The modular architecture makes the design suitable for future expansion into larger and more advanced FPGA-based ML accelerators.

Requirements
	Python 3.x

	TensorFlow

	NumPy

	Vivado

	Icarus Verilog or equivalent simulator
