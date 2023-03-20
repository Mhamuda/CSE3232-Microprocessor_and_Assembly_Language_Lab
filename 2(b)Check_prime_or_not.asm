;Checking a number is prime or not.

;input: 5
;output: The numner is a prime number.

;input: 2
;output: The numner is a prime number.

;input: 0
;output: The numner is not a prime number.

;input: 4
;output: The numner is not a prime number. 



.MODEL SMALL
.STACK 100H

.DATA 
    inpmsg DB "Enter a number between 0 to 9 : $"
    primemsg DB "The numner is a prime number.$"
    notprimemsg DB "The numner is not a prime number.$"
    
    n DB ?
    p db ?
    d db 2

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
    MOV n,AL
            
    CMP n,2
    JE PRIME
    
    CMP n,2
    JL NOT_PRIME
    
    
    MOV BL,AL
    ;MOV AH,0H
    
    ;MOV CH,0H
    MOV CL,AL
    DEC CL
    
    
    LOOP1:
        MOV AL,BL
        MOV AH,0H
        DIV CL      ;AL divided by (/) CL and result will store in AL = quotient & AH = remainder

        CMP AH,0H
        JE NOT_PRIME
        
        CMP CL,02H
        JE PRIME
        
        LOOP LOOP1
    
    PRIME:
        CALL NEW_LINE
        LEA DX,primemsg
        MOV AH,09H
        INT 21H
        JMP EXIT
    
    NOT_PRIME:
        CALL NEW_LINE
        LEA DX,notprimemsg
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