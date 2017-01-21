(*
**
** Author: Hongwei Xi (hwxi AT gmail DOT com)
** Start Time: June, 2012
**
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
TIME = "libats/libc/SATS/time.sats"
staload
STDLIB = "libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)

staload "./../SATS/randgen.sats"
staload _(*anon*) = "./../DATS/randgen.dats"

(* ****** ****** *)
//
#define N 100
//
implement
randgen_val<int> () =
  $UNSAFE.cast{int}($STDLIB.random()) mod N
//
implement
randgen_val<double> () = $STDLIB.drand48()
//
(* ****** ****** *)

implement
main () = let
//
val out = stdout_ref
//
val () =
$STDLIB.srand48
  ($UNSAFE.cast2lint($TIME.time_get()))
val () =
$STDLIB.srandom
  ($UNSAFE.cast2uint($TIME.time_get()))
//
val xs = randgen_list<int> (10)
val () = fprintln! (out, "xs = ", xs)
//
val xs =
  randgen_list_vt<double> (10)
val () = fprintln! (out, "xs = ", xs)
val ((*freed*)) = list_vt_free (xs)
//
val n = i2sz(10)
val xs =
  randgen_arrayptr<double>(n)
val () =
(
  fprint! (out, "xs = ");
  fprint_arrayptr(out, xs, n); fprint_newline(out)
)
val ((*freed*)) = arrayptr_free (xs)
//
in
  0(*normal-exit*)
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
