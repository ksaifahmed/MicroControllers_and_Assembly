.model small
.stack 100h
.data
    NL EQU 10  ;macros
    CR EQU 13  ;can also write CR EQU ODH, NL EQU 0AH
    
    msg1 db "wassup!$"
    msg2 db NL,CR,"eyyy, i like this game...$"  ;char string with new line and carriage return in the beginning
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg1
    int 21h
    
    mov ah,9
    lea dx,msg2
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main