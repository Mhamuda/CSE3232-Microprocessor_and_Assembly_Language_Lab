.MODEL SMALL
.STACK 100H
.DATA
    inpmsg DB 'Enter a number between 1 to 3 : $'
    outmsg DB 'Sum of the series is : $'
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    SUB Al,48
    MOV CX,0
    MOV CL,AL
    MOV BX,0 
    
    JCXZ OUTPUT
    
    SUM:
        ADD BX,CX
        LOOP SUM
    OUTPUT:
        CALL NEW_LINE
             
        LEA DX,outmsg
        MOV AH,9
        INT 21H 
        
        MOV DX,BX
        ADD DX,48
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
    
        