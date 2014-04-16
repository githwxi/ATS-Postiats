.global syscall_fork
syscall_fork:
  push {r7}
  mov r7, #0x1
  svc 0
  pop {r7}
  bx lr
