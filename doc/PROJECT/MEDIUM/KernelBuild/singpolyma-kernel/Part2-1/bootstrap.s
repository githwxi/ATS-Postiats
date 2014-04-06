/* We need to set up the stack pointer before C code can run
   This memory address is the end of the on-board 128MB of
   RAM for QEMU versatilepb */
.global _start
_start:
  ldr sp, =0x07FFFFFF
  bl main
