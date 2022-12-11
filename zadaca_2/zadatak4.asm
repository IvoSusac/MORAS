@SCREEN
D = A

@addr
M = D

@0
D = A

@r
M = D

@8
D = A

@c
M = D

@1
D = A

@d
M = D

@1
D = A

@SHIFT
M = D

@16
D = A

@dg
M = D

@i
M = 0

(LOOP_1)
	@128
	D = A
	
	@i
	D = M - D
	
	@END_1
	D; JGE
	
	@dg
	D = M
	
	@CONTINUE
	D; JGT
	
	@1
	D = A
	
	@d
	M = D
	
	@16
	D = A
	
	@dg
	M = D
	
	@SHIFT
	M = M + 1
	
	(CONTINUE)
	
	@32
	D = A
	
	@SHIFT
	D = M + D
	
	@addr
	M = M + D
	
	@0
	D = A
	
	@SHIFT
	M = D
	
	@d
	D = M
	
	@addr
	A = M
	M = D
	
	@d
	M = M + D
	D = M
	
	@i
	M = M + 1
	
	@dg
	M = M - 1
	
	@LOOP_1
	0; JMP
	
(END_1)

@SCREEN
D = A

@addr
M = D

@j
M = 0

(LOOP_2)
	@129
	D = A
	
	@j
	D = M - D
	
	@END_2
	D; JGE
	
	@0
	D = !A
	
	@32767
	D = D - A
	
	@addr
	A = M
	M = D
	
	@32
	D = A
	
	@addr
	M = M + D
	
	@j
	M = M + 1
	
	@LOOP_2
	0; JMP
	
(END_2)

@SCREEN
D = A

@4097
D = A + D

@addr
M = D

@k
M = 0

(LOOP_3)
	@8
	D = A
	
	@k
	D = M - D
	
	@END_3
	D; JGE
	
	@k	
	D = M
	
	@addr
	A = M + D
	M = -1
	
	@k
	M = M + 1
	
	@LOOP_3
	0; JMP
	
(END_3)

(END)
@END
0; JMP
