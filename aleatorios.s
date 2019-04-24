@----------------------------------

.data

@ See /usr/include/arm-linux-gnueabihf/asm/unistd.h
@ See /usr/include/arm-linux-gnueabihf/bits/fcntl-linux.h

    .equ create,     8
         .equ Mode, 0644       @ -rw-r--r--
    .equ open,       5
         .equ Rd,   00
         .equ Wr,   01
         .equ RdWr, 02
         .equ Apnd, 02000
    .equ read,       3
    .equ write,      4
    .equ close,      6
    .equ sync,       36
    .equ exit,       1
    .equ sfile,      187

@----------------------------------

.balign 4
dir_file:
    .asciz "/dev/urandom"

.balign 4
Open:
    .word dir_file, RdWr | Apnd, open

.balign 4
Buf:
    .word 0 

.balign 4
Read:
    .word Buf, 1, read

.balign 4
format:
    .asciz "%3d\n"

@----------------------------------

.text

.global aleatorios

aleatorios:

@    push   {r4, r5, r7, lr}     folowing AAPCS

     ldr    r3, =Open            @ load address
     ldm    r3, {r0, r1, r7}     @ load registers
     svc    #0                   @ OS opens file
     mov    r4, r0               @ save fd in r4

     ldr    r3, =Read            @ load address
     ldm    r3, {r1, r2, r7}     @ load registers
     svc    #0                   @ OS reads file

     mov    r0, r4               @ move fd in r0
     mov    r7, #close           @ num for close
     svc    #0                   @ OS closes file

@     ldr    r0, =format          adress of format
       @ load byte
@     bl     printf               @ C() print byte
@     mov    r0, #0               @ 0 = success

exit:

@     pop    {r4, r5, r7, lr}     @ folowing AAPCS
     ldr    r1, =Buf             @ addr of byte red
     ldr    r0, [r1]      
     mov    pc, lr                   @ Exit if use gcc as linker
