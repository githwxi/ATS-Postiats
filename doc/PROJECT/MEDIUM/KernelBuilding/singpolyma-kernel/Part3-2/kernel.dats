(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

%{^
#include "./versatilepb.cats"
%} // end of [%{^]

(* ****** ****** *)

#include "./kernel_staload.hats"

(* ****** ****** *)
//
// These are implemented in assembly
//
extern
fun
syscall ((*void*)): void = "mac#"
extern
fun
activate (stack: cPtr1(uint)): cPtr1(uint) = "mac#"
//
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
//
extern
fun
bwputs
(
  str: string
) : void = "mac#"
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

extern
fun
first ((*void*)): void = "mac#"
implement
first ((*void*)) =
{
//
val () = bwputs ("user-first:1\n")
val ((*void*)) = syscall ((*void*))
val () = bwputs ("user-first:2\n")
val ((*void*)) = syscall ((*void*))
//
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
var first_stack = @[uint][256]()
val first_stack = addr@(first_stack)
//
val first_stack_start0 = ptr_add<uint> (first_stack, 256-16)
val () = $UNSAFE.ptr0_set<uint> (first_stack_start0, 0x10u)
val first_stack_start1 = ptr_succ<uint> (first_stack_start0)
val () = $UNSAFE.ptr0_set<uint> (first_stack_start1, $UNSAFE.cast{uint}(first))
//
val first_stack_start =
  $UNSAFE.cast{cPtr1(uint)}(first_stack_start0)
//
val () = bwputs ("kernel:starting\n")
val first_stack_start = activate(first_stack_start)
val () = bwputs ("kernel:heading-back-to-user\n")
val first_stack_start = activate(first_stack_start)
val () = bwputs ("kernel:finished\n")
//
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
