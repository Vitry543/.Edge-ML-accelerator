# Edge ML Accelerator

This repository contains the RTL implementation, software golden model, TensorFlow Lite validation scripts, and verification assets for a 2×2 edge machine learning accelerator. The design performs matrix multiplication using a 2×2 MAC array, followed by ReLU activation and quantization, and has been verified against both a software golden model and Vivado simulation.

## Project Overview

The project demonstrates a compact and modular edge AI accelerator designed for FPGA-based inference workloads. It includes a DMA feeder for input loading, a parallel MAC array for matrix multiplication, and a ReLU plus quantization stage for final output generation. The design is verified using software co-simulation and RTL testbench simulation.

## Features

- 2×2 matrix multiplication accelerator in RTL.
- DMA feeder for controlled input loading.
- Parallel MAC computation for four output values.
- ReLU and quantization post-processing.
- Software golden model for reference verification.
- TensorFlow Lite FP32 model generation and checking.
- Vivado behavioral simulation support.
- Modular RTL architecture for future scaling.

## Input and Output Used for Verification

### Input Matrices
- A = `[[1, 2], [3, 4]]`
- B = `[[5, 6], [7, 8]]`

### Expected Matrix Multiplication Output
- C = `[[19, 22], [43, 50]]`

### Expected Quantized Output
- Q = `[[9, 11], [21, 25]]`

## Repository Structure

```text
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
```

## Verification Summary

The accelerator was verified using a software golden model, TensorFlow Lite FP32 output, and RTL simulation. The software and RTL results matched exactly for the selected test matrices, confirming correct operation of the complete pipeline.

## Simulation Result

Vivado XSim behavioral simulation produced the following output:

```text
Starting simulation...
C matrix:
c00=19 c01=22
c10=43 c11=50
Q matrix:
q00=9 q01=11
q10=21 q11=25
PASS: matrix multiply correct
```

This confirms that the RTL implementation correctly performs matrix multiplication, ReLU, and quantization.

## Software Validation

The software model generates the golden reference result, and the TensorFlow Lite FP32 model is used to confirm consistency with the RTL output. The verification scripts compare the expected output with the generated output and report a successful match.

## Future Scope

- Scale the design to 4×4, 8×8, and NxN matrix sizes.
- Replace the fixed feeder with AXI-based streaming.
- Support larger neural network layers such as convolution and fully connected layers.
- Add parameterized quantization and precision modes.
- Optimize the design for power, area, and throughput.
- Extend the accelerator for real FPGA deployment and edge AI inference.

## Conclusion

This project demonstrates a complete RTL-based edge ML accelerator with verified software and hardware results. The modular architecture makes the design easy to understand, verify, and extend for future AI and FPGA applications.

## Author

Manikanta Subbarao B
