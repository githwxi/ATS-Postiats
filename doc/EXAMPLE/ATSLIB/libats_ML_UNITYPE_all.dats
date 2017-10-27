(* ****** ****** *)
(*
** for testing
** [libats/ML/UNITYPE]
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: October, 2017
// Authoremail: gmhwxiATgmailDOTcom
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

#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
#staload
"libats/ML/UNITYPE/funarray.dats"
#dynload
"libats/ML/UNITYPE/funarray.dats"
//
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
val () =
try
println! ("xs[3] = ", xs[3])
with
~FarraySubscriptExn
 (
   // argless
 ) => println!("FarraySubscriptExn")
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_UNITYPE_all.dats] *)
