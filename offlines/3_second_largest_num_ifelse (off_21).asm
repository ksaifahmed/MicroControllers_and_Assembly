.model small
.stack 100h
.data
    x db ?
    y db ?
    z db ?
    msg db "all are equal$"

.code
main proc
    mov ax,@data
    mov ds,ax
   
    mov ah,1
    int 21h
    mov x,al
   
    mov ah,1
    int 21h
    mov y,al
    
    mov ah,1
    int 21h
    mov z,al
 
    
    ;print newline
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h

    ;all equal
    mov bl,x
    cmp bl,y
    jne ELSE1
   
    cmp bl,z
    jne ELSE1

    mov ah,9
    lea dx, msg
    int 21h
   
    jmp exit

    ;x is greatest
    ELSE1:          
       mov bl,x
       cmp bl,y
       jb ELSE2

       cmp bl,z
       jb ELSE2
        
       ;x = z, so y ans
       cmp bl,z
       je ELSE1_1
       
       ;x = y, so z ans
       cmp bl,y
       je ELSE1_2
       
       mov bl,y
       cmp bl,z
       jb ELSE1_2

       ELSE1_1:
           mov ah,2
           mov dl,y
           int 21h
           jmp exit

       ELSE1_2:
           mov ah,2
           mov dl,z
           int 21h
           jmp exit

    ;y is the greatest  
    ELSE2:
        mov bl,y
        cmp bl,z
        jb ELSE3

        cmp bl,x
        jb ELSE3
       
        cmp bl,z
        je ELSE2_1
        
        cmp bl,x
        je ELSE2_2
       
        mov bl,x
        cmp bl,z
        jb ELSE2_2 
       
        ELSE2_1:
            mov ah,2
            mov dl,x
            int 21h
            jmp exit

        ELSE2_2:
            mov ah,2
            mov dl,z
            int 21h
            jmp exit

    ;z is the greatest
    ELSE3:
        mov bl,x
        cmp bl,y
        jb ELSE3_1
       
        mov ah,2
        mov dl,x
        int 21h
        jmp exit

        ELSE3_1:
            mov ah,2
            mov dl,y
            int 21h
   
    exit:
    mov ah,4ch
    int 21h
    main endp
end main