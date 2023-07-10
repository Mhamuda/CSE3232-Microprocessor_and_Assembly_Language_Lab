.MODEL SMALL
.STACK 100H
.DATA
    mainmsg DB 'Enter the main string : $'
    submsg DB 'Enter the substring : $'
    foundmsg DB 'Found. $'
    notfoundmsg DB 'Not found. $'
    
    mst DB 100 DUP ('$')
    sbst DB 100 DUP ('$')

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,mainmsg
    MOV AH,9
    INT 21H 
    
    MOV SI,0
    MAIN_INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE END_MAIN_INPUT
        
        MOV mst[SI],AL
        INC SI
        JMP MAIN_INPUT
    END_MAIN_INPUT:
     
    CALL NEW_LINE
    
    LEA DX,submsg
    MOV AH,9
    INT 21H 
    
    MOV SI,0
    SUB_INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE END_SUB_INPUT
        
        MOV sbst[SI],AL
        INC SI
        JMP SUB_INPUT
    END_SUB_INPUT:
    
    CALL NEW_LINE
    MOV SI,0 
    
    CHECK:
        PUSH SI
        MOV DI,0
        
        LOOP1:
            MOV AL,mst[SI]
            MOV AH,sbst[DI]
            INC SI
            INC DI
            CMP AH,'$'
            JE FOUND
            CMP AL,AH
            JE LOOP1
            
            UPDATE_SI:
                POP SI
                INC SI
                MOV AL,mst[SI]
                CMP AL,'$'
                JE NOT_FOUND
                JMP CHECK

    FOUND:
        LEA DX,foundmsg
        MOV AH,9
        INT 21H
        JMP EXIT
        
    NOT_FOUND:
        LEA DX,notfoundmsg
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
    
    