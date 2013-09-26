(*
** for testing [libats/ML/monad_list]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

staload "libats/ML/SATS/monad_list.sats"
staload _ = "libats/ML/DATS/monad_list.dats"

(* ****** ****** *)

val () =
{
val m0 = monad_list_list ((list0)$arrpsz{int}(1, 2, 3))
val m1 = monad_list_list ((list0)$arrpsz{int}(10, 20, 30))
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

(* end of [libats_ML_monad_list.dats] *)