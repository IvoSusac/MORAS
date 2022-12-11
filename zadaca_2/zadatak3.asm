// i je counter
@i
M = 0

(LOOP_START)
	@i
	A = M
	D = M
	
	@max
	M = D
	
	(INNER)
	
	@i
	D = M
	
	@4
	D = A - D
	
	@LOOP_END
	D; JEQ
	
	@max
	D = M
	
	@i
	M = M + 1
	A = M
	D = M - D
	
	@LOOP_START
	D; JGT
	
	@INNER
	0; JMP

(LOOP_END)

@max
D = M

@R5
M = D

(END)
@END
0; JMP