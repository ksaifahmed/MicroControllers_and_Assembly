.model small
.stack 100h
.data
     ans dw ?
     num1 dw 0
     num2 dw 0
     inp db ?  
     
     neg_flg1 db 0
     neg_flg2 db 0      
     

.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    int 21h
    
    cmp al,45
    jne NUM1_POS
    mov neg_flg1,1
    jmp LOOP1
    
    NUM1_POS: 
        sub al,48
        mov ah,0
        mov num1,ax
        
    LOOP1:
        mov ah,1
        int 21h
        
        cmp al,48
        jb EXIT_LOOP1
        cmp al,57
        ja EXIT_LOOP1
        
        sub al,48
        mov inp,al
        
        mov al,10 
        mov ah,0
        mov bx,num1
        mul bx
        mov num1,ax
        
        mov bl,inp
        mov bh,0
        add bx,num1
        
        jmp LOOP1
    
    EXIT_LOOP1:
        
        mov ah,9
        lea dx,num1,"h$"
        int 21h
        
        
        
        
        
        
    
    
    
    
    
    
    EXIT:
    mov ah,4ch
    int 21h
    main endp
end main