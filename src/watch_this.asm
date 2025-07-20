        ORG 8000H         ; Load the program starting at memory address 8000H

; -------------------------------
; Initialize time to 00:00:00
; -------------------------------
START:  MVI B, 00H        ; Register B holds seconds → B = 0
        MVI C, 00H        ; Register C holds minutes → C = 0
        MVI D, 00H        ; Register D holds hours   → D = 0

; -------------------------------
; Main program loop
; -------------------------------
MAIN:   CALL DELAY        ; Call the delay routine to wait ~1 second
        CALL INC_TIME     ; Increment time (seconds, minutes, hours)
        JMP MAIN          ; Repeat forever (infinite loop)

; -------------------------------
; Subroutine to increment time
; -------------------------------
INC_TIME:
        INR B             ; Increment seconds (B)
        MOV A, B
        CPI 3CH           ; Compare A with 60 decimal (3CH)
        RNZ               ; Return if seconds ≠ 60
        MVI B, 00H        ; If seconds == 60, reset B to 0
        INR C             ; Increment minutes (C)
        MOV A, C
        CPI 3CH           ; Compare A with 60 decimal
        RNZ               ; Return if minutes ≠ 60
        MVI C, 00H        ; If minutes == 60, reset C to 0
        INR D             ; Increment hours (D)
        MOV A, D
        CPI 18H           ; Compare A with 24 decimal (18H)
        RNZ               ; Return if hours ≠ 24
        MVI D, 00H        ; If hours == 24, reset D to 0
        RET               ; Return from subroutine

; -------------------------------
; Adjustable delay loop
; Approximate 1-second delay
; -------------------------------
DELAY:  MVI E, 02H        ; Outer loop counter → repeat 2 times

DELAY1: LXI H, 0FFFFH     ; Load HL pair with 0xFFFF for inner loop

DELAY2: DCX H             ; Decrement HL
        MOV A, H          ; Move high byte of HL to A
        ORA L             ; Logical OR A with low byte (check if HL == 0000H)
        JNZ DELAY2        ; If HL ≠ 0, repeat inner loop

        DCR E             ; Decrement outer loop counter (E)
        JNZ DELAY1        ; If E ≠ 0, repeat outer loop

        RET               ; Return from delay routine

        END               ; End of program
