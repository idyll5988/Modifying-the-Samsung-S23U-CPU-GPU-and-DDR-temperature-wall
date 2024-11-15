# Modifying-the-Samsung-S23U-CPU-GPU-and-DDR-temperature-wall
![2BF51E618FC3EB6C172EFDA7823798B2](https://github.com/user-attachments/assets/efd59925-711a-42df-aa4d-35cb702d4eea)

三星S23U CPU、GPU 和DDR等温度墙

Samsung S23U CPU, GPU and DDR temperature wall

1. **函数定义**

   - `lock_value()`: 用于锁定特定文件的值，接受两个参数：文件路径和要写入的值。
     - 首先检查文件是否存在，如果不存在则跳过。
     - 尝试更改文件的所有者和权限。
     - 读取文件内容，如果内容与目标值相同则跳过。
     - 写入新值到文件中，并更新权限为只读。
     - 记录操作结果。

   - `km1()` 和 `km2()`: 用于日志记录，分别用于成功和失败的消息输出。

2. **全局变量**

   - `SET_TRIP_POINT_TEMP_MAX`: 设定的最大温度阈值，单位可能是毫度摄氏度。

3. **主逻辑**

   - 遍历系统中的热区文件，查找与 CPU、GPU 或 DDR 相关的热区。
   - 对于每个热区，遍历其温度阈值文件，调用 `lock_trip_point()` 函数进行检查和锁定。
  
1. **Function definition**

   - `lock_value()`: Used to lock the value of a specific file, accepts two arguments: the file path and the value to be written.
     - First checks if the file exists, and skips it if it doesn't.
     - Attempts to change the owner and permissions of the file.
     - Read the contents of the file, skip if the contents are the same as the target value.
     - Write the new value to the file and update the permissions to read-only.
     - Record the result of the operation.

   - `km1()` and `km2()`: used for logging, for success and failure message output respectively.

2. **Global Variables**

   - `SET_TRIP_POINT_TEMP_MAX`: The set maximum temperature threshold, in milli-degrees Celsius possible.

3. **Main logic**.

   - Iterates through the hot zone file in the system, looking for hot zones associated with the CPU, GPU, or DDR.
   - For each hot zone, iterates through its temperature threshold file and calls the `lock_trip_point()` function to check and lock it.
