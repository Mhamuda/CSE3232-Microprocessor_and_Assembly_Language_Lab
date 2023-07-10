.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter the numbers of the array : $'
    outmsg DB 'Largest number is : $'
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
    MOV CX,0
    
    INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE END_INPUT
        
        MOV arr[SI],AL
        INC SI
        INC CX
        JMP INPUT
    END_INPUT:
    
    MOV SI,0
    CHECK:
        MOV AL,arr[SI]
        INC SI
        CMP AL,large
        JG UPDATE
        JMP END_UPDATE
        
        UPDATE:
            MOV large,AL
        END_UPDATE:
           
        LOOP CHECK
        
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    MOV DL,large
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
    
    
    