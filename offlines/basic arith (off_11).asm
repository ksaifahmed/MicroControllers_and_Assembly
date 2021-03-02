.model small
.stack 100h
.data
    x db ?
    y db ?
    z db ?

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    int 21h
    sub al,48
    mov x,al
    
    mov ah,1
    int 21h
    sub al,48
    mov y,al
     
    ;z = x-2y
    mov al,y
    add al,y
    mov ah,x
    sub ah,al
    add ah,48
    mov z,ah
     
    ;print newline
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
           
    ;print z
    mov ah,2
    mov dl,z
    int 21h 
    
    ;z = 25-(x+y)
    mov al,x
    add al,y
    mov ah,25
    sub ah,al
    add ah,48
    mov z,ah
    
    ;print newline
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
           
    ;print z
    mov ah,2
    mov dl,z
    int 21h
    
    ;z = 2x - 3y
    mov al,x
    add al,x
    mov ah,y
    add ah,y
    add ah,y
    sub al,ah
    add al,48
    mov z,al
    
    ;print newline
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
           
    ;print z
    mov ah,2
    mov dl,z
    int 21h 
    
    ;z = y-x+1
    mov al,y
    mov ah,x
    sub al,ah
    inc al
    add al,48
    mov z,al
    
    ;print newline
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
           
    ;print z
    mov ah,2
    mov dl,z
    int 21h    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main