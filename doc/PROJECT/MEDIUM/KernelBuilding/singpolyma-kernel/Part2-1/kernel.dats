(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/bool.dats"
staload _ = "prelude/DATS/char.dats"
staload _ = "prelude/DATS/string.dats"

(* ****** ****** *)

staload _(*UNSAFE*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

%{^
#include "./versatilepb.cats"
%} // end of [%{^]

(* ****** ****** *)

extern
fun
activate ((*void*)): void = "mac#"

(* ****** ****** *)
//
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

extern
fun
bwputs (string): void = "mac#"
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

extern
fun
first ((*void*)): void = "mac#"
implement
first ((*void*)) =
{
  val () = bwputs ("In user-mode\n")
  val ((*loop*)) = while (true) ((*void*))
} (* end of [first] *)

(* ****** ****** *)
//
extern
fun
ATS__main (): void = "ext#"
//
implement
ATS__main ((*void*)) =
{
//
val message = "Starting!\n"
//
val ((*void*)) = bwputs (message)
val ((*void*)) = activate ((*void*))
val ((*void*)) = while (true) ((*void*))
//
} (* end of [ATS__main] *)

(* ****** ****** *)

%{$
//
int main () { kernel_main (); return 0 ;}
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [kernel.dats] *)
