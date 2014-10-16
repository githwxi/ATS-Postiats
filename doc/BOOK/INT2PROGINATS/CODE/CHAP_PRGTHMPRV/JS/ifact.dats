(*
** Some code used
** in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

staload
"{$LIBATSCC2JS}/SATS/print.sats"

(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

(* ****** ****** *)

%{$
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)

dataprop
FACT (int, int) =
  | FACTbas (0, 1)
  | {n:nat}{r1,r:int}
    FACTind (n, r) of (FACT (n-1, r1), MUL (n, r1, r))
// end of [FACT]

(* ****** ****** *)

%{^
function imul2(x, y) { return (x*y) ; }
%}
extern
fun
imul2{i,j:int}
(
  i: int i, j: int j
) :<> [ij:int] (MUL (i, j, ij) | int ij) = "mac#imul2"

(* ****** ****** *)

fun ifact
  {n:nat} .<n>.
  (n: int (n)): [r:int] (FACT (n, r) | int r) =
(
  if n > 0 then let
    val (pf1 | r1) = ifact (n-1) // pf1: FACT (n-1, r1)
    val (pfmul | r) = imul2 (n, r1) // pfmul: FACT (n, r1, r)
  in (
    FACTind (pf1, pfmul) | r
  ) end else (
    FACTbas () | 1 // the base case
  ) // end of [if]
) (* end of [ifact] *)

(* ****** ****** *)

val () = {
  val (pf | res) = ifact (10)
  val () = println! ("ifact(10) = ", res)
} (* end of [val] *)

(* ****** ****** *)

(* end of [ifact.dats] *)
