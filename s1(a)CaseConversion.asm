.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB "Enter the input string : $"
    outmsg DB "After conversion : $"
    str DB 100 DUP('$')
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
    
    MOV SI,0
    
    CONVERT:
        MOV AL,str[SI]
        CMP AL,0DH
        JE END_CONVERT
        
        CMP AL,'A'
        JL NO_CHANGE
        
        CMP AL,'z'
        JG NO_CHANGE
        
        CMP AL,'Z'
        JG CHECK
        
        JMP END_CHECK
        
        CHECK:
            CMP AL,'a'
            JL NO_CHANGE
        END_CHECK:
        
        XOR AL,32
        
        NO_CHANGE:
            MOV str[SI],AL
            INC SI
            JMP CONVERT
    END_CONVERT:
    
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    OUTPUT:
        LEA DX,str
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