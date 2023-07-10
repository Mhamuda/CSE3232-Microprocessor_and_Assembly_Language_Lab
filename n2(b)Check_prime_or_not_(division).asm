.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter a number between 0 to 9 : $'
    primemsg DB 'Prime. $'
    notprimemsg DB 'Not prime. $'
    
    n DB ?
    p DB ?
    d DB ?
     
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
    
    CMP n,2
    JE PRIME
    
    CMP n,2
    JL NOTPRIME
    
    MOV BL,AL
    MOV CL,AL
    DEC CL
    
    CHECK:
        MOV AL,BL
        MOV AH,0H
        DIV CL
        
        CMP AH,0
        JE NOTPRIME
        
        CMP CL,2
        JE PRIME    
    
    NOTPRIME:
        CALL NEW_LINE
        LEA DX,notprimemsg
        MOV AH,9
        INT 21H
        JMP EXIT
    
    PRIME:
        CALL NEW_LINE
        LEA DX,primemsg
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
    
    
    