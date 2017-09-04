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

#define ATS_PACKNAME "systemf_list"

(* ****** ****** *)

#include "prelude/DATS/pointer.dats"

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
extern val _0_ : int
extern fun succ : int -<> int

in // in of [local]

local
assume int = ptr
in
implement _0_ = the_null_ptr
implement succ(x) = ptr_succ<char>(x)
end // end of [local]

fn list_length
  {A:type} (
  xs: list_f(A)
) :<> int = let
  val nil = _0_
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
//
// insertion sort
// HX-2010-fall: a question in cs520 final
// HX-2010-11-29: ported from ATS/Anairiats
//
fn insort
  {A:type} (
  xs: list_f A, lte: (A, A) -<0> bool
) : list_f (A) = let
//
typedef X0 = list_f (A)
//
val nil0 = Nil
val cons0 = lam (
  x0: A, xs0: X0
) : X0 =<cloref0> let
  typedef X1 = '(
    A // the first element of the inserted
  , list_f (A) // original
  , list_f (A) // inserted
  ) // end of [typedef]
  val nil1 = '(x0, Nil, Cons (x0, Nil))
  val cons1 = lam (
    x: A, xs: X1
  ) : X1 =<cloref0> let
    val x0 = xs.0
  in
    if x \lte x0 then
      '(x, Cons (x, xs.1), Cons (x, xs.2))
    else
      '(x0, Cons (x, xs.1), Cons (x0, Cons (x, xs.1)))
    // end of [if]
  end // end of [val]
  val res = xs0 {X1} (nil1, cons1)
in
  res.2
end // end of [insert]
//
in
  xs {X0} (nil0, cons0)
end // end of [insort]

(* ****** ****** *)

implement main () = 0 where { }

(* ****** ****** *)

(* end of [list.dats] *)
