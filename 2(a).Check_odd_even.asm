;input : 0
;output : Even

;input : 1
;output : Odd

;input : 2
;output : Even

;input : 3
;output : Odd

.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the value between 0 to 9 : $" 
    evenmsg DB "The number is even.$"
    oddmsg DB "The number is odd.$"
    
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
    DIV d
    
    CMP AH,0    ;remainder = AH , quotient = AL
    JE EVEN
    
    CALL NEW_LINE
    LEA DX,oddmsg
    MOV AH,09H
    INT 21H
    JMP EXIT     
        
    EVEN:
        CALL NEW_LINE
        LEA DX,evenmsg
        MOV AH,09H
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