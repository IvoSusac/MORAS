/*
asmebler program koji
racuna sumu prvih 10
prirodnih brojeva i 
rezultat sprema u R1
*/

// inicijalizacija varijable
@i
M = 0

// pocetak petlje
(LOOP_START)
    @i
    MD = M + 1
    
    @10
    D = A - D;
    
    // skoci na kraj petlje ako je i < 10
    @LOOP_END
    D; JLT
    
    @i
    D = M
    
    // spremi rezultat u R1
    @R1
    M = D + M
    
    @LOOP_START
    0; JMP
(LOOP_END)

// beskonacna petlja na kraju
(END)
@END
0; JMP
