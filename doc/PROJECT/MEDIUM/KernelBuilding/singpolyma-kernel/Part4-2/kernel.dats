(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

#include "kernel_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

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
val id = choose_tid ()
val task = fetch_task (id)
val task = activate (task)
//
val () = syscall_process (id, task)
//
val ((*void*)) = update_task (id, task)
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
