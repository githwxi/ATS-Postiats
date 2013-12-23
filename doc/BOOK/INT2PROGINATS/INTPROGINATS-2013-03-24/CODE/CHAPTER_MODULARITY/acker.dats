(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

staload "acker.sats"

implement acker (m, n) =
  if m > 0 then
    if n > 0 then acker (m-1, acker (m, n-1))
    else acker (m-1, 1)
  else n+1
// end of [acker]

(* ****** ****** *)

(* end of [acker.dats] *)
