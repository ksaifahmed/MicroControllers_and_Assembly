.model small
.stack 100h
.data 
    ar1 db 4 dup(0)
    ar2 db 4 dup(0)  
    ans dw 4 dup(0)
    
    newl db 10,13,"$"
    msg1 db "Enter 1st matrix:",10,13,"$"
    msg2 db "Enter 2nd matrix:",10,13,"$"
    msg3 db "Result matrix:",10,13,"$"
    
    count db 0
    val dw 0
    id db 0

.code
main proc
    mov ax,@data
    mov ds,ax 
     
    mov ah,9
    lea dx,msg1
    int 21h       
    call input1
    
    mov ah,9
    lea dx,msg2
    int 21h
    call input2
    
    call mat_add
    
    mov ah,9
    lea dx,msg3
    int 21h
    
    mov id,4
    mov si,ans offset
    LOOP_PRINTER:
        mov ax,[si]
        mov val,ax
        call print
         
        mov cl,id
        dec cl
        jz EXIT
        
        cmp cl,2
        je IF_NEWL
        jmp END_IF_NEWL 
                
        IF_NEWL:
            mov ah,9
            lea dx,newl
            int 21h
         
        END_IF_NEWL:
        mov id,cl
        add si,2
                
        jmp LOOP_PRINTER
            
    exit:
    mov ah,4ch
    int 21h
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

mat_add proc near
    mov bx,0
    
    LOOP_ADD:
        lea si,ar1
        lea di,ar2
        
        mov al,[si+bx]
        add al,[di+bx]
        mov ah,0
        
        lea si,ans
        mov cx,bx
        add bx,bx
        mov [si+bx],ax
        mov bx,cx
                         
        inc bx
        cmp bx,4
        je RETURN_ADD
        jmp LOOP_ADD
    
    RETURN_ADD:
        RET
             

print proc near
    mov al,0
    mov count,al
    
    GET_DIGITS:
        xor ax,ax
        xor bx,bx
        xor dx,dx
        
        ;divide ans with 10 
        mov ax,val
        mov bx,10
        div bx
        mov val,ax
        
        ;push remainder into stack
        push dx
        mov bl,count
        inc bl
        mov count,bl
        
        ;stop once quotient = 0
        mov ax,val
        cmp ax,0
        je PRINT_NUM
        jmp GET_DIGITS
        
    PRINT_NUM:
        mov cl,count
    
    ;for-loop
    LOOP_PRINT:   
        ;pop stack and print
        pop dx
        add dl,48
        mov ah,2
        int 21h
        
        ;exit when cl = 0
        dec cl
        cmp cl,0
        je RETURN_PRINT
        jmp LOOP_PRINT
    RETURN_PRINT:
        mov ah,2
        mov dl,' '
        int 21h
        RET        
                    
end main       