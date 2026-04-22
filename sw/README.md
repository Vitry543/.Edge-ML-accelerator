# Software Model and Verification

This folder contains the Python-based software model, TensorFlow Lite FP32 model generation script, and verification scripts used to validate the RTL implementation of the 2×2 edge ML accelerator.

## Contents
- `golden_model.py`  
  Generates the reference matrix multiplication and quantized output.
- `create_fp32_model.py`  
  Builds the TensorFlow Lite FP32 model from the software reference.
- `tflite_check_1.py`  
  Compares the TFLite output with the expected RTL output.
- `model_fp32.tflite`  
  Generated TensorFlow Lite FP32 model.

## Purpose
The software model serves as the golden reference for RTL verification.  
It computes the expected matrix multiplication output and quantized output for the input matrices used in the hardware testbench.  
The TFLite model is used to confirm that the software baseline and RTL output match exactly.

## Input Matrices
- A = `[[1, 2], [3, 4]]`
- B = `[[5, 6], [7, 8]]`

## Expected Outputs
- C = `[[19, 22], [43, 50]]`
- Q = `[[9, 11], [21, 25]]`

## How to Run
### 1. Generate the golden reference
```bash
python sw/golden_model.py
```

### 2. Create the FP32 TensorFlow Lite model
```bash
python sw/create_fp32_model.py
```
<img width="1919" height="599" alt="1(2)" src="https://github.com/user-attachments/assets/ae2369e7-d627-45a6-afc7-a004b8ad1854" />

### 3. Verify TFLite output
```bash
python sw/tflite_check_1.py
```
<img width="1891" height="511" alt="2" src="https://github.com/user-attachments/assets/dc7ea318-349b-4dd0-9ffc-aacb22424b9f" />


## Verification Result
The software model, TensorFlow Lite model, and RTL simulation produce matching outputs for the selected test matrices.  
This confirms correct software-RTL co-simulation and validates the accelerator pipeline.


## Notes
- TensorFlow warnings related to oneDNN or interpreter deprecation do not affect the correctness of the results.
- The important verification statement is the exact match between expected and observed outputs.

## Author
Manikanta Subbarao B
