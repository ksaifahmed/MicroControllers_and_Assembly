.model small
.stack 100h
.data
    L EQU 021h  ;lower range
    H EQU 07Eh ;upper range
    
    vld_msg db 10,13,"Valid Password$"
    invld_msg db 10,13,"Invalid password$"
    
    cap db 0
    low db 0
    num db 0
    
.code
main proc
    mov ax,@data
    mov ds,ax
            
    LOOP:
        mov ah,1
        int 21h
        
        ;input range
        cmp al,L
        jb EXIT_LOOP
        cmp al,H
        ja EXIT_LOOP
        
        ;caps range
        cmp al,041h
        jb ELSE1
        cmp al,05Ah
        ja ELSE1
        INC cap
        jmp LOOP
        
        ;low range
        ELSE1:    
            cmp al,061h
            jb ELSE2
            cmp al,07Ah
            ja ELSE2
            INC low
            jmp LOOP
        
        ;num range    
        ELSE2:
            cmp al,030h
            jb EXIT_ELSE
            cmp al,039h
            ja EXIT_ELSE
            INC num
            jmp LOOP
            
        EXIT_ELSE:
            jmp LOOP
        
    EXIT_LOOP:
         mov al,cap
         mov bl,num
         mov cl,low
         
         cmp al,0
         je INVALID
         cmp bl,0
         je INVALID
         cmp cl,0
         je INVALID
         
         mov ah,9
         lea dx,vld_msg
         int 21h 
         jmp exit  
         
         INVALID:
            mov ah,9
            lea dx,invld_msg
            int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main