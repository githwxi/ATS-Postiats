(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Node.js
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
implement
list_map (xs, f) =
(
case+ xs of
| list_nil () => list_nil ()
| list_cons (x, xs) =>
    list_cons (f(x), list_map (xs, f))
) (* end of [list_map] *)
//
(* ****** ****** *)
//
extern
fun
fromto
  : (int, int) -> List0 (int) = "mac#fromto"
//
implement
fromto (m, n) =
if m < n
  then list_cons (m, fromto (m+1, n)) else list_nil ()
// end of [if]
//
(* ****** ****** *)
//
extern
fun
mytest
  : (int, int) -> List0(int) = "mac#mytest"
//
implement
mytest(m, n) = let
  val xs = fromto (m, n)
in
  list_map{int}{int} (xs, lam x => m * n * x)
end // end of [mytest]
//
(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./libatscc2js/CATS/basics_cats.js').toString());
eval(fs.readFileSync('./libatscc2js/CATS/integer_cats.js').toString());
%} // end of [%{^]

(* ****** ****** *)

%{$
//
console.log("mytest(5, 10) =", mytest(5, 10))
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [listmap.dats] *)
