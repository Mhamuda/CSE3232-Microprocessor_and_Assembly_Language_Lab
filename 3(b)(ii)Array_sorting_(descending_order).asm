;string sorting in descending order 
;input: 2341415
;output: 5443211

.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the input string : $"
    outmsg DB "After sorting : $"
    str DB 100 DUP ("$")
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,09H
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
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    
    LOOP1:
        MOV DI,SI
        
        MOV AL,str[SI]
        CMP AL,'$'
        JE END_LOOP1
        
        LOOP2:
            INC DI
            MOV AL,str[DI]
            MOV AH,str[SI]
            CMP AL,'$'
            JE END_LOOP2
            CMP AH,AL
            JL SWAP      ;JL=descending order , JG=ascending order
            JMP LOOP2
            
        SWAP:
            MOV str[DI],AH
            MOV str[SI],AL
            JMP LOOP2
       
        END_LOOP2:
            INC SI
            JMP LOOP1
    
    END_LOOP1:

    OUTPUT:
        LEA DX,str
        MOV AH,09H
        INT 21H
        
    EXIT:
        MOV AH,4CH
        INT 21H
       
MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN
        
    