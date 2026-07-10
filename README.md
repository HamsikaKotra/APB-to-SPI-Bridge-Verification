# APB-to-SPI Protocol Bridge Verification

This project features the design and comprehensive functional verification of a high-performance APB-to-SPI Protocol Bridge. The bridge acts as an intermediary peripheral interface, translating AMBA APB (Advanced Peripheral Bus) host system commands into SPI (Serial Peripheral Interface) protocols for external serial communication. 

---

## Architecture Description
The bridge architecture is structured into four distinct functional blocks designed to optimize throughput and handle hardware constraints seamlessly:

*   **APB Slave Interface:** Handles bus transactions, address decoding, and control signaling from the host controller.
*   **Configuration & Status Registers (CSRs):** Manages operational parameters, programmable SPI settings, and status flags.
*   **Tx/Rx FIFOs:** Provides synchronized data buffering to manage rate differences and clock domain crossings (CDC) between the host system bus and peripheral serial interface without data loss.
*   **SPI Master Controller:** Handles the final serialization of data, driving external SPI configurations (supporting standard CPOL and CPHA modes).

---

## Key Features & Verification Methodology
*   **Layered Testbench Architecture:** Built a modular, scalable verification environment separating concerns across a generator, driver, monitor, and scoreboard using Virtual Interfaces.
*   **Constrained Random Verification (CRV):** Implemented transaction-based verification to automate test-case generation and maximize corner-case coverage.
*   **Automated Self-Checking Scoreboard:** Developed a real-time data integrity tracker and reference model to dynamically evaluate the correctness of the DUT outputs.
*   **100% Functional & Code Coverage:** Achieved complete coverage metrics across all SPI operational configurations.

**Languages Used:** SystemVerilog, Verilog  
**EDA Tools & OS Platforms:** ModelSim, Quartus Prime Lite (Synthesizability Validation)

---

## Simulation Waveforms

### APB Interface Simulation
![APB Interface Waveform](apb_interface%20wave.png)

### Shift Register Simulation
![Shift Register Waveform](shift%20register%20wave.png)

### Baud Generator Simulation
![Baud Gen Waveform](baud_gen%20wave.png)
