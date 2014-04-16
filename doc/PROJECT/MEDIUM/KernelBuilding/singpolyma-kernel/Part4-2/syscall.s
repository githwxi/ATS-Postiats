.global syscall
syscall:
  push {r7}
  mov r7, #0x0
  svc 0
  pop {r7}
  bx lr
