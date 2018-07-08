(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
  
%{^
#include <pthread.h>
%} // end of [%{^]
  
(* ****** ****** *)
//
staload
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
staload "libats/SATS/athread.sats"
//
staload _ = "libats/DATS/athread.dats"
staload _ = "libats/DATS/athread_posix.dats"
//
(* ****** ****** *)
//
staload "./../SATS/spinref.sats"
//
staload _ = "./../DATS/spinvar.dats"
staload _ = "./../DATS/spinref.dats"
//
(* ****** ****** *)

fun
spinref_incby
  (spnr: spinref(int)): void = let
//
implement(env)
spinref_process$fwork<int><env> (x, env) = x := x + 1
//
in
  spinref_process<int> (spnr)
end // end of [spinref_incby]

(* ****** ****** *)

implement
main0 () =
{
//
val () = 
println! ("test_spinref: enter")
//
val SPNR = spinref_create_exn<int> (0)
//
val tid1 =
athread_create_cloptr_exn
(
llam () =>
  (fix loop(x: spinref(int)): void => (ignoret(sleep(1u)); spinref_incby(x); loop(x)))(SPNR)
)
val () = println! ("The first thread has been created.")
//
val tid2 =
athread_create_cloptr_exn
(
llam () =>
  (fix loop(x: spinref(int)): void => (ignoret(sleep(1u)); spinref_incby(x); loop(x)))(SPNR)
)
val () = println! ("The second thread has been created.")
//
val () =
( fix loop
  (
    spnr: spinref(int)
  ) : void =>
{
  val n = spinref_get (spnr)
  val () = if n < 2 then (ignoret(sleep(1u)); loop (spnr))
} ) (SPNR) // end of [val]
//
val () = 
println! ("test_spinref: leave")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_spinref.dats] *)
