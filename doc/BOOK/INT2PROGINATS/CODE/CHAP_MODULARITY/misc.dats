(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
//
(* ****** ****** *)

(*
fun fact (x: int): int =
  if x > 0 then x * fact (x-1) else 1
*)

(*
extern fun fact (x: int): int
implement fact (x) = if x > 0 then x * fact (x-1) else 1
extern fun fact: (int) -> int
implement fact (x) = if x > 0 then x * fact (x-1) else 1
*)
extern val fact: (int) -> int
implement fact (x) = if x > 0 then x * fact (x-1) else 1

(* ****** ****** *)
//
extern
fun{
a:t0p}{b:t0p
} list0_fold_left
  (xs: list0 b, f: (a, b) -<cloref1> a, init: a): a
//
implement{a}{b}
list0_fold_left
  (xs, f, init) = let
//
fun loop
(
  xs: list0 b, res: a
) : a =
(
  case+ xs of
  | list0_nil ((*void*)) => res
  | list0_cons (x, xs) => loop (xs, f (res, x))
) (* end of [loop] *)
//
in
  loop (xs, init)
end // end of [list0_fold_left]
//
(* ****** ****** *)

implement
main0 () =
{
  val () = println! ("fact(10) = ", fact(10))
} // end of [main0]

(* ****** ****** *)

(* end of [misc.dats] *)
