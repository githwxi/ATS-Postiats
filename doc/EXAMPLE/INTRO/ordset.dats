(* ****** ****** *)
(*
// Implementing a module of ML-style
*)
(* ****** ****** *)
(*
//
// Author: Hongwei Xi
// TIme: the 4th of June, 2013
// Authoremail: gmhwxi AT gmail DOT edu
//
*)
(* ****** ****** *)
(*
//
##myatsccdef=\
curl --data-urlencode mycode@$1 \
http://www.ats-lang.org/SERVER/MYCODE/atslangweb_patsopt_tcats_0_.php | \
php -R 'if (\$argn != \"\") echo(json_decode(urldecode(\$argn))[1].\"\\n\");'
//
*)
(* ****** ****** *)

staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

typedef
ordmod (a:t@ype) = '{ cmp= (a, a) -> int }

extern
fun{a:t@ype}
ordmod_compare (ord: ordmod (a), x: a, y: a): int

implement{a}
ordmod_compare (ord, x, y) = ord.cmp (x, y)

(* ****** ****** *)

abstype set (a:t@ype) = ptr

typedef
setmod (a:t@ype) =
'{
  sing= (a) -<cloref1> set (a)
, isemp= set(a) -<cloref1> bool
, union= (set(a), set(a)) -<cloref1> set (a)
, toList= set(a) -<cloref1> List0 (a)
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
  ord: ordmod a
, xs: List0 a, ys: List0 a
) :<cloref1> List0 a =
 case+ xs of
 | list_cons (x, xs1) =>
   (
     case+ ys of
     | list_cons (y, ys1) => let
         val sgn =
           ordmod_compare<a> (ord, x, y)
       in
         if sgn < 0 then
         (
           cons{a}(x, funion (ord, xs1, ys))
         ) else (
           if sgn > 0
           then
             cons{a}(y, funion (ord, xs, ys1))
           else 
             cons{a}(x, funion (ord, xs1, ys1))
           // end of [if]
         ) // end of [if]
       end // end of [list_cons]
     | list_nil ((*void*)) => xs
   )
 | list_nil ((*void*)) => ys
//
in '{
  sing= lam (x) => cons{a}(x, nil)
, isemp= lam (xs) => list_is_nil (xs)
, union= lam (xs, ys) => funion (ord, xs, ys)
, toList= lam (xs) => xs
} end // end of [setmod_make_order]

end // end of [local]

(* ****** ****** *)

val setmod_int =
setmod_make_order<int> '{ cmp = lam (x:int, y:int) => compare (x, y) }

(* ****** ****** *)

val xs0 = setmod_int.sing (0)
val xs1 = setmod_int.sing (1)
val xs01 = setmod_int.union (xs0, xs1)
val xs0101 = setmod_int.union (xs01, xs01)

(* ****** ****** *)

val () = println! ("xs01 = ", setmod_int.toList(xs01))
val () = println! ("xs0101 = ", setmod_int.toList(xs0101))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [ordset.dats] *)
