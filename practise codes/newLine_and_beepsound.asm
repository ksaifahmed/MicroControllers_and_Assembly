.model small
.stack 100h
.data
    msg1 db "wassup!$"
    msg2 db "ey, i like this game.$"
.code

main proc
    ;init data
    mov ax,@data
    mov ds,ax
    
    ;print msg1
    mov ah,9
    lea dx,msg1
    int 21h
     
    ;print new line
    mov ah,2
    mov dl,10     ;newline er ascii 10 
    int 21h
    mov dl,13      ;carriage return er ascii
    int 21h   
    
    ;print msg2
    mov ah,9
    lea dx,msg2
    int 21h
    
    ;output beep sound
    mov ah,2
    mov dl,07
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
    