(*
**
//
// Fibonaccis via GMP
//
** Author: Hongwei Xi
** Authoremail: hwxi AT gmail DOT com
** Start Time: February, 2013
**
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload T = "./../SATS/intinf_t.sats"
staload VT = "./../SATS/intinf_vt.sats"

(* ****** ****** *)

staload _(*T*) = "./../DATS/intinf_t.dats"
staload _(*VT*) = "./../DATS/intinf_vt.dats"

(* ****** ****** *)

overload print with $T.print_intinf
overload print with $VT.print_intinf

(* ****** ****** *)

fun
fib_t {n:nat}
(
  n: int (n)
) : $T.Intinf = let
//
fun loop
  {n:int | n >= 1} .<n>.
(
  f0: $T.Intinf, f1: $T.Intinf, n: int n
) : $T.Intinf = let
in
//
if n >= 2 then let
  val f2 =
    $T.add_intinf_intinf (f0, f1)
  // end of [val]
in
  loop (f1, f2, n-1)
end else f1 // end of [if]
//
end (* end of [loop] *)
//
val f0 = $T.int2intinf (0)
//
in
  if n >= 1 then loop (f0, $T.int2intinf (1), n) else f0
end // end of [fib_t]

(* ****** ****** *)

fun
fib_vt {n:nat}
(
  n: int (n)
) : $VT.Intinf = let
//
fun loop
  {n:int | n >= 1} .<n>.
(
  f0: $VT.Intinf, f1: $VT.Intinf, n: int n
) : $VT.Intinf = let
in
//
if n >= 2 then let
  val f2 =
    $VT.add_intinf0_intinf1 (f0, f1)
  // end of [val]
in
  loop (f1, f2, n-1)
end else let
  val () = $VT.intinf_free (f0) in f1
end (* end of [if] *)
//
end (* end of [loop] *)
//
val f0 = $VT.int2intinf (0)
//
in
  if n >= 1 then loop (f0, $VT.int2intinf (1), n) else f0
end // end of [fib_vt]

(* ****** ****** *)

extern
fun atoi: string -> int = "mac#atoi"

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
//
  val res = fib_t (N)
  val () = println! ("fib_t(", N, ") = ", res)
//
  val res = fib_vt (N)
  val () = println! ("fib_vt(", N, ") = ", res)
  val () = $VT.intinf_free (res)
//
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [test02.dats] *)
