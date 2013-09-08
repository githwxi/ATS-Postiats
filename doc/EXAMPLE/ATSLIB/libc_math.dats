(*
** for testing [libc/math]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/math.sats"
staload _(*anon*) = "libc/DATS/math.dats"

(* ****** ****** *)

macdef PI = M_PI

(* ****** ****** *)

val () =
{
//
val () = assertloc (isfinite(1.0) != 0)
val () = assertloc (isnormal(1.0) != 0)
//
val () = assertloc (isinf(1.0) = 0)
val () = assertloc (isnan(1.0) = 0)
//
} (* end of [val] *)

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

val () =
{
val f1 = 1.0
val f2 = 2.0
val f3 = 3.0
val () = assertloc (f1 = fmin (f1, f2))
val () = assertloc (f2 = fmax (f1, f2))
val () = assertloc (max(f1-f2, 0.0) = fdim (f1, f2))
val () = assertloc (max(f2-f1, 0.0) = fdim (f2, f1))
val () = assertloc (f1*f2+f3 = fma (f1, f2, f3))
} (* end of [val] *)

(* ****** ****** *)

macdef sqr(x) = let val x = ,(x) in x * x end
macdef cube(x) = let val x = ,(x) in x * x * x end

val () =
{
val () = println! "sqr(sqrt(2.0)) = " (sqr(sqrt(2.0)))
val () = println! "cube(cbrt(2.0)) = " (cube(cbrt(2.0)))
val () = println! "exp(log(2.0)) = " (exp(log(2.0)))
val () = println! "pow(10.0, log10(2.0)) = " (pow(10.0, log10(2.0)))
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val () = println! ("sin(PI/6) = ", sin(PI/6))
val () = println! ("cos(PI/3) = ", cos(PI/3))
val () = println! ("tan(PI/3) = ", tan(PI/4))
//
val () = println! ("6*asin(sin(PI/6)) = ", 6*asin(sin(PI/6)))
val () = println! ("3*acos(cos(PI/3)) = ", 3*acos(cos(PI/3)))
val () = println! ("4*atan(tan(PI/4)) = ", 4*atan(tan(PI/4)))
val () = println! ("2*atan2(1.0, 0.0) = ", 2*atan2(1.0, 0.0))
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val () = println! ("sinh(PI/6) = ", sinh(PI/6))
val () = println! ("cosh(PI/3) = ", cosh(PI/3))
val () = println! ("tanh(PI/3) = ", tanh(PI/4))
//
val () = println! ("6*asinh(sinh(PI/6)) = ", 6*asinh(sinh(PI/6)))
val () = println! ("3*acosh(cosh(PI/3)) = ", 3*acosh(cosh(PI/3)))
val () = println! ("4*atanh(tanh(PI/4)) = ", 4*atanh(tanh(PI/4)))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_math.dats] *)
