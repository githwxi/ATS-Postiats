(*
** for testing [libc/math]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/math.sats"
staload _(*anon*) = "libc/DATS/math.dats"

(* ****** ****** *)

val () =
{
//
val () = assertloc (ceil(2.72) = 3.0)
val () = assertloc (ceil(~3.14) = ~3.0)
//
val () = assertloc (floor(2.72) = 2.0)
val () = assertloc (floor(~3.14) = ~4.0)
//
val () = assertloc (round(2.72f) = 3.0f)
val () = assertloc (round(~3.14f) = ~3.0f)
//
val () = assertloc (trunc(2.72L) = 2.0L)
val () = assertloc (trunc(~3.14L) = ~3.0L)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_math.dats] *)
