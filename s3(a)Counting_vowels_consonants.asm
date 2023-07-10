.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the input string : $'
    vowmsg DB 'Numbers of vowels : $'
    consmsg DB 'Numbers of consonants : $'
    vowels DB 'aeiouAEIOU'
    vow DB 48
    cons DB 48
     
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,9
    INT 21H
    
    INPUT:
        MOV AH,1
        INT 21H
       
        CMP AL,0DH
        JE END_INPUT
        
        MOV SI,0
        MOV CX,10
        CHECK_VOWEL:
            CMP AL,vowels[SI]
            JE COUNT_VOWEL
            INC SI
            LOOP CHECK_VOWEL
            
        CMP AL,'z'
        JG INPUT
        
        CMP AL,'A'
        JL INPUT
            
        CMP AL,'Z'
        JG LESS_a
        JMP COUNT_CONSONANT
        
        LESS_a:
            CMP AL,'a'
            JL INPUT
            
        COUNT_CONSONANT:
            INC cons
            JMP INPUT
        COUNT_VOWEL:
            INC vow
            JMP INPUT  
            
    END_INPUT:
     
        
    CALL NEW_LINE
    
    LEA DX,vowmsg
    MOV AH,9
    INT 21H
    
    MOV DL,vow
    MOV AH,2
    INT 21H 
    
    CALL NEW_LINE
    
    LEA DX,consmsg
    MOV AH,9
    INT 21H
    
    
    MOV DL,cons
    MOV AH,2
    INT 21H        
    
    EXIT:
        MOV AH,4CH
        INT 21H
    
MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN
    
    
    