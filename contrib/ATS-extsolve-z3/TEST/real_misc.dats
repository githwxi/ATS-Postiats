(* ****** ****** *)
//
// HX-2016-06:
// Miscellaneous
// tests for reals
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/SATS/Number/real.sats"
staload
"libats/DATS/Number/real_double.dats"
//
(* ****** ****** *)

#define i2r int2real

(* ****** ****** *)

propdef true_p = unit_p

(* ****** ****** *)
//
extern
prfun
lemma_addmul
{x,y,z:real}
(
// argless
) : [x*(y+z)==x*y+x*z] true_p
//
prval
lemma_addmul =
  $solver_verify($d2ctype(lemma_addmul))
//
(* ****** ****** *)
//
fun
abs_nonneg
  {x:real}
(
  x: real(x)
) : [y: real | y >= 0] real(y) = abs(x)
//
(* ****** ****** *)
//
fun
double_real
  {x:real}
(
  x: real(x)
) : real(2*x) = (x + x)
//
(* ****** ****** *)
//
fun
square_real
  {x:real}
(
  x: real(x)
) : [y:real | y >= 0] real(y) = (x * x)
//
(* ****** ****** *)
//
fun
addmul_distribute
  {x,y,z:real}
(
  x: real(x), y: real(y), z: real(z)
) : real(x*y+x*z) = x*(y+z)
//
(* ****** ****** *)

val x = sqrt(i2r(25)/i2r(100))

(* ****** ****** *)

(* end of [real_misc.dats] *)
