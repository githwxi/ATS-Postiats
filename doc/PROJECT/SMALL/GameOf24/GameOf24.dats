//
// Implementing Game-of-24
//

(* ****** ****** *)

staload "GameOf24.sats"

(* ****** ****** *)

dynload "GameOf24_card.dats"
dynload "GameOf24_cardset.dats"
dynload "GameOf24_solve.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val () = minit_gc() // initializing memalloc-system
//
val n1 = 3
and n2 = 3
and n3 = 8
and n4 = 8
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val () = fprintln! (out, "play24(", n1, ", ", n2, ", ", n3, ", ", n4, "):")
val () = (fpprint_cardlst (out, res); fprint_newline (out))
//
val n1 = 4
and n2 = 4
and n3 = 10
and n4 = 10
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val () = fprintln! (out, "play24(", n1, ", ", n2, ", ", n3, ", ", n4, "):")
val () = (fpprint_cardlst (out, res); fprint_newline (out))
//
val n1 = 5
and n2 = 5
and n3 = 7
and n4 = 11
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val () = fprintln! (out, "play24(", n1, ", ", n2, ", ", n3, ", ", n4, "):")
val () = (fpprint_cardlst (out, res); fprint_newline (out))
//
val n1 = 3
and n2 = 5
and n3 = 7
and n4 = 13
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val () = fprintln! (out, "play24(", n1, ", ", n2, ", ", n3, ", ", n4, "):")
val () = (fpprint_cardlst (out, res); fprint_newline (out))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [GameOf24.dats] *)
