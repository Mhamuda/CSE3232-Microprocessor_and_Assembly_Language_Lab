.MODEL SMALL
.STACK 100H

.DATA
    str DB 100 DUP ?
    inpmsg DB "Enter the input string : $"
    outmsg DB "After case conversion : $"
    
.CODE

MAIN PROC
    MOV AX,@DATA    ;initializing data segment
    MOV DS,AX
    
    LEA DX,inpmsg   ;get message (inpmsg) [LEA = Load Effective Address]
    MOV AH,09H      ;display string function
    INT 21H         ;display message (inpmsg)
    
    MOV SI,0
    MOV DI,0
    
    INPUT:
        MOV AH,1        ;read character function
        INT 21H         ;read a small letter into AL
        CMP AL,0DH      ;if AL is equal to 0DH then JE(jump if equal) transfers to END_INPUT
        JE END_INPUT    ;jump if equal   
        
        CMP AL,'z'      ;if AL is greater than 'z' then JG(jump ig greater than) transfers to NO_CHANGE
        JG NO_CHANGE    ;jump if greater than
        CMP AL,'A'
        JL NO_CHANGE
        CMP AL,'Z'
        JG CHECK
        
        JMP END_CHECK
        
        CHECK:
            CMP AL,'a'
            JL NO_CHANGE
        END_CHECK:     
        
        XOR AL,32   ;case conversion
        
    NO_CHANGE:
        MOV str[SI],AL
        INC SI
        JMP INPUT
    END_INPUT:
    
        CALL NEW_LINE
        
        LEA DX,outmsg
        MOV AH,09H
        INT 21H
        
        CALL NEW_LINE
    
    ;Printing string character by character    
    ;OUTPUT:
        ;CMP DI,SI
        ;JE END_OUTPUT
       
        ;MOV DL,str[DI]
        ;MOV AH,2
        ;INT 21H
        ;INC DI
        
        ;JMP OUTPUT 
        
    ;END_OUTPUT:
    
    ;Printing whole string at a time
    LEA DX,str
    MOV AH,09H
    INT 21H
    
    ;return to DOS
    MOV AH,4CH  ;DOS exit function
    INT 21H     ;exit to DOS      
    
MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0AH  ;0AH = Line Feed (moves the cursor down to the next line without returning to the beginning of the line.[after 80 char])  
    INT 21H
    MOV DL,0DH  ;0DH = Carriage Return (moves the cursor to the beginning of the line)
    INT 21H
    RET
NEW_LINE ENDP

END MAIN
        