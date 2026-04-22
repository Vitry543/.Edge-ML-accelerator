import numpy as np

A = np.array([[1, 2],
              [3, 4]], dtype=np.int8)

B = np.array([[5, 6],
              [7, 8]], dtype=np.int8)

C = A.astype(np.int32) @ B.astype(np.int32)
Q = np.clip(np.maximum(C, 0) >> 1, -128, 127).astype(np.int8)

print("A =")
print(A)
print("B =")
print(B)
print("C =")
print(C)
print("Q =")
print(Q)