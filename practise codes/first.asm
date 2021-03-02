.model small
.stack 100h
.code


main proc
    mov ah,1   ; ah,1 is for user input
    int 21h    ;exec statement
    mov bl,al  ;al register contains the user inp by default; bl/bh are base registers
    
    mov ah,1
    int 21h
    mov bh,al
    
    mov ah,2    ; ah,2 is for printing
    mov dl,bl   ; dl is data register
    int 21h
    
    mov ah,2
    mov dl,bh
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    