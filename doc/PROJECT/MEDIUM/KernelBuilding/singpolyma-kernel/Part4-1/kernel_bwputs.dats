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
fun output (char): void = "mac#"
%{^
static
void output (char c)
{ 
  *(volatile char*)(0x101f1000) = c; return ;
}
%}
//
(* ****** ****** *)
//
implement
bwputs (str) = let
//
val str = g1ofg0 (str)
//
implement(env)
string_foreach$fwork<env> (c, env) =
  let val () = UART_wait () in output (c) end
//
in
  ignoret (string_foreach<> (str))
end // end of [bwputs]

(* ****** ****** *)

(* end of [kernel_bwputs.dats] *)
