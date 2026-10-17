.syntax unified
.cpu cortex-m3
.thumb

.global gbb_stuff
.global reset_handler

.section .isr_vector, "a", %progbits
.type gbb_stuff, %object

gbb_stuff:
  .word _estack
  .word reset_handler
  .word NMI_Handler
  .word HardFault_Handler
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word SVC_Handler
  .word 0
  .word 0
  .word PendSV_Handler
  .word SysTick_Handler
.size gbb_stuff, .-gbb_stuff

.section .text
.type Default_Handler, %function
Default_Handler:
  b Default_Handler

.type Handler_SysTick, %function
Handler_SysTick:
  b SysTick_Handler

.weak NMI_Handler
.thumb_set NMI_Handler, Default_Handler

.weak HardFault_Handler
.thumb_set HardFault_Handler, Default_Handler

.weak SVC_Handler
.thumb_set SVC_Handler, Default_Handler

.weak PendSV_Handler
.thumb_set PendSV_Handler, Default_Handler

.weak SysTick_Handler
.thumb_set SysTick_Handler, Handler_SysTick

.type reset_handler, %function
reset_handler:
  MOV r0, #0
  LDR r1, =_sdata
  LDR r2, =_edata
  LDR r3, =_sidata
  B copy_sidata_loop

copy_sidata:
  LDR r0, [r3], #4
  STR r0, [r1], #4

copy_sidata_loop:
  CMP r1,r2
  bcc copy_sidata

  MOV r0, #0
  LDR r1, =_sbss
  LDR r2, =_ebss
  B copy_bss_loop

copy_bss:
  STR r0, [r1], #4

copy_bss_loop:
  CMP r1, r2
  BCC copy_bss
  B main

.size reset_handler, .-reset_handler
