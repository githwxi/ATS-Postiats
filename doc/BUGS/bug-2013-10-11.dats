(*
** ATS_DYNLOADFLAG not respected
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

extern fun fact (x: int): int

(* ****** ****** *)
//
implement
fact (x) = if x > 0 then x * fact (x-1) else 1
//
(* ****** ****** *)

(* end of [bug-2013-10-11.dats] *)
