import tensorflow as tf
import numpy as np
import os

# Fixed B matrix from your RTL feeder
B_weights = tf.constant([[5., 6.], [7., 8.]], dtype=tf.float32)

@tf.function(input_signature=[tf.TensorSpec(shape=[1,4], dtype=tf.float32)])
def matrix_multiply(flat_A):
    A = tf.reshape(flat_A, [2,2])           # [1,4] → [2,2]
    C = tf.matmul(A, B_weights)             # Exact 2x2 matrix multiply
    return tf.reshape(C, [1,4])             # [2,2] → [1,4] flattened

# Get concrete function
concrete_func = matrix_multiply.get_concrete_function()

# Representative dataset for INT8 calibration (100 samples around your test data)
def representative_dataset():
    for _ in range(100):
        # Vary A matrix slightly around [1,2,3,4]
        noise = np.random.uniform(-0.5, 0.5, (4,)).astype(np.float32)
        sample = np.array([1,2,3,4], dtype=np.float32) + noise
        yield [sample.reshape(1,4)]

# Convert with INT8 quantization
converter = tf.lite.TFLiteConverter.from_concrete_functions([concrete_func])
converter.optimizations = [tf.lite.Optimize.DEFAULT]
converter.representative_dataset = representative_dataset
converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
converter.inference_input_type = tf.int8  
converter.inference_output_type = tf.int8

tflite_model = converter.convert()

os.makedirs("sw", exist_ok=True)
with open("sw/model_int8_fixed.tflite", "wb") as f:
    f.write(tflite_model)

print("✅ Created: sw/model_int8_fixed.tflite (Matrix Multiply + INT8)")