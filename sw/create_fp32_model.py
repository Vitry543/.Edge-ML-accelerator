import tensorflow as tf
import numpy as np
import os

B_weights = tf.constant([[5.,6],[7.,8]])

@tf.function(input_signature=[tf.TensorSpec(shape=[1,4], dtype=tf.float32)])
def matrix_multiply(flat_A):
    A = tf.reshape(flat_A, [2,2])
    C = tf.matmul(A, B_weights)
    return tf.reshape(C, [1,4])

concrete_func = matrix_multiply.get_concrete_function()
converter = tf.lite.TFLiteConverter.from_concrete_functions([concrete_func])
tflite_model = converter.convert()  # NO quantization

with open("sw/model_fp32.tflite", "wb") as f:
    f.write(tflite_model)
print("✅ Created FP32 model: sw/model_fp32.tflite")