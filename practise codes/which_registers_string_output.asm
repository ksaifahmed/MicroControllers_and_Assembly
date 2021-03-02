.model small
.stack 100h
.data
    m db "hello world$"
 
.code
main proc
    mov ax,@data
    mov ds,ax    ;ax used for larger 16-bit data and al for smaller
    
    mov ah,9      ;ah,9 for string output
    lea dx,m      ;use lea instead of mov and dx (instead of dl like ax above)
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main