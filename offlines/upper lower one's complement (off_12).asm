.model small
.stack 100h
.data
     inp db ?
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    int 21h
    mov inp,al
    
    ;use other registers (not al) if int 21h is called
    mov bl,inp
    add bl,31
    
    ;bcuz int 21h changes al value
    ;returns a value in al register denoting success/failure
    
    ;print new line
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
     
    ;print the previous lower case
    mov ah,2
    mov dl,bl
    int 21h
        
    ;print new line
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    ;the one's complement
    mov al,inp
    neg al  ;NEG gives 2's complement
    sub al,1
    
    ;print it
    mov ah,2
    mov dl,al
    int 21h    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main