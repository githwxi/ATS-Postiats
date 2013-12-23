(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload "acker.sats"

(* ****** ****** *)

staload ACKER = "acker.sats"

implement $ACKER.acker
  (m, n) = acker (m, n) where {
  fun acker (m: int, n:int): int = 
    if m > 0 then
      if n > 0 then acker (m-1, acker (m, n-1))
      else acker (m-1, 1)
    else n+1
} // end of [$ACKER.acker]

(* ****** ****** *)

(* end of [acker2.dats] *)
