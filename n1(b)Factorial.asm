.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter a number between 0 to 3 : $'
    outmsg DB 'Factorial of the number is : $'
    n DB ?
    
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
    XOR CX,CX
    MOV CL,AL
    MOV AX,1
    
    
    JCXZ OUTPUT
    
    FACTORIAL:
        MUL CX
        LOOP FACTORIAL
    
    OUTPUT:
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
    
    
    