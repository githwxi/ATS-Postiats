(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

#include "kernel_staload.hats"

(* ****** ****** *)

staload "./kernel.sats"

(* ****** ****** *)
//
extern
fun
kernel_loop (): void
//
implement
kernel_loop () = let
//
val task = choose_task ()
val task = activate (task)
val ((*void*)) = update_task (task)
//
in
  kernel_loop ()
end // end of [kernel_loop]
//
(* ****** ****** *)
//
extern
fun
kernel_main (): void = "mac#"
//
implement
kernel_main () =
{
//
val () =
kernel_task_initize ()
//
val () = kernel_loop ()
//
} (* end of [kernel_main] *)

(* ****** ****** *)

%{$
//
int main () { kernel_main (); return 0 ;}
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [kernel.dats] *)
