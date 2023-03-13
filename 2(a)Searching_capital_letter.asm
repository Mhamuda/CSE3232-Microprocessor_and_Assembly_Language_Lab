.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the input string : $"
    firstcapmsg DB "First capital = $"
    lastcapmsg DB "Last capital = $"
    nocapmsg DB "No Capitals. $"
    str DB 100 DUP ?
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
              
    LEA DX,inpmsg          
    MOV AH,09H
    INT 21H
    
    MOV SI,0
    MOV DI,0
    
    INPUT:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_INPUT
        
        MOV str[SI],AL
        INC SI
        
        JMP INPUT
        
    END_INPUT:
    
    CALL NEW_LINE
    
    CHECH_FIRST_CAP:
        CMP SI,DI
        JE END_CHECH_FIRST_CAP
        
        CMP str[DI],'A'
        JGE LESS_CZ
        
        INC DI
        JMP CHECH_FIRST_CAP
        
        LESS_CZ:
            CMP str[DI],'Z'
            JLE PRINT_FIRST_CAP
            
            INC DI
            JMP CHECH_FIRST_CAP
       
        PRINT_FIRST_CAP:
            LEA DX,firstcapmsg
            MOV AH,09H
            INT 21H
            
            MOV DL,str[DI]
            MOV AH,2
            INT 21H
            
            CALL NEW_LINE
            JMP CHECH_LAST_CAP 
   
    END_CHECH_FIRST_CAP:
    
        DEC SI
        
    CHECH_LAST_CAP:
          CMP SI,0
          JL END_CHECH_LAST_CAP
          
          CMP str[SI],'A'
          JGE LESS_SZ
          
          DEC SI
          JMP CHECH_LAST_CAP
          
          LESS_SZ:
            CMP str[SI],'Z'
            JLE PRINT_LAST_CAP
            
            DEC SI
            JMP CHECH_LAST_CAP
       
        PRINT_LAST_CAP:
            LEA DX,lastcapmsg
            MOV AH,09H
            INT 21H
            
            MOV DL,str[SI]
            MOV AH,2
            INT 21H
            
            JMP EXIT 
    END_CHECH_LAST_CAP:
    
        LEA DX,nocapmsg
        MOV AH,09H
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
        