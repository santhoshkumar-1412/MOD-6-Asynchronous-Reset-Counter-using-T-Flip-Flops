
# MOD-6 Counter using T Flip-Flops | Verilog HDL

<p align="center">
  <b>RTL Design | Digital Electronics | Functional Verification</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Design-MOD--6%20Counter-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Simulation-Synopsys%20VCS-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Debugging-Synopsys%20Verdi-purple?style=for-the-badge" />
</p>

## 1. Project Overview

This project presents the RTL design and functional verification of a 3-bit MOD-6 Asynchronous Reset Counter using Verilog Hardware Description Language (HDL).

The counter is designed using three T Flip-Flops (TFFs) and operates on the positive edge of the clock signal.

The counter generates six unique counting states, ranging from 000 to 101. When the count reaches 110, the asynchronous reset logic is activated, forcing the counter output back to 000.

The design is simulated using Synopsys VCS, and waveform analysis is performed using Synopsys Verdi.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Design Name | MOD-6 Counter |
| Design Type | Sequential Circuit |
| Counter Type | Asynchronous Reset Counter |
| Counter Modulus | 6 |
| Number of Flip-Flops | 3 |
| Flip-Flop Type | T Flip-Flop |
| Clock Edge | Positive Edge |
| Reset Type | Active-High Asynchronous Reset |
| Input Signals | Clock, Reset |
| Output Signals | 3-bit Count |
| HDL | Verilog |
| Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | FSDB |

## 3. Design Methodology

### 3.1 T Flip-Flop Operation

The T Flip-Flop changes its output state whenever the T input is HIGH at the active clock edge.

**Characteristic Equation:**

```text
Q(next) = T XOR Q
```

| T Input | Operation |
|---|---|
| 0 | Hold previous state |
| 1 | Toggle output state |

### 3.2 T Flip-Flop RTL Implementation

The T Flip-Flop is designed with an active-high asynchronous reset.

```verilog
module tff (
    output reg q,
    input t, clk, rst
);

always @(posedge clk or posedge rst)
begin
    if (rst)
        q <= 1'b0;
    else if (t)
        q <= ~q;
end

endmodule
```

### 3.3 MOD-6 Counter Architecture

The MOD-6 counter consists of three T Flip-Flops.

**Toggle Equations:**

```text
T0 = 1
T1 = Q0
T2 = Q1 AND Q0
```

**Asynchronous Reset Equation:**

```text
rst_cnt = rst OR (Q2 AND Q1)
```

The asynchronous reset is activated when Q2 and Q1 are both HIGH.

Therefore, when the counter reaches state 110, the reset signal becomes HIGH and clears all three flip-flops to 000.

### 3.4 Counter State Sequence

The MOD-6 counter follows the sequence:

| Clock Cycle | Q2 | Q1 | Q0 | Decimal Count |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 1 | 1 |
| 2 | 0 | 1 | 0 | 2 |
| 3 | 0 | 1 | 1 | 3 |
| 4 | 1 | 0 | 0 | 4 |
| 5 | 1 | 0 | 1 | 5 |
| 6 | 1 | 1 | 0 | Reset condition |
| 7 | 0 | 0 | 0 | Counter restarts |

The counter continuously repeats this sequence.

## 4. RTL Module Architecture

The project consists of three main modules:

| Module | Functionality |
|---|---|
| `tff` | Implements a T Flip-Flop with asynchronous reset |
| `mod6_counter` | Implements the 3-bit MOD-6 counter using three T Flip-Flops |
| `mod6_counter_tb` | Testbench for functional verification |

### 4.1 Counter Block Diagram

```text
                 Clock
                   |
       +-----------+-----------+
       |           |           |
       v           v           v
    +------+    +------+    +------+
    | TFF0 |    | TFF1 |    | TFF2 |
    | T=1  |    | T=Q0 |    |T=Q1Q0|
    +------+    +------+    +------+
       |           |           |
       v           v           v
      Q0          Q1          Q2
       |           |           |
       +-----------+-----------+
                   |
                   v
             Reset Detection
                Q2 AND Q1
                   |
                   v
                rst_cnt
                   |
          Asynchronous Reset
```

## 5. Repository Structure

