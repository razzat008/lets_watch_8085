ORG 8000H         ; Load the program starting at memory address 8000H

; -------------------------------
; Initialize time to 00:00:00 in BCD
; -------------------------------
START:  MVI B, 00H        ; Register B holds seconds → B = 00H (BCD)
        MVI C, 00H        ; Register C holds minutes → C = 00H (BCD)
        MVI D, 00H        ; Register D holds hours   → D = 00H (BCD)

; -------------------------------
; Main program loop
; -------------------------------
MAIN:   CALL DELAY        ; Call the delay routine to wait ~1 second
        CALL INC_TIME     ; Increment time (seconds, minutes, hours) in BCD
        JMP MAIN          ; Repeat forever (infinite loop)

; -------------------------------
; Subroutine to increment time in BCD
; -------------------------------
INC_TIME:
        ; Increment seconds (B)
        MOV A, B          ; Load seconds into A
        ADI 01H           ; Add 1 to seconds (binary addition)
        DAA               ; Convert to BCD (Decimal Adjust Accumulator)
        MOV B, A          ; Store back to B
        CPI 60H           ; Compare A with 60 BCD (60H)
        RNZ               ; Return if seconds ≠ 60 BCD
        MVI B, 00H        ; If seconds == 60 BCD, reset B to 00H
        ; Increment minutes (C)
        MOV A, C          ; Load minutes into A
        ADI 01H           ; Add 1 to minutes (binary addition)
        DAA               ; Convert to BCD
        MOV C, A          ; Store back to C
        CPI 60H           ; Compare A with 60 BCD
        RNZ               ; Return if minutes ≠ 60 BCD
        MVI C, 00H        ; If minutes == 60 BCD, reset C to 00H
        ; Increment hours (D)
        MOV A, D          ; Load hours into A
        ADI 01H           ; Add 1 to hours (binary addition)
        DAA               ; Convert to BCD
        MOV D, A          ; Store back to D
        CPI 24H           ; Compare A with 24 BCD (24H)
        RNZ               ; Return if hours ≠ 24 BCD
        MVI D, 00H        ; If hours == 24 BCD, reset D to 00H
        RET               ; Return from subroutine

; -------------------------------
; Adjustable delay loop
; Approximate 1-second delay
; -------------------------------
DELAY:  MVI E, 01H        ; Outer loop counter → repeat 2 times

DELAY1: LXI H, 0FFFFH     ; Load HL pair with 0xFFFF for inner loop

DELAY2: DCX H             ; Decrement HL
        MOV A, H          ; Move high byte of HL to A
        ORA L             ; Logical OR A with low byte (check if HL == 0000H)
        JNZ DELAY2        ; If HL ≠ 0, repeat inner loop

        DCR E             ; Decrement outer loop counter (E)
        JNZ DELAY1        ; If E ≠ 0, repeat outer loop

        RET               ; Return from delay routine

        END               ; End of program
