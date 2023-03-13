.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the input string : $"  
    vowmsg DB "No of vowels = $"
    conmsg DB "No of consonants = $"
    digmsg DB "No of digits = $"
    spamsg DB "No of spaces = $"
    str DB 100 DUP ?
    
    vowel DB 48
    consonant DB 48
    digit DB 48
    space DB 48
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    MOV DI,0
    
    INPUT:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_INPUT
        
        ;space
        CMP AL,20H
        JE COUNT_SPACE
        
        ;digit
        DIGIT_:
            CMP AL,'0'
            JGE LESS_NINE
            
            JMP VOWEL_
            
            LESS_NINE:
                CMP AL,'9'
                JLE COUNT_DIGIT
                JMP VOWEL_ 
                
        ;vowel
        VOWEL_:
            CMP AL,'a'
            JE COUNT_VOWEL
            CMP AL,'e'
            JE COUNT_VOWEL
            CMP AL,'i'
            JE COUNT_VOWEL
            CMP AL,'o'
            JE COUNT_VOWEL
            CMP AL,'u'
            JE COUNT_VOWEL
            
            JMP CONSONANT_
        
        ;consonant
        CONSONANT_:
            CMP AL,'a'
            JG LESS_z
            
            JMP INPUT
            
            LESS_z:
                CMP AL,'z'
                JLE COUNT_CONSONANT
                JMP INPUT  
        
        COUNT_SPACE:
            INC space
            INC SI
            JMP INPUT
        
        COUNT_DIGIT:
            INC digit
            INC SI
            JMP INPUT
        
        COUNT_VOWEL:
            INC vowel
            INC SI
            JMP INPUT
        
        COUNT_CONSONANT:
            INC consonant
            INC SI
            JMP INPUT
        
    END_INPUT:
    
    
    OUTPUT:
        ;printing no of vowels            
         CALL NEW_LINE
         LEA DX,vowmsg
         MOV AH,09H
         INT 21H
          
         MOV DL,vowel
         MOV AH,2
         INT 21H
         
         ;printing no of consonants            
         CALL NEW_LINE
         LEA DX,conmsg
         MOV AH,09H
         INT 21H
          
         MOV DL,consonant
         MOV AH,2
         INT 21H
         
         ;printing no of digits            
         CALL NEW_LINE
         LEA DX,digmsg
         MOV AH,09H
         INT 21H
          
         MOV DL,digit
         MOV AH,2
         INT 21H
         
         ;printing no of spaces            
         CALL NEW_LINE
         LEA DX,spamsg
         MOV AH,09H
         INT 21H
          
         MOV DL,space
         MOV AH,2
         INT 21H
    
    END_OUTPUT:
    
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