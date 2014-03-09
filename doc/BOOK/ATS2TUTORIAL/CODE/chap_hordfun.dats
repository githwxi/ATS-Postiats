(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fn find_root
(
  f: int -<cloref1> int
) : int = let
//
fun loop
(
  f: int -<cloref1> int, n: int
) : int =
  if f (n) = 0 then n else (
    if n <= 0 then loop (f, ~n + 1) else loop (f, ~n)
  ) // end of [else] // end of [if]
in
  loop (f, 0)
end // end of [find_root]

(* ****** ****** *)

val () = println!
(
  "root(x*x + x - 110) = ", find_root(lam(x) => x*x + x - 110)
) (* end of [val] *)

(* ****** ****** *)

typedef
fdouble = double -<cloref1> double
//
macdef epsilon = 1E-6 (* precision *)
//
// [f1] is the derivative of [f]
//
fun
newton_raphson
(
  f: fdouble, f1: fdouble, x0: double
) : double = let
  fun loop (
    f: fdouble, f1: fdouble, x0: double
  ) : double = let
    val y0 = f x0
  in
    if abs (y0 / x0) < epsilon then x0 else
      let val y1 = f1 x0 in loop (f, f1, x0 - y0 / y1) end
    // end of [if]
  end // end of [loop]
in
  loop (f, f1, x0)
end // end of [newton_raphson]

// square root function
fn sqrt (c: double): double =
  newton_raphson (lam x => x * x - c, lam x => 2.0 * x, 1.0)
// cubic root function
fn cbrt (c: double): double =
  newton_raphson (lam x => x * x * x - c, lam x => 3.0 * x * x, 1.0)

(* ****** ****** *)

val sqrt_2 = sqrt(2.0)
val () = println! ("sqrt(2) = ", sqrt_2)
val () = println! ("(sqrt(2.0))^2 = ", sqrt_2 * sqrt_2)
val cbrt_2 = cbrt(2.0)
val () = println! ("cbrt(2) = ", cbrt_2)
val () = println! ("(cbrt(2.0))^3 = ", cbrt_2 * cbrt_2 * cbrt_2)

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_hordfun.dats] *)
