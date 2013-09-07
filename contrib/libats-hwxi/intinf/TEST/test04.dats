(*
**
//
// fast power computation
//
** Author: Hongwei Xi
** Authoremail: hwxi AT gmail DOT com
** Start Time: April, 2013
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "./../SATS/intinf.sats"
staload "./../SATS/intinf_vt.sats"

(* ****** ****** *)

staload _(*VT*) = "./../DATS/intinf_vt.dats"

(* ****** ****** *)

fun square
  (x: !Intinf): Intinf = let
  val (fpf | x2) = intinf_vcopy (x)
  val res = x * x2
  prval () = fpf (x2)
in
  res
end (* end of [square] *)

fun power
  {n:nat} .<n>.
(
  x: !Intinf, n: int n
) : Intinf = let
in
//
if n > 0 then let
  val n2 = half (n)
  val x2 = square (x)
  val res = power (x2, n2)
  val () = intinf_free (x2)
in
  if n > 2*n2 then mul_intinf1_intinf0 (x, res) else res
end else int2intinf (1)
//
end (* end of [power] *)

(* ****** ****** *)

implement
main0 () =
{
//
#define N 1000
//
val x = int2intinf (2)
//
val res = power (x, N)
val str = intinf_get_strptr (res, 10)
val () = intinf_free (res)
val () = println! "power (2, " N ") =\n" str
val () = strptr_free (str)
//
val res = pow_intinf_int (x, N)
val str = intinf_get_strptr (res, 10)
val () = intinf_free (res)
val () = println! "power (2, " N ") = // built-in\n" str
val () = strptr_free (str)
//
val () = intinf_free (x)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04.dats] *)
