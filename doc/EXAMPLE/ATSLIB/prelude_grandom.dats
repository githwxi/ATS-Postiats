(*
** For testing
** [prelude/grandom]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atslib_staload_libats_libc.hats"
//
(* ****** ****** *)
//
implement
grandom_int<> () =
  $UNSAFE.cast2int($STDLIB.random()) mod 100
//
(* ****** ****** *)
//
implement
grandom_bool<> () =
  int2bool($UNSAFE.cast2int($STDLIB.random()) mod 2)
//
(* ****** ****** *)

val xs = grandom_list<int>(10)
val () = println! ("xs = ", xs)

(* ****** ****** *)

val xs = grandom_list<bool>(10)
val () = println! ("xs = ", xs)

(* ****** ****** *)

val A0 = grandom_arrszref<int>(i2sz(10))
val () = fprintln! (stdout_ref, "A0 = ", A0)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_grandom.dats] *)
