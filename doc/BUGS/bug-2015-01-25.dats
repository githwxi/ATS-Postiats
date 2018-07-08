(*
** Bug causing infinite recursion
** during the process of code emission.
*)

(* ****** ****** *)

(*
** Source: Reported by MD-2015-01-25
*)

(* ****** ****** *)
//
// Status: HX-2015-01-30: it is fixed!
// Please see: pats_typerase.dats:s2zexp_tyer
//
(* ****** ****** *)

implement
main () =
  let val a = g1int2uint 5 in 1 end
// end of [main]

(* ****** ****** *)

(* end of [bug-2015-01-25.dats] *)
