import tensorflow as tf
import numpy as np

interpreter = tf.lite.Interpreter(model_path="sw/model_fp32.tflite")
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()[0]
output_details = interpreter.get_output_details()[0]

inp = np.array([1,2,3,4], dtype=np.float32).reshape(1,4)

interpreter.set_tensor(input_details['index'], inp)
interpreter.invoke()
out = interpreter.get_tensor(output_details['index'])[0]

print("TFLite FP32 output:", out.astype(np.int32))
print("Expected RTL C:      [19 22 43 50]")
print("✅ MATCH:", np.array_equal(out.astype(np.int32), [19,22,43,50]))