(*
**
//
// Fibonaccis via GMP
//
** Author: Hongwei Xi (hwxi AT gmail DOT com)
** Start Time: February, 2013
**
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "atshwxi/intinf/SATS/intinf.sats"
staload _ = "atshwxi/intinf/DATS/intinf.dats"

(* ****** ****** *)

#define int2intinf (x) intinf_make_int (x)

(* ****** ****** *)

fun
fib {n:nat}
(
  n: int (n)
) : Intinf = let
//
fun loop
  {n:int | n >= 1} .<n>.
(
  f0: Intinf, f1: Intinf, n: int n
) : Intinf = let
in
//
if n >= 2 then let
  val f2 =
    add_intinf0_intinf1 (f0, f1)
  // end of [val]
in
  loop (f1, f2, n-1)
end else let
  val () = intinf_free (f0)
in
  f1
end (* end of [if] *)
//
end (* end of [loop] *)
//
val f0 = int2intinf (0)
//
in
  if n >= 1 then loop (f0, int2intinf (1), n) else f0
end // end of [fib]

(* ****** ****** *)

extern
fun atoi: string -> int = "mac#atslib_atoi"

(* ****** ****** *)

implement
main (
  argc, argv
) = let
  val N = 10
  val N = (
    if argc >= 2 then atoi (argv[1]) else N
  ) : int // end of [val]
  val N = g1ofg0_int (N)
  val () = assertloc (N >= 0)
  val res = fib (N)
  val () = println! ("fib(", N, ") = ", res)
  val () = intinf_free (res)
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [test02.dats] *)
