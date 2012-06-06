(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)

staload "libatsyntax/SATS/libatsyntax.sats"

(* ****** ****** *)

staload
LOC = "src/pats_location.sats"
assume location = $LOC.location

implement
fprint_location
  (out, x) = $LOC.fprint_location (out, x)
// end of [fprint_location]

(* ****** ****** *)

staload
LBF = "src/pats_lexbuf.sats"

staload
LEX = "src/pats_lexing.sats"
assume token = $LEX.token // ...

implement
token_get_loc (x) = x.token_loc

implement
fprint_token
  (out, x) = $LEX.fprint_token (out, x)
// end of [fprint_token]

implement
token_is_eof (x) =
  case+ x.token_node of
  | $LEX.T_EOF () =>true | _ => false
// end of [token_is_eof]

(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"
macdef fgetc0_err = $STDIO.fgetc0_err

implement
fileref_get_tokenlst
  (inp) = let
//
viewtypedef res = tokenlst_vt
viewtypedef lexbuf = $LEX.lexbuf
//
fun loop (
  buf: &lexbuf, res: &res? >> res
) : void = let
  val tok = $LEX.lexing_next_token (buf)
  val iseof = token_is_eof (tok)
in
  if iseof then
    res := list_vt_nil ()
  else let
    val () = res :=
      list_vt_cons {token}{0} (tok, ?)
    val+ list_vt_cons (_, !p_res1) = res
    val () = loop (buf, !p_res1)
    prval () = fold@ (res)
  in
    // nothing
  end // end of [if]
end (* end of [loop] *)
//
var buf: lexbuf
val getc =
  lam () =<cloptr1> fgetc0_err (inp)
val () = $LBF.lexbuf_initialize_getc (buf, getc)
var res: res
val () = loop (buf, res)
val () = $LBF.lexbuf_uninitialize (buf)
in
  res
end // end of [fileref_get_tokenlst]

(* ****** ****** *)

(* end of [libatsyntax.dats] *)
