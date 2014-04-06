/* ****** ****** */

#include "./versatilepb.h"

/* ****** ****** */

ATSinline()
int UART_is_full ()
{
  return (*(UART0 + UARTFR) & UARTFR_TXFF) ;
}

/* ****** ****** */

/* end of [versatilepb.cats] */
