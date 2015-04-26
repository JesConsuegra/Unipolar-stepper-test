AllDigital
Define STEP_A_REG = PORTB
Define STEP_A_BIT = 7
Define STEP_B_REG = PORTB
Define STEP_B_BIT = 6
Define STEP_C_REG = PORTB
Define STEP_C_BIT = 5
Define STEP_D_REG = PORTB
Define STEP_D_BIT = 4
Define STEP_MODE = 1

ConfigPin PORTB.1 = Output  'LED

WaitMs 1000
StepHold
WaitMs 1000

loop:
	StepCCW 16, 300
	PORTB.1 = 1
	WaitUs 1000
	StepCW 24, 300
	PORTB.1 = 0
	WaitUs 1000
	Goto loop
