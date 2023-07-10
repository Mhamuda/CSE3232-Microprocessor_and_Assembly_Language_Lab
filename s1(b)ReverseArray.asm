.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the input string : $'
    outmsg DB 'After reversal : $'
    str DB 100 dup ('$')
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,9
    INT 21H
    
    MOV SI,0
    
    INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE END_INPUT
        
        MOV str[SI],AL
        INC SI
        JMP INPUT
    END_INPUT:
    
    CALL NEW_LINE 
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    DEC SI
    
    OUTPUT:
        CMP SI,0
        JL END_OUTPUT
        
        MOV DL,str[SI]
        MOV AH,2
        INT 21H 
        DEC SI
        JMP OUTPUT
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