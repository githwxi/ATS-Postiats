(*
** Bug causing infinite recursion
** during the process code emission.
*)

(* ****** ****** *)

(*
** Source: Reported by MD-2015-01-25
*)

(* ****** ****** *)
//
//  Status: FIXME!!!
//
(* ****** ****** *)

implement
main () =
  let val a = g1int2uint 5 in 1 end
// end of [main]

(* ****** ****** *)

(* end of [bug-2015-01-25.dats] *)
