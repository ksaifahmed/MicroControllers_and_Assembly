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
    
    call mat_mul
    
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
        
mat_mul proc near

    mov val, ar1 offset
    lea di, ar2 
    lea si, ans 
    
    LOOP_MUL:
        xor ax,ax
        mov bx,val
        
        mov al,[bx]
        mov bl,[di]
        mul bl
        mov [si],ax
        
        mov bx,val
        inc bx
        mov al,[bx]
        mov bl,[di+2]
        mul bl
    
        add [si],ax
        
        add si,2
        lea dx,ans
        add dx,8
        ;offset > last_elm_ans
        cmp si,dx 
        je EXIT_MUL
        
        ;next row at index = 4n
        lea dx,ans
        add dx,4
        cmp si,dx
        jne ELSE
        
        mov bx,val
        add bx,2 ;next row
        mov val,bx
        
        mov di, ar2 offset ;1st col
        jmp LOOP_MUL
        
        ELSE:
            inc di ;inc col
            jmp LOOP_MUL
        
    EXIT_MUL:        
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