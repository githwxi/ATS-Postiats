(*
** for testing [libats/ML/monad_maybe]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/monad_maybe.sats"
staload _ = "libats/ML/DATS/monad_maybe.dats"

(* ****** ****** *)

val () =
{
val m0 = monad_maybe_some<int> (5)
val m1 = monad_maybe_some<int> (10)
val m01_add = monad_bind2<int,int><int> (m0, m1, lam (x, y) => monad_return<int> (x+y))
val m01_mul = monad_bind2<int,int><int> (m0, m1, lam (x, y) => monad_return<int> (x*y))
//
val () = fprintln! (stdout_ref, "m01_add = ", m01_add)
val () = fprintln! (stdout_ref, "m01_mul = ", m01_mul)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_monad_maybe.dats] *)