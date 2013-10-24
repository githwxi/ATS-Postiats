(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload ACKER = "acker.sats"

(* ****** ****** *)

implement
$ACKER.acker (m, n) = let
//
fun acker
  (m: int, n:int): int = 
  if m > 0 then
    if n > 0 then acker (m-1, acker (m, n-1)) else acker (m-1, 1)
  else n+1 // end of [if]
//
in
  acker (m, n)
end // end of [$ACKER.acker]

(* ****** ****** *)

(* end of [acker2.dats] *)
