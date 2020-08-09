# SCNU FPGA开发板测试项目

## 简介

- 适用硬件：SCNU FPGA开发板（Cyclone IV EP4CE6E22C8N，EPCS4N，六位共阳数码管、8个LED、8个按键、33空闲I/O）
- 功能说明：BUT1控制8个LED的亮/灭切换，BUT2控制数码管显示数字递增的开始/停止，BUT8为复位按键。

## 文件结构

```
scnu-fpga-board-testing
|-- resources               存放 SCNU FPG实验板相关资料
|-- source                  存放 Verilog 设计文件
|   |-- lib                     各个功能模块设计文件
|   |-- testbench               各个功能模块仿真测试文件
|   |-- board_test.v            顶层设计文件
|-- projects                项目文件夹
    |-- modelsim-testbench      ModelSim SE-64 10.5 仿真项目文件夹
    |-- quartusii-board_test    Quartus II 13.0 项目文件夹
```

## 使用方法

1. 克隆或下载本项目
2. 若需要查看仿真结果：
    - 打开 ModelSim
    - 上方工具栏选择 File - Open 弹出文件选择框
    - 在下方文件类型修改为`Project Files (*.mpf)`
    - 找到本项目的 `scnu-fpga-board-testing/projects/modelsim-testbench` 文件夹
    - 选择 `testbench.mpf` 文件，打开即可
3. 打开 Quartus II 项目：
    - 在文件资源管理器进入 `scnu-fpga-board-testing/projects/quartusii-board_test` 文件夹，双击 `board_test.qpf` 即可打开项目。

如果版本不兼容或者无法直接从文件夹打开项目，可以手动添加源文件建立项目。