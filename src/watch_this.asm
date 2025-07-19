        ORG 8000H ; load the program at this address

; Initialize time (00:00:00)
START:  MVI B, 00H      ; seconds
        MVI C, 00H      ; minutes
        MVI D, 00H      ; hours

MAIN:   CALL DELAY      ; adjust delay for SIM8085 speed
        CALL INC_TIME
        JMP MAIN

; Increment time registers
INC_TIME:
        INR B           ; increment seconds
        MOV A, B
        CPI 3CH         ; compare with 60
        RNZ            ; return if not 60
        MVI B, 00H      ; reset seconds
        INR C           ; increment minutes
        MOV A, C
        CPI 3CH         ; compare with 60
        RNZ            ; return if not 60
        MVI C, 00H      ; reset minutes
        INR D           ; increment hours
        MOV A, D
        CPI 18H         ; compare with 24
        RNZ            ; return if not 24
        MVI D, 00H      ; reset hours
        RET

; Adjustable delay for SIM8085
DELAY:  MVI E, 02H      ; outer loop (adjust this value)
DELAY1: LXI H, 0FFFFH   ; inner loop
DELAY2: DCX H
        MOV A, H
        ORA L
        JNZ DELAY2
        DCR E
        JNZ DELAY1
        RET

        END
