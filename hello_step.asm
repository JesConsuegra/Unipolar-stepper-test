; Compiled with: PIC Simulator IDE v7.37
; Microcontroller model: PIC16F84A
; Clock frequency: 4.0MHz
;
	R0L EQU 0x00C
	R0H EQU 0x00D
	R4L EQU 0x014
	R4H EQU 0x015
	R5L EQU 0x016
	R0HL EQU 0x00C
	R4HL EQU 0x014
	LONG_0 EQU 0x017
	LONG_1 EQU 0x018
	LONG_2 EQU 0x019
	LONG_3 EQU 0x01A
	LONG2_0 EQU 0x01B
	LONG2_1 EQU 0x01C
	LONG2_2 EQU 0x01D
	LONG2_3 EQU 0x01E
	LONG1 EQU 0x017
	LONG2 EQU 0x01B
	REGSTEP EQU 0x00E
	ORG 0x0000
	BCF PCLATH,4
	BCF PCLATH,3
	GOTO L0002
	ORG 0x0004
	RETFIE
; User code start
L0002:
; 1: AllDigital
; 2: Define STEP_A_REG = PORTB
; 3: Define STEP_A_BIT = 7
; 4: Define STEP_B_REG = PORTB
; 5: Define STEP_B_BIT = 6
; 6: Define STEP_C_REG = PORTB
; 7: Define STEP_C_BIT = 5
; 8: Define STEP_D_REG = PORTB
; 9: Define STEP_D_BIT = 4
; 10: Define STEP_MODE = 1
; 11: 
; 12: ConfigPin PORTB.1 = Output  'LED
	BSF STATUS,RP0
	BCF TRISB,1
	BCF STATUS,RP0
; 13: 
; 14: WaitMs 1000
	MOVLW 0xE8
	MOVWF R0L
	MOVLW 0x03
	MOVWF R0H
	CALL W001
; 15: StepHold
	BSF PORTB,7
	BSF PORTB,6
	BCF PORTB,5
	BCF PORTB,4
	BSF STATUS,RP0
	BCF TRISB,7
	BCF TRISB,6
	BCF TRISB,5
	BCF TRISB,4
	BCF STATUS,RP0
	CLRF REGSTEP
; 16: WaitMs 1000
	MOVLW 0xE8
	MOVWF R0L
	MOVLW 0x03
	MOVWF R0H
	CALL W001
; 17: 
; 18: loop:
L0001:
; 19: StepCCW 16, 300
	MOVLW 0x10
	MOVWF R5L
	MOVF R5L,F
	BTFSC STATUS,Z
	GOTO L0004
L0003:
	CALL ST02
	MOVLW 0x62
	MOVWF R4L
	CALL DL01
	DECFSZ R5L,F
	GOTO L0003
L0004:
; 20: PORTB.1 = 1
	BSF PORTB,1
; 21: WaitUs 1000
	MOVLW 0x62
	MOVWF R4L
	MOVLW 0x00
	MOVWF R4H
	CALL DL02
; 22: StepCW 24, 300
	MOVLW 0x18
	MOVWF R5L
	MOVF R5L,F
	BTFSC STATUS,Z
	GOTO L0006
L0005:
	CALL ST01
	MOVLW 0x62
	MOVWF R4L
	CALL DL01
	DECFSZ R5L,F
	GOTO L0005
L0006:
; 23: PORTB.1 = 0
	BCF PORTB,1
; 24: WaitUs 1000
	MOVLW 0x62
	MOVWF R4L
	MOVLW 0x00
	MOVWF R4H
	CALL DL02
; 25: Goto loop
	GOTO L0001
; End of user code
L0007:	GOTO L0007
;
;
; Delay Routine Byte
; minimal routine execution time: 8�s
; routine execution time step: 3�s
; maximal routine execution time: 770�s
DL01:
	DECFSZ R4L,F
	GOTO DL01
	RETURN
; Delay Routine Word
; minimal routine execution time: 15�s
; routine execution time step: 10�s
; maximal routine execution time: 655365�s
DL02:
	MOVLW 0x01
	SUBWF R4L,F
	CLRW
	BTFSS STATUS,C
	ADDLW 0x01
	SUBWF R4H,F
	BTFSS STATUS,C
	RETURN
	GOTO DL02
; Waitms Routine
W001:	MOVLW 0x01
	SUBWF R0L,F
	CLRW
	BTFSS STATUS,C
	ADDLW 0x01
	SUBWF R0H,F
	BTFSS STATUS,C
	RETURN
	MOVLW 0x61
	MOVWF R4L
	MOVLW 0x00
	MOVWF R4H
	CALL DL02
	GOTO W001
;
;
; Stepper Routine
ST01:	INCF REGSTEP,F
	GOTO ST03
ST02:	DECF REGSTEP,F
ST03:
	BTFSC REGSTEP,1
	GOTO ST04
	BTFSC REGSTEP,0
	GOTO ST21
	GOTO ST20
ST04:
	BTFSC REGSTEP,0
	GOTO ST23
	GOTO ST22
ST20:
	BSF PORTB,7
	BSF PORTB,6
	BCF PORTB,5
	BCF PORTB,4
	RETURN
ST21:
	BCF PORTB,7
	BSF PORTB,6
	BSF PORTB,5
	BCF PORTB,4
	RETURN
ST22:
	BCF PORTB,7
	BCF PORTB,6
	BSF PORTB,5
	BSF PORTB,4
	RETURN
ST23:
	BSF PORTB,7
	BCF PORTB,6
	BCF PORTB,5
	BSF PORTB,4
	RETURN
;
;
; End of listing
	END
