//
// BU CAS CS 520: Principles of Programing Languages
// Instructor: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: Fall 2005
//
(* ****** ****** *)
//
// Some examples in System F
// By Hongwei Xi (November 2, 2005)
//
(* ****** ****** *)
//
// HX-2010-08-12:
// This code is updated to compile and run under ATS-0.2.1. Voila!
//
(* ****** ****** *)
//
// HX-2012-11-26: ported to ATS/Postiats
//
(* ****** ****** *)
//
// Implementing lists in System F
//
(* ****** ****** *)

typedef
list_f (A: type) =
  {X:type} (X, (A, X) -<cloref0> X) -<cloref0> X
// end of [list_f]

(* ****** ****** *)

val Nil =
  lam {A:type}: list_f(A) => lam (n, c) => n
val Cons =
  lam {A:type} (x: A, xs: list_f(A)): list_f(A) =<cloref0> lam (n, c) => c (x, xs (n, c))
// end of [Cons]

(* ****** ****** *)

local

abstype int
extern val _0 : int
extern fun succ : int -<> int

in // in of [local]

fn list_length
  {A:type} (
  xs: list_f(A)
) :<> int = let
  val nil = _0
  val cons = lam (_: A, i: int) =<cloref0> succ (i)
in
  xs {int} (nil, cons)
end // end of [list_length]

end // end of [local]

(* ****** ****** *)

fn list_append
  {A:type} (
  xs: list_f(A), ys: list_f(A)
) :<> list_f(A) = xs {list_f(A)} (ys, Cons{A})

(* ****** ****** *)

fn list_reverse
  {A:type} (
  xs: list_f(A)
) :<> list_f(A) = let
  val nil = Nil {A}
  val cons =
    lam (x: A, xs: list_f(A)): list_f(A) =<cloref0> list_append (xs, Cons (x, Nil))
  // end of [val]
in
  xs {list_f(A)} (nil, cons)
end // end of [list_reverse]

(* ****** ****** *)

implement main () = 0 where { }

(* ****** ****** *)

(* end of [list.dats] *)
