import tensorflow as tf
import numpy as np
import os

# Check if fixed model exists
model_path = "sw/model_int8_fixed.tflite"
if not os.path.exists(model_path):
    print(f"❌ Model not found: {model_path}")
    print("Run: python sw\\create_int8_model.py first")
    exit(1)

interpreter = tf.lite.Interpreter(model_path=model_path)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

print("Input details:", input_details)
print("Output details:", output_details)

# SAFER index access
input_index = input_details[0]['index']  # Direct access, no ["index"]
output_index = output_details[0]['index']

print(f"Input index: {input_index}")
print(f"Output index: {output_index}")

# RTL exact input: A=[[1,2],[3,4]] flattened
inp = np.array([1,2,3,4], dtype=np.int8).reshape(1,4)
print("Input data shape:", inp.shape, "dtype:", inp.dtype)

interpreter.set_tensor(input_index, inp)
interpreter.invoke()
out = interpreter.get_tensor(output_index)

print("\n✅ TFLite quantized output:", out.flatten())
print("Expected RTL C flattened: [19 22 43 50]")