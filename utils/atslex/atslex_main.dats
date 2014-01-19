(*
** atslex: lexer for ATS
*)

(* ****** ****** *)

staload "./atslex.sats"

(* ****** ****** *)

dynload "atslex.sats"
dynload "atslex_charset.dats"
  
(* ****** ****** *)

implement
main0 () = () where
{
//
val () = println! ("Hello from atslex!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [atslex_main.dats] *)
