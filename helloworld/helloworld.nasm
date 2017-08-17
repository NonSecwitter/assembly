global _star                                                                          
                                                                                       
section .data                                                                          
message: db 'hello, world!', 10                                                        
                                                                                       
section .text                                                                          
_star:                                                                                
        mov     rax, 1                                                                 
        mov     rdi, 1                                                                 
        mov     rsi, message                                                           
        mov     rdx, 14                                                                
        syscall                                                                        
                                                                                       
        mov     rax, 60                                                                
        xor     rdi, rdi                                                               
        syscall      
