.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the input string : $'
    outmsg DB 'After sorting in ascending order : $'
    st DB 100 DUP ('$')
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
        
        MOV st[SI],AL
        INC SI
        JMP INPUT
    END_INPUT:
    
    MOV SI,0
    
    LOOP1:
        MOV DI,SI
        
        MOV AL,st[SI]
        CMP AL,'$'
        JE END_LOOP1
        
        LOOP2:
            INC DI
            MOV AL,st[SI]
            MOV AH,st[DI]
            CMP AH,'$'
            JE END_LOOP2
            CMP AL,AH
            JG SWAP
            JMP LOOP2
            
            SWAP:
                MOV st[DI],AL
                MOV st[SI],AH
                JMP LOOP2
        END_LOOP2:
        INC SI
        JMP LOOP1
    END_LOOP1:
    
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    OUTPUT:
        LEA DX,st
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