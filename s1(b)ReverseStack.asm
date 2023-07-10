.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the input string : $'
    outmsg DB 'After reversal : $'
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,9
    INT 21H
    
    MOV CX,0
    
    INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE END_INPUT
        
        PUSH AX
        INC CX
        JMP INPUT
    END_INPUT:
    
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    JCXZ EXIT
    
    OUTPUT:
        POP DX
        MOV AH,2
        INT 21H
        LOOP OUTPUT
        
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