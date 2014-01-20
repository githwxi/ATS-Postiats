(*
** FALCON project
*)

(* ****** ****** *)
  
staload "./falcon.sats"
  
(* ****** ****** *)

datatype token =
  | TOKide of string
  | TOKand of () | TKor of ()
  | TOKlpar of () | TOKrpar of ()
  | TOKeof of ()

(* ****** ****** *)

fun lexingbuf_get_token (lxbf: !lexingbuf): token

(* ****** ****** *)

(* end of [falcon_parsing.dats] *)
