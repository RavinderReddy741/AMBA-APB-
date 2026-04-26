# AMBA APB Protocol Master-Slave Interface Verification

## Project Overview
Verification of an APB-based master-slave interface using SystemVerilog and UVM methodology.
Covers FSM-based protocol state management, read/write correctness, and edge case validation
across IDLE, SETUP, and ENABLE phases per the AMBA APB Specification.

---

## Tools & Technologies
| Category | Details |
|---|---|
| Language | SystemVerilog, Verilog |
| Methodology | UVM (Universal Verification Methodology) |
| Simulation | Synopsys VCS |
| Waveform Debug | Verdi |
| FPGA Prototyping | Xilinx Vivado |
| Protocol Spec | AMBA APB Specification |

---

## What Is Verified
- Moore and Mealy FSM modeling for IDLE → SETUP → ENABLE state transitions
- Write operations: address decoding, data capture, psel/penable/pwrite sequencing
- Read operations: data return, pready handshake, signal timing
- Protocol edge cases and invalid conditions
- Constrained-random UVM testbench with functional coverage analysis
- Waveform-level debug using Verdi for root-cause analysis of failures

---

## Folder Structure

AMBA-APB/
├── AMBA(APB) Xilink/                # APB protocol implementation on Xilinx FPGA (Vivado)
├── APB(Synopsys VCS)/               # Basic APB protocol verification — VCS simulation
├── APB_Master_Mealy(Synopsys VCS)/  # Mealy FSM-based APB master implementation
├── APB_Master_Slave(Synopsys VCS)/  # Master-Slave interface verification
├── APB_MS(Synopsys VCS)/            # Integrated Master-Slave full verification
└── README.md

## UVM Testbench (EDA Playground)
Full UVM-based APB testbench 
Run on EDA Playground →
https://www.edaplayground.com/x/Qfp4

## Key Verification Concepts Demonstrated
- UVM agent, driver, monitor, scoreboard, coverage collector architecture
- Constrained-random sequence generation for APB transactions
- Functional coverage groups for state transitions and data paths
- Protocol compliance checking via SystemVerilog Assertions (SVA)


## Author
**Ravinder Reddy Donapati**
Design Verification Engineer | Bitsilica, Hyderabad
LinkedIn: linkedin.com/in/ravinder-reddy-963a09226
