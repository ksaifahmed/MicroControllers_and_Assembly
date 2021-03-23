.model small
.stack 100h
.data 
    a dw 100 dup(0) 
    seprtr db ", $"
    newl db 10,13,"0$"
    ans dw ? 
    count db 0
    

.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;init array
    mov si, a offset
    mov a[si],0
    mov a[si+2],1
    
    ;input 1st num and mul by 10
    mov ah,1
    int 21h
    sub al,48 
    mov bl,10
    mul bl
    mov bl,al
   
    ;inp 2nd num and add
    mov ah,1
    int 21h
    sub al,48
    add bl,al
    
    
    ;inp in bx 
    push bx
    call fibo 
    
    ;print f0             
    mov ah,9
    lea dx,newl
    int 21h  
        
    mov si,a offset
    add si,2
            
    LOOP_PRINT:
        mov bx,a[si]
        mov ans,bx
        cmp bx,0
        jz exit
        
        ;print comma
        mov ah,9
        lea dx,seprtr
        int 21h
        
        call print
        add si,2
        jmp LOOP_PRINT    
    
    
    EXIT:
    mov ah,4ch
    int 21h
    main endp

fibo proc near
    push bp
    mov bp,sp
    
    cmp WORD PTR[bp+4],1
    jg ELSE 
    
    jmp RECURSIVE_RET
        
    ELSE:
        mov cx,[bp+4]
        dec cx
        push cx
        call fibo
        
        mov si,WORD PTR[bp+4]
        add si,si
        mov bx,a offset
        
        ;fibo(n) = fib(n-1)+fibo(n-2)
        mov cx,a[bx+si-2]
        add cx,a[bx+si-4] 
        mov a[bx+si],cx
        
        
    RECURSIVE_RET:
        pop bp
        ret 2

print proc near
    mov al,0
    mov count,al
    
    GET_DIGITS:
        xor ax,ax
        xor bx,bx
        xor dx,dx
        
        ;divide ans with 10 
        mov ax,ans
        mov bx,10
        div bx
        mov ans,ax
        
        ;push remainder into stack
        push dx
        mov bl,count
        inc bl
        mov count,bl
        
        ;stop once quotient = 0
        mov ax,ans
        cmp ax,0
        je PRINT_NUM
        jmp GET_DIGITS
        
    PRINT_NUM:
        mov cl,count
    
    ;for-loop
    LOOP3:   
        ;pop stack and print
        pop dx
        add dl,48
        mov ah,2
        int 21h
        
        ;exit when cl = 0
        dec cl
        cmp cl,0
        je RETURN
        jmp LOOP3 
    RETURN:
        RET

end main