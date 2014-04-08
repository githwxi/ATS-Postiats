/*
Part2:
Please see:
https://singpolyma.net/2012/01/writing-a-simple-os-kernel-user-mode/
*/

/* ****** ****** */

#include "versatilepb.h"

/* ****** ****** */

extern void activate (void) ; // implemented in assembly

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
  bwputs("In user mode\n"); while(1); return ;
}

/* ****** ****** */

int main(void) {
  bwputs("Starting\n");
  activate( /*void*/ ) ;
  while(1); /* We can't exit, there's nowhere to go */
  return 0;
}

/* ****** ****** */

/* end of [kernel.c] */
