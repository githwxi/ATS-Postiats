(*
//
// Implementing a module of ML-style
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT edu
// TIme: the 4th of June, 2013
//
*)

(* ****** ****** *)

typedef
ordmod
  (a:t@ype) = '{
  cmp= (a, a) -> int
} // end of [ordmod]

extern
fun{a:t@ype}
ordmod_compare
  (ord: ordmod (a), x: a, y: a): int
// end of [ordmod_compare]

implement{a}
ordmod_compare (ord, x, y) = ord.cmp (x, y)

(* ****** ****** *)

abstype set (a:t@ype)

typedef
setmod (a:t@ype) =
'{
  sing= (a) -<cloref1> set (a)
, isemp= (set a) -<cloref1> bool
, union= (set a, set a) -<cloref1> set (a)
} // end of [setmod]

extern
fun{a:t@ype}
setmod_make_order (ord: ordmod (a)): setmod (a)

local

assume set (a:t@ype) = List0 (a)

in (* in of [local] *)

implement{a}
setmod_make_order (ord) = let
//
fun
funion
(
  ord: ordmod a, xs: List0 a, ys: List0 a
) :<cloref1> List0 a =
 case+ xs of
 | list_cons (x, xs1) =>
   (
     case+ ys of
     | list_cons (y, ys1) => let
         val sgn = ordmod_compare (ord, x, y)
       in
         if sgn <= 0
           then list_cons (x, funion (ord, xs1, ys))
           else list_cons (y, funion (ord, xs, ys1))
         // end of [if]
       end // end of [list_cons]
     | list_nil () => xs
   )
 | list_nil () => ys
//
in '{
  sing= lam (x) => list_sing (x)
, isemp= lam (xs) => list_is_nil (xs)
, union= lam (xs, ys) => funion (ord, xs, ys)
} end // end of [setmod_make_order]

end // end of [local]

(* ****** ****** *)

val setmod_int =
setmod_make_order<int> '{ cmp = lam (x, y) => compare (x, y) }

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [ordset.dats] *)
