;input : 0
;output : 1

;input : 1
;output : 1

;input : 2
;output : 2

;input : 3
;output : 6

.MODEL SMALL
.STACK 100H

.DATA 
    inpmsg DB "Enter the value of N between 0-3 : $"
    outmsg DB "Factorial is : $"
    
    d DB 2
    n DB ?

    
 .CODE
 
 MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,09H
    INT 21H
    
    MOV AH,1
    INT 21H
    
    SUB AL,48
    
    MOV BL,AL
    MOV AL,1
    MOV n,1
    
    CMP BL,0
    JE END_LOOP1
    
    LOOP1:
        MUL n
        
        CMP BL,n
        JE END_LOOP1
        
        INC n
        JMP LOOP1
    
    END_LOOP1:
    
    MOV n,AL
       
    OUTPUT:
        CALL NEW_LINE
        
        LEA DX,outmsg
        MOV AH,09H
        INT 21H
        
        MOV DL,n
        ADD DL,48 
        MOV AH,2
        INT 21H
        JMP EXIT
    
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