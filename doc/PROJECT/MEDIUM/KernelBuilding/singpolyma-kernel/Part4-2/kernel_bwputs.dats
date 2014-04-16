(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

#include "./kernel_staload.hats"

(* ****** ****** *)

staload "./kernel.sats"

(* ****** ****** *)

%{^
#include "./versatilepb.cats"
%} // end of [%{^]

(* ****** ****** *)

extern
fun
UART_wait (): void = "mac#"
extern
fun
UART_is_full (): bool = "mac#"
//
implement
UART_wait () =
  if UART_is_full () then UART_wait () else ()
//
(* ****** ****** *)
//
extern
fun C__output (char): void = "mac#"
%{^
static
void C__output (char c)
{ 
  *(volatile char*)(UART0) = c; return ;
}
%}
//
(* ****** ****** *)

staload "./../../utilities/output.dats"

(* ****** ****** *)

implement
output_char<> (c) = C__output (c)

(* ****** ****** *)

implement bwputi (int) = output_int<> (int)
implement bwputp (ptr) = output_ptr<> (ptr)
implement bwputs (str) = output_string<> (str)

(* ****** ****** *)

(* end of [kernel_bwputs.dats] *)
