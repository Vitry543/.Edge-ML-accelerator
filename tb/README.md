# Testbench

This folder contains the simulation testbench used to verify the RTL implementation of the 2×2 edge ML accelerator. It includes the top-level testbench, stimulus generation, output checking, and waveform verification required to validate the design before hardware synthesis.

## Contents
- `tb_edge_accel.v`  
  Top-level testbench for the edge ML accelerator.
- Any additional stimulus or helper files used for simulation.

## Purpose
The testbench is used to verify the correct operation of the RTL design under simulation.  
It drives the input matrices, controls the `start` signal, observes the handshake signals, and checks the final outputs against the expected reference values.  
The simulation ensures that the accelerator performs matrix multiplication, ReLU activation, and quantization correctly.

## Verified Signals
- `start`  
  Starts the accelerator operation.
- `feeder_done`  
  Indicates the input matrices have been loaded.
- `mat_done`  
  Indicates matrix multiplication is complete.
- `done`  
  Indicates the final output is ready.
- `c00`, `c01`, `c10`, `c11`  
  Raw matrix multiplication outputs.
- `q00`, `q01`, `q10`, `q11`  
  Final quantized outputs.

## Test Inputs
- A = `[[1, 2], [3, 4]]`
- B = `[[5, 6], [7, 8]]`

## Expected Outputs
- C = `[[19, 22], [43, 50]]`
- Q = `[[9, 11], [21, 25]]`

## How to Run
1. Open the Vivado project or your simulator project.
2. Add the RTL files and this testbench.
3. Run behavioral simulation.
4. Check the console output and waveform for correct results.

## Verification Result
The testbench confirms that the RTL accelerator produces the same results as the software golden model.  
The complete pipeline operates correctly, and the final outputs match the expected values exactly.
<img width="1069" height="688" alt="Screenshot 2026-04-21 140215" src="https://github.com/user-attachments/assets/8458854e-d887-4968-a3a3-7e62b18c4ec6" />


## Notes
- The testbench should be self-checking if possible.
- Add waveform screenshots in the report for `start`, `feeder_done`, `mat_done`, and `done`.
- Add console output showing PASS status.

## Author
Manikanta Subbarao B
