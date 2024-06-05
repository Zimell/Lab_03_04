DATA SEGMENT
    A DB ?
    X1 DB ?
    X DB ?
    Y DB ?
    Y1 DB ?
    Y2 Db ?
    PERENOS DB 13,10,"$"
    VVOD_A DB 13,10,"VVEDITE A=$"
    VVOD_X DB 13,10,"VVEDITE X=$",13,10 
    VIVOD_Y DB "Y=$"
ENDS

STACK SEGMENT
    DW 128 DUP(0)
ENDS
CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX 

    XOR AX, AX 
    MOV DX, OFFSET VVOD_A
    MOV AH, 9
    INT 21H
SLED2:
    MOV AH, 1
    INT 21H 
    CMP AL, "-" 
    JNZ SLED1 
    MOV BX, 1 
    JMP SLED2
SLED1:
    SUB AL, 30H 
    TEST BX, BX 
    JZ SLED3 
    NEG AL

SLED3:
    MOV A, AL

    XOR AX, AX
    XOR BX, BX 

    MOV DX, OFFSET VVOD_X 
    MOV AH, 9 
    INT 21H 

SLED4:
    MOV AH, 1
    INT 21H 
    CMP AL, "-" 
    JNZ SLED5
    MOV BX, 1 
    JMP SLED4
SLED5:
    SUB AL, 30H
    TEST BX, BX
    JZ SLED6
    NEG AL
SLED6:
    MOV X1, AL
    MOV X, AL
    MOV AL, A
    CMP X, 2
    JG @Y_1  
    SHL X, 1
    ADD X, 1
    MOV AL, X
    MOV Y1, AL
    
    MOV AL, X1
    MOV X, AL
    MOV AL, A
    CMP X, 0
    JNl @Y_2 
    CMP X, 0
    JNL @Y_2_1
@Y_1: 
    SHL X, 1
    ADD AL, X
    MOV Y1, AL
@Y_2:
    MOV AL, A
    SUB AL, 1
    MOV Y2, AL  
@Y_2_1:
    ADD X, 1
    MOV AL, X
    MOV Y2, AL 
@VIXOD:
    MOV AL, Y1
    SUB AL, Y2
    MOV Y, AL

    MOV DX, OFFSET PERENOS
    MOV AH, 9 
    INT 21H 
    
    MOV DX, OFFSET VIVOD_Y
    MOV AH, 9 
    INT 21H 
    
    MOV AL, Y
    CMP Y, 0
    JGE SLED7

    NEG AL
    MOV BL, AL 
    MOV DL, "-"
    MOV AH, 2
    INT 21H
    MOV DL, BL 
    ADD DL, 30H 
    INT 21H
    JMP SLED8
SLED7:
    MOV DL, Y
    ADD DL, 30H
    MOV AH, 2
    INT 21H 
SLED8:
    MOV DX, OFFSET PERENOS 
    MOV AH, 9 
    INT 21H

    MOV AH, 1
    INT 21H 
    MOV AX, 4C00H
    INT 21H
ENDS
END START