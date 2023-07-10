.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter a number between 1 to 3 : $'
    outmsg DB 'Summation of the series is : $'
    n DB ?
    d DB 2
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    SUB AL,48
    MOV n,AL
    INC n
    
    MUL n
    DIV d
    
    MOV n,AL
    
    CALL NEW_LINE
    
    LEA DX,outmsg
    MOV AH,9
    INT 21H
    
    MOV DL,n
    ADD DL,48
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
    
    
    