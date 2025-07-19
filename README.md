    A simple Digital Watch written for the 8085 microprocessor


# 🕒 Digital Clock for 8085 Microprocessor

A simple digital clock written in assembly language for the **Intel 8085** microprocessor. The clock simulates time counting from `00:00:00` (hours:minutes:seconds), with real-time progression simulated using software delays.

---

## 🧠 About the 8085

The **Intel 8085** is an 8-bit microprocessor based on the Von Neumann architecture, developed by Intel in the 1970s. It includes:

- A 16-bit address bus (64 KB memory access)
- A 8-bit data bus
- 7 general-purpose 8-bit registers
- Stack pointer, program counter, and several flags
- No built-in clock or timers (must be implemented in software)

---

## 💻 Programming in 8085

8085 assembly is a low-level programming language where the programmer has direct control over hardware using:
- **General-purpose registers**: `B`, `C`, `D`, `E`, `H`, `L`, and the **Accumulator** `A`
- **Register pairs**: `BC`, `DE`, and `HL` for 16-bit operations
- **Arithmetic and logic instructions**: such as `INR`, `DCR`, `ADD`, `MOV`, `CPI`, etc.
- **Branching instructions**: such as `JMP`, `CALL`, `RET`, `RNZ`, `JC`, etc.
- **Delay loops**: since 8085 lacks timers, nested loops are used to simulate delays

This clock uses a **pure software-based delay** and **binary counters** (not BCD), and increments registers manually to simulate time.

---

## 🛠️ Project Structure and Approach

- The clock is initialized to `00:00:00`
- Registers are used to hold time:
  - `B` = Seconds
  - `C` = Minutes
  - `D` = Hours
- Time is incremented using:
  - `INR` to increment seconds
  - When seconds reach 60 (`3CH`), they are reset and minutes are incremented
  - Similarly, when minutes reach 60, they are reset and hours are incremented
  - When hours reach 24 (`18H`), they are reset to 0

- A nested loop `DELAY` subroutine is used to simulate 1-second intervals (tunable for simulator speed)

---

## ▶️ Running the Project

### Requirements
- Any 8085 simulator (such as):
  - [https://sim8085.com](https://sim8085.com)
  - [https://sourceforge.net/projects/gnusim8085/](https://sourceforge.net/projects/gnusim8085/)

### Steps
1. Open the simulator
2. Load the file `src/watch_this.asm` (or paste it manually)
3. Assemble and run the program
4. Monitor the values of registers `D:C:B` to read the current time

---

## 🔍 Example Output

When running, you’ll observe the register values:

| Register | Meaning |
|----------|---------|
| `D`      | Hours   |
| `C`      | Minutes |
| `B`      | Seconds |

E.g., if:
```

D = 02H
C = 15H
B = 43H

````
→ The time is `02:15:43`

---

## 🧪 How Delay Works

```asm
MVI E, 02H         ; Outer loop
LXI H, 0FFFFH      ; Inner loop value
DELAY2: DCX H      ; Count down HL
        ORA L      ; Check if HL == 0
        JNZ DELAY2
        DCR E      ; Outer loop
        JNZ DELAY1
````

This is a nested loop where each level adds delay, acting like a crude timer. You can tune `MVI E, XXH` for faster or slower clocks based on the simulator.

---

## 📁 File Structure

```
.
├── src/
│   └── watch_this.asm    # Main 8085 assembly source code
└── README.md             # Project documentation
```

---

## 8085 vs 8086: Approach to Building a Digital Clock

The approach to building a digital clock differs significantly between the 8085 and 8086 microprocessors due to the availability of system-level support in 8086.

### In 8085

The Intel 8085 has no built-in operating system or system services. Therefore:

* Time is manually tracked using general-purpose registers (`B`, `C`, `D`) to store seconds, minutes, and hours.
* Software delay loops are used to simulate a 1-second interval.
* Overflow logic (like resetting seconds after 59 to 00) is handled explicitly in assembly.
* All timekeeping logic is coded from scratch, making the program fully standalone and hardware-tied.

### In 8086

The Intel 8086 is often used with an operating system like MS-DOS or BIOS firmware, which provides useful system interrupts. In this case:

* Time can be fetched directly from the system clock using `INT 21H` (with `AH = 2CH`).
* After the interrupt call, registers like `CH`, `CL`, and `DH` contain the hour, minute, and second.
* There's no need for manual time tracking or delays; the OS provides the real-time values.
* Output to the screen can also be handled by BIOS/DOS interrupts like `INT 10H`.

---

## ✅ Features

* Simple and clean structure
* No reliance on BCD or complex math
* Can run on any basic 8085 emulator
* Easily modifiable for 12-hour or 24-hour format

---

## 📌 To Do

* [ ] Add BCD support for display use
* [ ] Add memory-mapped output for seven-segment simulation

---
