# Collum search engine
A high-performance columnar data lookup and filtering engine written in **Zig** using native `@Vector` SIMD vectorization.
Proven to be 50x faster then stock python
---

## ⚡ Overview

Built for fast columnar filtering over large database tables and dataset files.

- **Columnar Storage:** Filters numeric and text data columns in contiguous memory.
- **Hardware SIMD Acceleration:** Uses vector instructions to scan billions of rows per second.
- **Fast Table Search:** Finds matching rows and totals up filtered data in milliseconds.

---

## 🚀 How to Use

### 1. Build Shared Library
```bash
make
```

### 2. Table Lookup Example
```python
import ctypes
import numpy as np

lib = ctypes.CDLL("./libcolumnar.so")

# tablecollum
table_column = np.array([95000, 120000, 45000, 150000, 80000, 200000], dtype=np.uint64)
ptr = table_column.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64))

# compare >
matching_count = ctypes.c_size_t(0)
sum_total = lib.search_column_gt(ptr, len(table_column), 100000, ctypes.byref(matching_count))

print(f"Matching Rows : {matching_count.value}")
print(f"Column Total  : {sum_total}")
```
