;Finding largest value of the array
;input: 451829346
;output: 9



.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the array elements (single decimal digits from 0 to 9) : $"
    outmsg DB "The largest value is : $"
    
    arr DB 100 DUP ("$")
    large DB 0
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,09H
    INT 21H
    
    
    INPUT:
        MOV AH,1
        INT 21H
        
        CMP AL,0DH
        JE END_INPUT
        
        CMP AL,large
        JG UPDATE
        JMP INPUT
        
        UPDATE:
            MOV large,AL
            JMP INPUT
    END_INPUT:
    
    ;This part of the code is not needed.if we user upper part.
    ;Problem fixed :)
    
    ;MOV SI,0
    ;INPUT:
    ;    MOV AH,1
    ;    INT 21H
      
    ;    CMP AL,0DH
    ;    JE END_INPUT
        
    ;    MOV arr[SI],AL
    ;    INC SI
    ;    JMP INPUT
       
    ;END_INPUT:
    
    ;CALL NEW_LINE
    ;MOV SI,0
    
    ;CHECK: 
    ;    MOV AL,arr[SI]
    ;    CMP AL,'$'
    ;    JE END_CHECK
    ;    
         ;CMP large,AL   ;This will not work because destination may not be a constatnt.Also CMP may not both be memory locations.
    ;    CMP AL,large   ;This will work perfectly.CMP is just like SUB, except that destination is not changed.The result is not stored, but the flags are affected.
    ;    JG UPDATE
    
    ;    INC SI
    ;    JMP CHECK
        
    ;    UPDATE:
    ;        MOV large,AL
    ;        INC SI
    ;        JMP CHECK
    ;    
    ;END_CHECK:                 
    
    CALL NEW_LINE 
    
    LEA DX,outmsg
    MOV AH,09H
    INT 21H
     
    MOV DL,large
    MOV AH,2
    INT 21H
    
    EXIT:
        MOV AX,4CH
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

    