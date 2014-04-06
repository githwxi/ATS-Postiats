/*
Part2:
Please see:
https://singpolyma.net/2012/01/writing-a-simple-os-kernel-user-mode/
*/

/* ****** ****** */

#include "versatilepb.h"

/* ****** ****** */

extern
void syscall(void); // in assembly
extern
unsigned int *activate(unsigned int *stack); // in assembly

/* ****** ****** */

void bwputs(char *string)
{
  char c;
  while((c = *string)) {
    while(*(UART0 + UARTFR) & UARTFR_TXFF); *UART0 = c; string++;
  } /* end of [while] */
  return ;
}

/* ****** ****** */

void first(void) {
  bwputs("In user-mode: 1\n"); syscall();
  bwputs("In user-mode: 2\n"); syscall();
  return ;
}

/* ****** ****** */

int main(void) {
  unsigned int first_stack[256];
  unsigned int *first_stack_start = first_stack + 256 - 16;
  first_stack_start[0] = 0x10;
  first_stack_start[1] = (unsigned int)&first;

  bwputs("Starting\n");
  first_stack_start = activate(first_stack_start);
  bwputs("Heading back to user-mode\n");
  first_stack_start = activate(first_stack_start);
  bwputs("Done\n");
  while(1); /* We can't exit, there's nowhere to go */
  return 0;
}

/* ****** ****** */

/* end of [kernel.c] */
