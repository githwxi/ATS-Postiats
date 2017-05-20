(* ****** ****** *)
//
// HX-2014-11:
// A running example
// from ATS2 to Perl5
//
(* ****** ****** *)
//
#define
LIBATSCC2PL_targetloc
"$PATSHOME\
/contrib/libatscc2pl/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PL}/staloadall.hats"
//
(* ****** ****** *)
//
implement
list_map (xs, f) =
(
case+ xs of
| list_nil () => list_nil ()
| list_cons (x, xs) => list_cons (f(x), list_map (xs, f))
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
mytest : (int, int) -> List0(int) = "mac#mytest"
//
implement
mytest(m, n) = let
  val xs = fromto (m, n)
in
  list_map{int}{int} (xs, lam x => m * n * x)
end // end of [mytest]
//
(* ****** ****** *)

extern
fun
main0_pl : () -> void = "mac#"
implement
main0_pl () =
{
//
val () =
println! ("mytest(5, 10) = ", mytest(5, 10))
//
} (* end of [main0_pl] *)

(* ****** ****** *)

%{^
require "./libatscc2pl/libatscc2pl_all.pl";
%}

(* ****** ****** *)

%{$
main0_pl();
%} // end of [%{$]

(* ****** ****** *)

(* end of [listmap.dats] *)
