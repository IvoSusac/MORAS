@SCREEN
D = A

@addr
M = D

@0
D = A

@i
M = D

@0
D = A

@j
M = D

@0
D = A

@IS_PRESSED // checker, provjerava je li key pressed, ako je na 1 pressed je
M = D

(KEY_PRESSED) // za otpustanje tipke
	@0 
	D = A
	
	@IS_PRESSED
	M = D // postavi is pressed na 0 
	
	@PRESS_LOOP
	0; JMP

(RESET)
	@j
	M = M + 1
	
	@32
	D = A
	
	@j
	D = D - M
	
	@JUMP_PRESS_LOOP
	D; JNE // skoci na press loop ako je j != 32, inace prebaci u novi red
	
	@512 // prebacivanje u novi red
	D = A
	
	@i
	M = M + D
	
	@j
	M = 0
	
	(JUMP_PRESS_LOOP)
		@PRESS_LOOP
		0; JMP

(DELETE)
	@j // je li broj izasao iz ekrana kad brisemo
	D = M
	
	@i
	D = M + D
	
	@PRESS_LOOP
	D; JEQ
	
	@j
	M = M - 1
	D = M
	
	@SKIP
	D; JGE
	
	@512 // prebacivanje u prethodni redak
	D = A
	
	@i
	M = M - D
	
	@31
	D = A
	
	@j
	M = D
	
	(SKIP)
	
	@1
	D = A
	
	@IS_PRESSED
	M = D
	
	@SCREEN
    D = A
	
    @addr
    M = D

    @j
    D = M
	
    @addr
    M = M + D

    @i
    D = M
	
    @addr
    M = M + D

    @addr
    A = M 
    M = 0
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

	@32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0
	
	@32
    D = A
	
    @addr
    M = M + D
	
    @addr
    A = M 
    M = 0

    @PRESS_LOOP
    0; JMP

(PRESS_LOOP)
	@KBD
	D = M
	
	@KEY_PRESSED
	D; JEQ // skoci na otpustanje tipke
	
	@IS_PRESSED
	D = M
	
	@PRESS_LOOP // ako je tipka pritisnuta skacemo nazad na pocetak petlje
	D; JNE
	
	@48 // tipka 0
	D = A
	
	@KBD
	D = M - D
	
	@DELETE // skoci na delete ako je pritisnuta 0
	D; JEQ
	
	@j
	D = M
	
	@i
	D = M + D
	
	@8191
	D = A - D
	
	@PRESS_LOOP
	D; JLE // provjera jesmo li izasli iz ekrana
	
	@49 // tipka 1
	D = A
	
	@KBD
	D = M - D
	
	@NUMBER1
	D; JEQ // crtaj broj 1
	
	@50 // tipka 2
	D = A
	
	@KBD
	D = M - D
	
	@NUMBER2
	D; JEQ // crtaj broj 2
	
	@51 // tipka 3
	D = A
	
	@KBD
	D = M - D
	
	@NUMBER3
	D; JEQ // crtaj broj 3
	
	@52 // tipka 4
	D = A
	
	@KBD
	D = M - D
	
	@NUMBER4
	D; JEQ // crtaj broj 4
	
	@53 // tipka 5
	D = A
	
	@KBD
	D = M - D
	
	@NUMBER5
	D; JEQ // crtaj broj 5
	
	@KBD
	D = M
	
	@PRESS_LOOP // ako je neka druga tipka pritisnuta, skoci na petlju
	0; JEQ
	
// broj 1	
(NUMBER1)
	@1
	D = A
	
	@IS_PRESSED
	M = D
	
	@SCREEN
	D = A
	
	@addr
	M = D
	
	@j // stupac
	D = M
	
	@addr
	M = M + D
	
	@i // redak
	D = M
	
	@addr
	M = M + D
	
	@0
    D = A
	
    @addr
    A = M 
    M = D
	
  
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M 
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
    
    @32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D
	
	@32
    D = A
	
    @addr
    M = M + D
	
    @384
    D = A
	
    @addr
    A = M
    M = D

    @RESET
    0; JMP

// broj 2
(NUMBER2)
	@1
	D = A
	
	@IS_PRESSED
	M = D
	
	@SCREEN
	D = A
	
	@addr
	M = D
	
	@j
	D = M
	
	@addr
	M = M + D
	
	@i
	D = M
	
	@addr
	M = M + D
	
	@0
	D = A
	
	@addr
	A = M
	M = D
	
    @32
    D = A 

    @addr
    M = M + D 

    @2016
    D = A

    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @7800
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @15390
    D = A
   
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @30735
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @15360
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @7680
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @3840
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @1920
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @960
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @480
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @240
    D = A
    
    @addr
    A = M
    M = D
    
    @32
    D = A 

    @addr
    M = M + D 

    @120
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @60
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @RESET
    0; JMP

// broj 3
(NUMBER3)
	@1
	D = A
	
	@IS_PRESSED
	M = D
	
	@SCREEN
	D = A
	
	@addr
	M = D
	
	@j
	D = M
	
	@addr
	M = M + D
	
	@i
	D = M
	
	@addr
	M = M + D
	
	@0
	D = A
	
	@addr
	A = M
	M = D
	
    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A

    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @RESET
    0; JMP

// broj 4
(NUMBER4)
	@1
	D = A
	
	@IS_PRESSED
	M = D
	
	@SCREEN
	D = A
	
	@addr
	M = D
	
	@j
	D = M
	
	@addr
	M = M + D
	
	@i
	D = M
	
	@addr
	M = M + D
	
	@0
	D = A
	
	@addr
	A = M
	M = D
	
	@32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A

    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28686
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @32766
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @32
    D = A 

    @addr
    M = M + D 

    @28672
    D = A
    
    @addr
    A = M
    M = D

    @RESET
    0; JMP

// broj 5
(NUMBER5)
	@1
    D = A
	
    @IS_PRESSED
    M = D

    @SCREEN
    D = A
	
    @addr
    M = D

    @j
    D = M
	
    @addr
    M = M + D

    @i
    D = M
	
    @addr
    M = M + D

    @0
    D = A
	
    @addr
    A = M 
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @48
    D = A
	
    @addr
    A = M 
    M = D
	
    @32
    D = A
	
    @addr
    M = M + D
	
    @48
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @48
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @48
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @48
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @48
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @3072
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @3072
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D

    @32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D
	
	@32
    D = A
	
    @addr
    M = M + D
	
    @4080
    D = A
	
    @addr
    A = M 
    M = D

    @RESET
    0; JMP

(END)
@END
0; JMP