```text
mod-6-counter/
│
├── mod6_counter.v
│   └── T Flip-Flop and MOD-6 counter RTL
│
├── mod6_counter_tb.v
│   └── Functional verification testbench
│
├── screenshots/
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

## 6. Functional Verification

A Verilog testbench is developed to verify the functionality of the MOD-6 counter.

The testbench generates a clock signal with a 10 ns time period and applies an initial active-high reset.

After 10 ns, the reset is deasserted, allowing the counter to start counting.

The simulation runs for 160 ns after reset deassertion.

### 6.1 Testbench Clock Generation

```verilog
always #5 clk = ~clk;
```

**Clock Period:**

```text
Tclk = 5 ns + 5 ns = 10 ns
```

**Clock Frequency:**

```text
f = 1 / Tclk = 100 MHz
```

### 6.2 Reset Operation

```verilog
initial
begin
    clk = 0;
    rst = 1;
    #10 rst = 0;
    #160 $finish;
end
```

The reset is initially asserted and deasserted after 10 ns.

### 6.3 Expected Simulation Output

```text
Time=0   Reset=1 Count=000(0)
Time=10  Reset=0 Count=000(0)
Time=20  Reset=0 Count=001(1)
Time=30  Reset=0 Count=010(2)
Time=40  Reset=0 Count=011(3)
Time=50  Reset=0 Count=100(4)
Time=60  Reset=0 Count=101(5)
Time=70  Reset=0 Count=000(0)
Time=80  Reset=0 Count=001(1)
```

The counter continues repeating the sequence from 000 to 101.

## 7. Simulation Environment

The design is simulated using Synopsys VCS and analyzed using Synopsys Verdi.

### 7.1 VCS Compilation

```bash
vcs -full64 -debug_access+all \
mod6_counter.v \
mod6_counter_tb.v \
-o simv
```

### 7.2 Execute Simulation

```bash
./simv
```

### 7.3 FSDB Waveform Generation

To generate an FSDB waveform, add the following commands inside the testbench:

```verilog
initial
begin
    $fsdbDumpfile("mod6_counter.fsdb");
    $fsdbDumpvars(0, mod6_counter_tb);
end
```

Ensure that Verdi FSDB PLI support is enabled during VCS compilation.

### 7.4 Open Waveform in Synopsys Verdi

```bash
verdi -ssf mod6_counter.fsdb &
```

The generated waveform can be inspected using the Verdi waveform viewer.

## 8. Waveform Analysis

The simulation waveform is analyzed using Synopsys Verdi.

The following signals are observed:

| Signal | Width | Description |
|---|---|---|
| `clk` | 1 bit | Clock input |
| `rst` | 1 bit | External asynchronous reset |
| `q[2:0]` | 3 bits | Counter output |
| `rst_cnt` | 1 bit | Internal reset condition |

**Observations:**

- The counter operates on the positive edge of the clock.
- The initial reset clears all flip-flop outputs to 000.
- The counter increments from 000 to 101.
- When the count reaches 110, the internal asynchronous reset is activated.
- The counter returns to 000 and starts counting again.
- The waveform confirms the repeating MOD-6 counting sequence.

### Simulation Waveform

![MOD-6 Counter Verdi Waveform](screenshots/verdi_waveform.png)

## 9. Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design implementation |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| FSDB | Simulation waveform database |
| Git | Version control |
| GitHub | Source code hosting and documentation |

## 10. Key Learning Outcomes

- Sequential circuit design using Verilog HDL.
- T Flip-Flop implementation.
- Positive-edge-triggered sequential logic.
- Active-high asynchronous reset.
- Binary counter architecture.
- MOD-N counter design.
- Reset detection using combinational logic.
- RTL simulation using Synopsys VCS.
- Waveform analysis using Synopsys Verdi.
- Functional verification of sequential circuits.

## 11. Future Enhancements

- Design MOD-10 and MOD-16 counters.
- Implement synchronous reset counters.
- Design up/down counters.
- Compare T Flip-Flop and JK Flip-Flop implementations.
- Perform RTL synthesis and area analysis.
- Analyze timing and propagation delays.
- Implement parameterized MOD-N counters.

## 12. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Design | VLSI Engineering

- GitHub: [Your GitHub Profile](https://github.com/your-username)
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/your-profile)

## 13. License

This project is intended for educational and learning purposes.

You are welcome to explore, modify and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated with Synopsys VCS | Debugged with Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider starring the repository!
</p>

---

## GitHub Topics

verilog · mod6-counter · t-flip-flop · asynchronous-counter · digital-design · rtl-design · vlsi · sequential-circuits · synopsys-vcs · synopsys-verdi · fsdb · rtl-verification
