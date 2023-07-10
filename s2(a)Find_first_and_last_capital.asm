.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the input string : $'
    fmsg DB 'First capital : $'
    lmsg DB 'Last capital : $'
    nocapmsg DB 'No capitals. $'
    
    first DB '['
    last DB '@'
    
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
        
        CMP AL,'A'
        JGE LESS_Z
        JMP INPUT
        
        LESS_Z:
            CMP AL,'Z'
            JLE UPDATE
            JMP INPUT
            
            UPDATE:
                CMP AL,first
                JL UPDATE_F
                
                CHECK_L:
                    CMP AL,last
                    JG UPDATE_L
                    JMP INPUT
                UPDATE_F:
                    MOV first,AL
                    JMP CHECK_L
                UPDATE_L:
                    MOV last,AL
                    JMP INPUT
    END_INPUT:
    
    CMP first,'['
    JE NO_CAPITAL_PRINT
    
    CALL NEW_LINE
    LEA DX,fmsg
    MOV AH,9
    INT 21H
    
    MOV DL,first
    MOV AH,2
    INT 21H  
    
    CALL NEW_LINE
    LEA DX,lmsg
    MOV AH,9
    INT 21H
    
    MOV DL,last
    MOV AH,2
    INT 21H
    
    JMP EXIT
    
    NO_CAPITAL_PRINT:
        CALL NEW_LINE
        LEA DX,nocapmsg
        MOV AH,9
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