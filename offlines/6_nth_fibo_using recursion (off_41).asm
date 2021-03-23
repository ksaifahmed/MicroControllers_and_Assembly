.model small
.stack 100h
.data 
    a dw 100 dup(0) 
    seprtr db ", $"
    inp dw ?
    

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
    
    
    mov inp,bx
    ;inp in bx 
    push bx
    call fibo
    
    mov si,inp
    add si,si
    mov bx,a[si]
    
    
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
end main