(*
** for testing [libats/ML/monad_maybe]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/monad_maybe.sats"
staload _ = "libats/ML/DATS/monad_maybe.dats"

(* ****** ****** *)

val () =
{
//
infix >>=
macdef ret(x) = monad_return<int> (,(x))
macdef >>= (x, f) = monad_bind<int><int> (,(x), ,(f))
//
val m0 =
ret(1) >>=
(
lam(x) => ret(10) >>= (lam(y) => ret(100) >>= (lam(z) => ret (x + y + z)))
) (* end of [val] *)
//
val () = fprintln! (stdout_ref, "m0(111) = ", m0)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val m0 = monad_maybe_some<int> (50)
val m1 = monad_maybe_some<int> (100)
val m01_add = monad_bind2<int,int><int> (m0, m1, lam (x, y) => monad_return<int> (x+y))
val m01_mul = monad_bind2<int,int><int> (m0, m1, lam (x, y) => monad_return<int> (x*y))
//
val () = fprintln! (stdout_ref, "m01_add = ", m01_add)
val () = fprintln! (stdout_ref, "m01_mul = ", m01_mul)
//
} (* end of [val] *)

(* ****** ****** *)
//
datatype expr = 
  | Val of Int 
  | Div of (expr, expr)
//
(* ****** ****** *)
//
macdef non() = monad_maybe_none()
//
macdef ret(x) = monad_return<int> (,(x))
//
infix >>=
macdef >>= (x, f) = monad_bind<int><int> (,(x), ,(f))
//
(* ****** ****** *)

fun
idiv
(
  i1: int, i2: int
) : monad(int) = if i2 != 0 then ret(i1/i2) else non()

(* ****** ****** *)

fun
eval(x0: expr): monad(int) =
(
case+ x0 of
| Val(i) => ret(i)
| Div(x1, x2) =>
  eval(x1) >>= (lam i1 => eval(x2) >>= (lam i2 => idiv(i1, i2)))
) (* end of [eval] *)

(* ****** ****** *)
//  
macdef V_(x) = Val(,(x))
//
fun{}
Div_(x: expr, y: expr): expr = Div(x, y)
//
overload / with Div_
//
val ok  = V_(1972) / V_(2) / V_(23)
val err = V_(2) / ( V_(1) / (V_(2) / V_(3)))
//
val () = fprintln! (stdout_ref, "eval(ok) = ", eval(ok))
val () = fprintln! (stdout_ref, "eval(err) = ", eval(err))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_monad_maybe.dats] *)
