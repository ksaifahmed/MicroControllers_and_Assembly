.model small
.stack 100h
.data 
    ar1 db 2 dup(2 dup(?))
    ar2 db 2 dup(2 dup(?))  
    ans dw 2 dup(2 dup(?))
    newl db 10,13,"$"
.code
main proc
    mov ax,@data
    mov ds,ax 
            
    call input1
    call input2
    call mat_mul
            
    exit:
    mov ah,4ch
    main endp
  

input1 proc near
    mov cl,4
    mov si,ar1 offset
    LOOP1:
        mov ah,1
        int 21h
        sub al,48
        mov [si],al
        inc si
        
        mov ah,2
        mov dl,32
        int 21h
        
        dec cl
        cmp cl,2
        je PRINT_NEWL
        jmp ELSE1
        
        PRINT_NEWL:
            mov ah,9
            lea dx,newl
            int 21h
        ELSE1:
            cmp cl,0
            je EXIT_LOOP1
            jmp LOOP1
            
    EXIT_LOOP1:
        mov ah,9
        lea dx,newl
        int 21h
        RET    
        
input2 proc near
    mov cl,4
    mov si,ar2 offset
    LOOP2:
        mov ah,1
        int 21h
        sub al,48
        mov [si],al
        inc si
        
        mov ah,2
        mov dl,32
        int 21h
        
        dec cl
        cmp cl,2
        je PRINT_NEWL2
        jmp ELSE2
        
        PRINT_NEWL2:
            mov ah,9
            lea dx,newl
            int 21h
        ELSE2:
            cmp cl,0
            je EXIT_LOOP2
            jmp LOOP2
            
    EXIT_LOOP2:
        mov ah,9
        lea dx,newl
        int 21h
        RET
        
mat_mul proc near
                
end main       