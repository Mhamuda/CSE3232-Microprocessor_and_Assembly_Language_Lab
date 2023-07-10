.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the input string : $'
    outmsg DB 'Longest increasing sequence : $'
    st DB 100 DUP ('$')
    index DW 0
    mx DW 1   
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
        
        MOV st[SI],AL
        INC SI
        JMP INPUT
    END_INPUT:
    
    MOV SI,0
    MOV CX,1
    
    CHECK:
        MOV AL,st[SI]
        MOV AH,st[SI+1]
        
        CMP AH,0DH
        JE END_CHECK
        
        INC AL
        CMP AL,AH
        JNE CHECK_MAX
        
        INC SI
        INC CX
        JMP CHECK
        
        CHECK_MAX:
            CMP CX,mx
            JG UPDATE
            
            INC SI
            MOV CX,1
            JMP CHECK
            
            UPDATE:
                MOV mx,CX
                MOV BX,SI
                SUB BX,CX
                INC BX
                MOV index,BX
                INC SI
                MOV CX,1
                JMP CHECK
    END_CHECK:
    
    CMP CX,mx
    JG LAST_UPDATE
    JMP END_LAST_UPDATE
    
    LAST_UPDATE:
        MOV mx,CX
        MOV BX,SI
        SUB BX,CX
        INC BX
        MOV index,BX
    END_LAST_UPDATE:
    
    CALL NEW_LINE
    LEA DX,outmsg
    MOV AH,9
    INT 21H 
    
    MOV SI,index
    MOV CX,mx
    
    OUTPUT:
        MOV DL,st[SI]
        MOV AH,2
        INT 21H
        INC SI
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