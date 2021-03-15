.model small
.stack 100h
.data
     num1 dw 0
     num2 dw 0
     inp db ?
     
     op db ?  
     
     is_neg1 db 0
     is_neg2 db 0 
     
     msg db 10,13,"wrong operator$" 
     newl db 10,13,"$"
     
     count db 0    
     
.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    int 21h
    
    ;checks minus sign
    cmp al,45
    jne NUM1_POS
    mov is_neg1,1
    jmp LOOP1
    
    ;not sign but number
    NUM1_POS: 
        sub al,48
        mov ah,0
        mov num1,ax
        
    LOOP1:
        mov ah,1
        int 21h
        
        ;check whether num
        cmp al,48
        jb EXIT_LOOP1
        cmp al,57
        ja EXIT_LOOP1
        
        ;convert ascii to bin
        sub al,48
        mov inp,al
        
        ;multiply prev val with 10
        mov al,10 
        mov ah,0
        mov bx,num1
        mul bx
        mov num1,ax
        
        ;and add to new input
        mov bl,inp
        mov bh,0
        add bx,num1
        
        ;store in var
        mov num1,bx
        
        jmp LOOP1
    
    EXIT_LOOP1:
        ;store operator
        mov op,al
        
        ;if num1 minus
        mov al,is_neg1
        cmp al,0
        je CHEC_OPER
         
        ;negate
        mov bx,num1
        neg bx
        mov num1,bx
        
    CHEC_OPER:
        mov al,op
        cmp al,43
        je SECOND_NUM
        cmp al,42
        je SECOND_NUM
        cmp al,45
        je SECOND_NUM
        cmp al,47
        je SECOND_NUM
        
        cmp al,113
        jne WRONG_OPER
        jmp EXIT
        
    WRONG_OPER:
        mov ah,9
        lea dx,msg
        int 21h
        jmp EXIT
        
    SECOND_NUM:
        mov ah,1
        int 21h
    
        ;checks minus sign
        cmp al,45
        jne NUM2_POS
        mov is_neg2,1
        jmp LOOP2
    
    ;not sign but number
    NUM2_POS: 
        sub al,48
        mov ah,0
        mov num2,ax
        
    LOOP2:
        mov ah,1
        int 21h
        
        ;check whether num
        cmp al,48
        jb EXIT_LOOP2
        cmp al,57
        ja EXIT_LOOP2
        
        ;convert ascii to bin
        sub al,48
        mov inp,al
        
        ;multiply prev val with 10
        mov al,10 
        mov ah,0
        mov bx,num2
        mul bx
        mov num2,ax
        
        ;and add to new input
        mov bl,inp
        mov bh,0
        add bx,num2
        
        ;store in var
        mov num2,bx
        
        jmp LOOP2
    
    EXIT_LOOP2:         
        ;if num2 minus
        mov al,is_neg2
        cmp al,0
        je CALC
         
        ;negate
        mov bx,num2
        neg bx
        mov num2,bx
    
    CALC: 
        mov bx,num1
        
        mov al,op
        cmp al,43
        jne NOT_ADD
        
        ;addition
        add bx,num2
        mov num1,bx
        jmp PRINT_MINUS
        
    NOT_ADD:
        cmp al,45
        jne NOT_SUB
        
        ;subtraction
        sub bx,num2
        mov num1,bx
        jmp PRINT_MINUS
    
    NOT_SUB:       
        cmp al,42
        jne NOT_MUL
        
        ;multiplication
        mov ax,num2
        imul bx
        mov num1,ax
        jmp PRINT_MINUS
        
    NOT_MUL:
        ;division
        mov ax,num1
        mov bx,num2
        idiv bx
        mov num1,ax
        jmp PRINT_MINUS
    
    PRINT_MINUS:
        mov ah,9
        lea dx,newl
        int 21h
        
        ;check if result if neg
        mov bx,num1 
        cmp bx,0
        jge GET_DIGITS
       
        ;if so use 2's comp 
        neg bx
        mov num1,bx
        
        ;and print minus
        mov ah,2
        mov dl,'-'
        int 21h
        
    GET_DIGITS:
        xor ax,ax
        xor bx,bx
        xor dx,dx
        
        ;divide ans with 10 
        mov ax,num1
        mov bx,10
        div bx
        mov num1,ax
        
        ;push remainder into stack
        push dx
        mov bl,count
        inc bl
        mov count,bl
        
        ;stop once quotient = 0
        mov ax,num1
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
        je EXIT
        jmp LOOP3     
    
    EXIT:
    mov ah,4ch
    int 21h
    main endp
end main