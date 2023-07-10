.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the numbers of the array : $'
    outmsg DB 'After sorting in ascending order : $'
    arr DB 100 DUP('$')
    large DB 0
     
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
        
        CMP AL,' '
        JE INPUT
        
        CMP AL,0DH
        JE END_INPUT
        
        MOV arr[SI],AL
        INC SI
        JMP INPUT
    END_INPUT:
    
    MOV SI,0
    LOOP1:
        MOV DI,SI
        
        MOV AL,arr[SI]
        CMP AL,'$'
        JE END_LOOP1
 
        LOOP2:
            INC DI
            MOV AL,arr[SI]
            MOV AH,arr[DI]
            
            CMP AH,'$'
            JE END_LOOP2
            
            CMP AL,AH
            JG SWAP
            JMP LOOP2
            
            SWAP:
                MOV arr[SI],AH
                MOV arr[DI],AL
                JMP LOOP2
        END_LOOP2:
        INC SI
        JMP LOOP1
    END_LOOP1:    
        
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    MOV SI,0
    OUTPUT:
        MOV AL,arr[SI]
        CMP AL,'$'
        JE END_OUTPUT
        
        MOV DL,AL
        MOV AH,2
        INT 21H
        MOV DL,' '
        INT 21H
        INC SI
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
    
    
    