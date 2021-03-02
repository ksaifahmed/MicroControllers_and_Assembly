.model small
.stack 100h

.data           ;ekhane var declare
    msg db 3
    msg1 db ? ;not initialized


.code
main proc
    mov ax,@data ;moving data to ax registers
    mov ds,ax  ;moving ax to data segment ds
    
    mov ah,2  ;msg contains int which goes to display as "love"symbol
    add msg,48 ;to convert to ascii of 3
    mov dl,msg
    int 21h ;execute statement 
    
    mov ah,1
    int 21h
    mov msg1,al ;assigning to msg1 var
        
    mov ah,2 ;display func
    ;print new line
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,2
    mov dl,msg1  ;msg1 took user input so no need to convert to 3
    int 21h
        
    exit:
    mov ah,4ch    ;returning control to DOS
    int 21h
    main endp
end main
    