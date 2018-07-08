(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-08-04: start
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../SATS/catsparse.sats"
staload "./../SATS/catsparse_syntax.sats"
//
(* ****** ****** *)
//
staload "./../SATS/catsparse_emit.sats"
//
(* ****** ****** *)

implement
emit_ENDL(out) = emit_text(out, "\n")

(* ****** ****** *)

implement
emit_SPACE(out) = emit_text(out, " ")

(* ****** ****** *)

implement
emit_DOT(out) = emit_text(out, ".")

(* ****** ****** *)
//
implement
emit_COLON(out) = emit_text(out, ":")
//
implement
emit_COMMA(out) = emit_text(out, ",")
//
implement
emit_SEMICOLON(out) = emit_text(out, ";")
//
(* ****** ****** *)

implement
emit_AMPER(out) = emit_text(out, "&")

(* ****** ****** *)

implement
emit_SHARP(out) = emit_text(out, "#")

(* ****** ****** *)

implement
emit_DOLLAR(out) = emit_text(out, "$")

(* ****** ****** *)

implement
emit_SQUOTE(out) = emit_text(out, "'")
implement
emit_DQUOTE(out) = emit_text(out, "\"")

(* ****** ****** *)
//
implement
emit_LPAREN(out) = emit_text(out, "(")
implement
emit_RPAREN(out) = emit_text(out, ")")
//
implement
emit_LBRACKET(out) = emit_text(out, "[")
implement
emit_RBRACKET(out) = emit_text(out, "]")
//
implement
emit_LBRACE(out) = emit_text(out, "{")
implement
emit_RBRACE(out) = emit_text(out, "}")
//
(* ****** ****** *)

implement
emit_MINUSGT(out) = emit_text(out, "->")

(* ****** ****** *)

implement
emit_flush(out) = fileref_flush(out)
implement
emit_newline(out) = fprint_newline(out)

(* ****** ****** *)
//
implement
emit_nspc(out, ind) =
(
//
if
(ind > 0)
then
(
  emit_text(out, " "); emit_nspc(out, ind-1)
) (* end of [if] *)
//
) (* end of [emit_nspc] *)
//
(* ****** ****** *)
//
implement
emit_int(out, x) = fprint_int(out, x)
//
implement
emit_char(out, x) = fprint_char(out, x)
//
implement
emit_text(out, x) = fprint_string(out, x)
//
(* ****** ****** *)
//
implement
emit_symbol(out, x) =
  fprint_string(out, symbol_get_name(x))
//
(* ****** ****** *)
//
implement
emit_i0de
  (out, id) = emit_symbol(out, id.i0dex_sym)
implement
emit_label
  (out, lab) = emit_symbol(out, lab.i0dex_sym)
//
(* ****** ****** *)

implement
emit_tokenlst
  (out, toks) = let
//
fun
auxtok
(
  out: FILEref, tok: token
) : void =
(
case+
tok.token_node of
//
| T_KWORD _ => ()
//
| T_ENDL() => emit_ENDL(out)
| T_SPACES(cs) => emit_text(out, cs)
//
| T_COMMENT_line _ => emit_COMMENT_line(out, tok)
| T_COMMENT_block _ => emit_COMMENT_block(out, tok)
//
| T_INT(_, rep) => emit_text(out, rep)
| T_FLOAT(_, rep) => emit_text(out, rep)
//
| T_STRING(str) => emit_text(out, str)
//
| T_IDENT_alp(name) =>
  (
    emit_text(out, name)
  ) (* end of [T_IDENT_alp] *)
| T_IDENT_srp(name) =>
  (
    emit_SHARP(out); emit_text(out, name)
  ) (* end of [T_IDENT_srp] *)
//
| T_IDENT_sym(name) => emit_text(out, name)
//
| T_LPAREN() => emit_LPAREN(out)
| T_RPAREN() => emit_RPAREN(out)
//
| T_LBRACKET() => emit_LBRACKET(out)
| T_RBRACKET() => emit_RBRACKET(out)
//
| T_LBRACE() => emit_LBRACE(out)
| T_RBRACE() => emit_RBRACE(out)
//
| T_LT((*void*)) => emit_text(out, "<")
| T_GT((*void*)) => emit_text(out, ">")
//
| T_MINUS() => emit_text(out, "-")
//
| T_COLON() => emit_text(out, ":")
//
| T_COMMA() => emit_text(out, ",")
| T_SEMICOLON() => emit_text(out, ";")
//
| T_SLASH() => emit_text(out, "/")
//
| _ (*unrecognized*) =>
  {
    val () = fprint!(out, "TOKERR(", tok, ")")
  }
) (* end of [auxtok] *)
//
in
//
case+ toks of
| list_nil () => ()
| list_cons (tok, toks) =>
  (
    auxtok (out, tok); emit_extcode (out, toks)
  ) (* end of [list_cons] *)
//
end // end of [emit_tokenlst]

(* ****** ****** *)
//
implement
emit_extcode
  (out, toks) = emit_tokenlst (out, toks)
//
(* ****** ****** *)

(* end of [catsparse_emit.dats] *)
