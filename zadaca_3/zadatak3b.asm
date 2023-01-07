@100
D = A

@A
M = D

@B
M = D + 1

@CONTINUE
0;JMP

(SWAP)

$SWP(AA, BB)

@AA
D = M

@A
A = M
M = D

@BB
D = M

@B
A = M
M = D

@POVECAJ
0;JMP

(CONTINUE)

@0
M = M - 1
D = M

@2
M = D

@1
M = D

$WHILE(1)

$WHILE(0)

@A
A = M
D = M

@AA
M = D

@B
A = M
D = M

@BB
M = D

@AA
D = M

@BB
D = D - M

@SWAP
D;JGT

(POVECAJ)
@A
M = M + 1

@B
M = M + 1

@0
M = M - 1

$END

@100
D = A

@A
M = D

@B
M = D + 1

@2
D = M

@0
M = D

@1
M = M - 1

$END

(END)
@END
0;JMP
