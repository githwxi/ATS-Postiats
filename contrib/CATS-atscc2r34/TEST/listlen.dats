(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2R34}/SATS/integer.sats"
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
prval () = lemma_list_param (xs)
//
fun
loop{i,j:nat} .<i>.
(
  xs: list (a, i), res: int(j)
) : int(i+j) = let
in
//
case+ xs of
| list_nil () => res | list_cons (_, xs) => loop (xs, res+1)
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

%{^
######
options(expressions=100000);
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
xs <- fromto(0, 10)
message("listlen(", xs, ") =", listlen(xs))
%} // end of [%{$]

(* ****** ****** *)

(* end of [listlen.dats] *)
