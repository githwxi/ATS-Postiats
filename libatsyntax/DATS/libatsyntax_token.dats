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

staload UN = "prelude/SATS/unsafe.sats"

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

(* ****** ****** *)

implement
token_get_loc (x) = x.token_loc

local

staload "src/pats_lexing.sats"

in // in of [local]

(* ****** ****** *)

implement
token_is_eof (x) =
  case+ x.token_node of
  | T_EOF () => true | _ => false
// end of [token_is_eof]

(* ****** ****** *)

implement
token_is_comment (x) =
  case+ x.token_node of
  | T_COMMENT_line () => true
  | T_COMMENT_block () => true
  | T_COMMENT_rest () => true
  | _ => false
// end of [token_is_comment]

implement
token_is_extcode (x) =
  case+ x.token_node of
  | T_EXTCODE (_) => true | _ => false
// end of [token_is_extcode]

(* ****** ****** *)

implement
token_is_keyword (x) = let
in
//
case+
  x.token_node of
//
(*
| T_AT () => true
//
| T_BACKSLASH () => true
| T_BANG () => true
| T_BAR () => true
| T_BQUOTE () => true
//
| T_COLON () => true
| T_COLONLT () => true
//
| T_DOLLAR () => true
//
| T_DOT () => true
| T_DOTDOT () => true
| T_DOTDOTDOT () => true
//
| T_DOTINT (_) => true
//
| T_EQ () => true
| T_EQGT () => true
| T_EQLT () => true
| T_EQLTGT () => true
| T_EQSLASHEQGT () => true
| T_EQGTGT () => true
| T_EQSLASHEQGTGT () => true
//
| T_HASH () => true
//
| T_GTLT () => true
| T_DOTLT () => true
| T_GTDOT () => true
| T_DOTLTGTDOT () => true
//
| T_MINUSGT () => true
| T_MINUSLT () => true
| T_MINUSLTGT () => true
//
| T_ABSTYPE _ => true
| T_AND () => true
| T_AS () => true
| T_ASSUME () => true
| T_BEGIN () => true
| T_BRKCONT (_) => true
| T_CASE _ => true
| T_CLASSDEC () => true
| T_DATASORT () => true
| T_DATATYPE (_) => true
| T_DO () => true
| T_DYNLOAD () => true
| T_ELSE () => true
| T_END () => true
| T_EXCEPTION () => true
| T_EXTERN () => true
| T_EXTYPE () => true
| T_EXTVAL () => true
| T_FIX (_) => true
| T_FIXITY (_) => true
| T_FOR (_) => true
| T_FUN (_) => true
| T_IF () => true
| T_IMPLEMENT () => true
| T_IN () => true
| T_LAM (_) => true
| T_LET () => true
| T_LOCAL () => true
| T_MACDEF (_) => true
| T_NONFIX () => true
| T_OVERLOAD () => true
| T_OF () => true
| T_OP () => true
| T_REC () => true
| T_REFAT () => true
| T_SCASE () => true
| T_SIF () => true
| T_SORTDEF () => true
| T_STACST () => true
| T_STADEF () => true
| T_STALOAD () => true
| T_SYMELIM () => true
| T_SYMINTR () => true
| T_THEN () => true
| T_TKINDEF () => true
| T_TRY () => true
| T_TYPE (_) => true
| T_TYPEDEF (_) => true
| T_VAL (_) => true
| T_VAR () => true
| T_WHEN () => true
| T_WHERE () => true
| T_WHILE (_) => true
| T_WITH () => true
| T_WITHTYPE (_) => true
//
| T_ADDRAT () => true
| T_FOLDAT () => true
| T_FREEAT () => true
| T_VIEWAT () => true
//
| T_DLRARRSZ () => true
| T_DLRDYNLOAD () => true
| T_DLRDELAY (_) => true
| T_DLREFFMASK () => true
| T_DLREFFMASK_ARG (_) => true
| T_DLREXTERN () => true
| T_DLREXTKIND () => true
| T_DLREXTYPE () => true
| T_DLREXTYPE_STRUCT () => true
| T_DLREXTVAL () => true
| T_DLRRAISE () => true
| T_DLRLST (_) => true
| T_DLRREC (_) => true
| T_DLRTUP (_) => true
//
| T_SRPASSERT () => true
| T_SRPDEFINE () => true
| T_SRPELIF () => true
| T_SRPELIFDEF () => true
| T_SRPELIFNDEF () => true
| T_SRPELSE () => true
| T_SRPENDIF () => true
| T_SRPERROR () => true
| T_SRPIF () => true
| T_SRPIFDEF () => true
| T_SRPIFNDEF () => true
| T_SRPINCLUDE () => true
| T_SRPPRINT () => true
| T_SRPTHEN () => true
| T_SRPUNDEF () => true
//
| T_SRPFILENAME () => true
| T_SRPLOCATION () => true
//
| T_LPAREN () => true
| T_RPAREN () => true
| T_LBRACKET () => true
| T_RBRACKET () => true
| T_LBRACE () => true
| T_RBRACE () => true
//
| T_COMMA () => true
| T_SEMICOLON () => true
//
| T_ATLPAREN () => true
| T_QUOTELPAREN () => true
| T_ATLBRACKET () => true
| T_QUOTELBRACKET () => true
| T_HASHLBRACKET () => true
| T_ATLBRACE () => true
| T_QUOTELBRACE () => true
//
| T_BQUOTELPAREN () => true
| T_COMMALPAREN () => true
| T_PERCENTLPAREN () => true
//
*)
//
| T_NONE () => false
| T_LT () => false
| T_GT () => false
| T_TILDE () => false
//
| T_IDENT_alp (_) => false
| T_IDENT_sym (_) => false
| T_IDENT_arr (_) => false
| T_IDENT_tmp (_) => false
| T_IDENT_dlr (_) => false
| T_IDENT_srp (_) => false
| T_IDENT_ext (_) => false
//
| T_CHAR (_) => false
| T_INTEGER _ => false
| T_FLOAT _ => false
| T_STRING (_) => false
//
| T_EXTCODE (_) => false
//
| T_COMMENT_line () => false
| T_COMMENT_block () => false
| T_COMMENT_rest () => false
//
| T_ERR () => false
//
| T_EOF () => false
//
| _ => true
//
end // end of [token_is_keyword]

(* ****** ****** *)

implement
token_is_char (x) =
  case+ x.token_node of
  | T_CHAR (_) => true | _ => false
// end of [token_is_char]
implement
token_is_float (x) =
  case+ x.token_node of
  | T_FLOAT _ => true | _ => false
// end of [token_is_float]
implement
token_is_integer (x) =
  case+ x.token_node of
  | T_INTEGER _ => true | _ => false
// end of [token_is_integer]
implement
token_is_string (x) =
  case+ x.token_node of
  | T_STRING (_) => true | _ => false
// end of [token_is_string]

end // end of [local]

(* ****** ****** *)

implement
fprint_token
  (out, x) = $LEX.fprint_token (out, x)
// end of [fprint_token]

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
//
in
  res
end // end of [fileref_get_tokenlst]

(* ****** ****** *)

(* end of [libatsyntax_token.dats] *)
