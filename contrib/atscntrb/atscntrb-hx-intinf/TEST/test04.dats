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
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/intinf.sats"
staload "./../SATS/intinf_vt.sats"

(* ****** ****** *)

staload _(*VT*) = "./../DATS/intinf_vt.dats"

(* ****** ****** *)

fun
square
(
x0: !Intinf
) : Intinf = let
val
(
  fpf | x1
) = intinf_vt_vcopy(x0)
//
val res = x0 * x1
prval () = fpf(x1)
//
in
  res
end (* end of [square] *)

(* ****** ****** *)

fun
mypower
{n:nat} .<n>.
(
x0:
!Intinf, n: int(n)
) : Intinf = let
in
//
if
(n > 0)
then let
  val n2 = half(n)
  val x2 = square(x0)
  val res = mypower(x2, n2)
  val ((*freed*)) = intinf_free(x2)
in
//
if n > 2*n2
  then mul_intinf1_intinf0(x0, res) else res
// end of [if]
//
end // end of [then]
else int2intinf(1) // [else]
//
end (* end of [power] *)

(* ****** ****** *)

implement
main0 () =
{
//
#define N 1000
//
val
x0 = int2intinf(2)
//
val
res = mypower(x0, N)
val
str = intinf_get_strptr (res, 10)
//
val () =
println! "power (2, " N ") =\n" str
//
val () = intinf_free(res)
val () = strptr_free(str)
//
val
res =
pow_intinf_int(x0, N)
val
str = intinf_get_strptr(res, 10)
//
val () =
println! "power (2, " N ") = // built-in\n" str
//
val () = intinf_free(res)
val () = strptr_free(str)
//
val ((*freed*)) = intinf_free(x0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04.dats] *)
