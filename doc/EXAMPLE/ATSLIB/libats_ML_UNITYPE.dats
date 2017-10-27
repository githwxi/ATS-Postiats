(* ****** ****** *)
(*
** for testing
** [libats/ML/UNITYPE]
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: July, 2013
// Authoremail: hwxi AT cs DOT bu DOT edu
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload
"libats/ML/UNITYPE/funarray.dats"
#dynload
"libats/ML/UNITYPE/funarray.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
val xs =
g0ofg1
(
$list{string}("a","b","c")
) (* val *)
val xs =
list0_map
(xs, lam(x) => GVstring(x))
//
val xs = farray_make_list(xs)
//
val () = println! ("xs = ", xs)
val () = println! ("xs[0] = ", xs[0])
val () = println! ("xs[1] = ", xs[1])
val () = println! ("xs[2] = ", xs[2])
val () = println! ("xs[3] = ", xs[3])
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_UNITYPE.dats] *)
