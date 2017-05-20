(* ****** ****** *)
//
// HX-2016-07:
// A running example
// from ATS2 to Clojure
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2CLJ_targetloc
"$PATSHOME\
/contrib/libatscc2clj/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2CLJ}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
listlen{a:t0p}
  : List0 (a) -> int = "mac#listlen"
//
implement
listlen{a}
  (xs) = let
//
prval
(
// argless
) = lemma_list_param (xs)
//
fun
loop{i,j:nat} .<i>.
(
  xs: list (a, i), res: int(j)
) : int(i+j) = let
in
//
case+ xs of
| list_nil () => res
| list_cons (_, xs) => loop (xs, res+1)
//
end // end of [loop]
//
in
  loop (xs, 0)
end // end of [listlen]

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
main0_ats
(
// argumentless
) : void = "mac#listlen_main0_ats"
//
implement
main0_ats () =
{
//
val () = println!
(
  "listlen(fromto(0, 10)) = ", listlen(fromto(0, 10))
) (* end of [val] *)
//
} (* end of [main0_ats] *)
//
(* ****** ****** *)

%{$
;;
(listlen_main0_ats)
;;
%} // end of [%{]

(* ****** ****** *)

(* end of [listlen.dats] *)
