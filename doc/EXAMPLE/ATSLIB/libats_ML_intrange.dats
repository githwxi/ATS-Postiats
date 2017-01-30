(*
** for testing [libats/ML/filebas]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
//
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"
staload "libats/ML/SATS/intrange.sats"
//
staload _ = "libats/ML/DATS/list0.dats"
staload _ = "libats/ML/DATS/array0.dats"
staload _ = "libats/ML/DATS/intrange.dats"
//
(* ****** ****** *)
//
val ((*void*)) =
  repeat(5, $delay(print"Hello!\n"))
//
val ((*void*)) =
  (5).repeat()(lam() =<cloref1> print"Hello!\n")
//
val ((*void*)) =
  (5).foreach()(lam(i) => print!(i, ": Hello!\n"))
val ((*void*)) =
  (5,10).foreach()(lam(i) => print!(i, ": Hello!\n"))
//
(* ****** ****** *)
//
val ((*void*)) =
  println! ((10).list0_map(TYPE{int})(lam(i) => i*i))
val ((*void*)) =
  println! ((10).array0_map(TYPE{int})(lam(i) => i*i))
//
(* ****** ****** *)

val () =
{
//
val
N = 9
//
val () =
int2_foreach_cloref
(
N, N,
lam (i, j) =>
(
  if j > 0 then print ' ';
  $extfcall(void, "printf", "%dx%d=%02d", i+1, j+1, (i+1)*(j+1));
  if (j+1=N) then println! ();
) (* end of [lam] *)
) (* end of [int2_foreach_cloref] *)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_intrange.dats] *)
