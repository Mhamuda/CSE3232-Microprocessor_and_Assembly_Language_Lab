.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter a number between 0 to 9 : $'
    oddmsg DB 'Odd. $'
    evenmsg DB 'Even. $'
     
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    AND AL,31H
    
    CMP AL,30H
    JE EVEN
    JMP ODD
    
    EVEN:
        CALL NEW_LINE
        LEA DX,evenmsg
        MOV AH,9
        INT 21H
        JMP EXIT
     
    ODD:
        CALL NEW_LINE
        LEA DX,oddmsg
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
    
    
    