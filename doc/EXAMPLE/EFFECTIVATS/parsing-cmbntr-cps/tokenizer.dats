(* ****** ****** *)
(*
** For testing kparser
*)
(* ****** ****** *)
(*
//
// For use in Effiective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/teaching/kparcomb/SATS/kparcomb.sats"
//
#include
"{$LIBATSHWXI}/teaching/kparcomb/DATS/kparcomb.dats"
//
(* ****** ****** *)
//
datatype token =
  | TOKeof of ()
  | TOKint of int
  | TOKident of string
  | TOKspchr of char
//
(* ****** ****** *)
//
extern
fun
fprint_token : fprint_type(token)
overload fprint with fprint_token
//
implement
fprint_token
  (out, tok) =
(
case+ tok of
| TOKeof() => fprint! (out, "TOKeof()")
| TOKint(x) => fprint! (out, "TOKint(", x, ")")
| TOKident(x) => fprint! (out, "TOKident(", x, ")")
| TOKspchr(x) => fprint! (out, "TOKspchr(", x, ")")
)
//
(* ****** ****** *)

stadef kp = kparser

(* ****** ****** *)

assume parinp_type = List0(char)

(* ****** ****** *)

val
kp_eof =
kparser_encode{int}(
//
lam(inp, kont) =>
(
  case+ inp of
  | nil() => kont(inp, 0)
  | cons(c, inp2) => $raise ParFailExn(*void*)
)
//
) (* kparser_encode *)

(* ****** ****** *)

val
kp_char =
kparser_encode{char}(
//
lam(inp, kont) =>
(
  case+ inp of
  | cons(c, inp2) => kont(inp2, c)
  | nil() => $raise ParFailExn(*void*)
)
//
) (* kparser_encode *)

(* ****** ****** *)
//
val
kp_alpha =
  kparser_satisfy(kp_char, lam(c) => isalpha(c))
//
(* ****** ****** *)
//
val
kp_alnum =
  kparser_satisfy(kp_char, lam(c) => isalnum(c))
//
(* ****** ****** *)
//
val
kp_digit =
  kparser_satisfy(kp_char, lam(c) => isdigit(c))
//
(* ****** ****** *)
//
extern
fun
charlst2int : List1(char) -> int
extern
fun
charlst2str : List1(char) -> string
//
(* ****** ****** *)

implement
charlst2int
  (cs) = loop(cs, 0) where
{
//
fun
loop(cs: List0(char), res: int): int =
  case+ cs of
  | nil() => res
  | cons(c, cs) => loop(cs, 10*res+(c-'0'))
//
} (* end of [charlst2int] *)

(* ****** ****** *)

implement
charlst2str(cs) =
strnptr2string
  (string_make_list($UN.cast{List0(charNZ)}(cs)))

(* ****** ****** *)
//
val
kp_int =
kparser_seq1wth
(
  kparser_repeat1(kp_digit)
, lam(cs) => charlst2int(cs)
)
//
val
kp_ident =
kparser_seq2wth
( kp_alpha
, kparser_repeat0(kp_alnum)
, lam(c, cs) => charlst2str(cons(c, cs))
)
//
val kp_spchr = kp_char
//
(* ****** ****** *)
//
val
kp_TOKeof =
kparser_seq1wth(kp_eof, lam(x) => TOKeof())
val
kp_TOKint =
kparser_seq1wth(kp_int, lam(x) => TOKint(x))
val
kp_TOKident =
kparser_seq1wth(kp_ident, lam(x) => TOKident(x))
val
kp_TOKspchr =
kparser_seq1wth(kp_spchr, lam(x) => TOKspchr(x))
//
(* ****** ****** *)
//
val
kp_token =
kparser_alter
( kp_TOKint
, kparser_alter
  ( kp_TOKident
  , kparser_alter(kp_TOKspchr, kp_TOKeof)
  )
)
//
(* ****** ****** *)

assume parout_vtype = stream_con(token)

(* ****** ****** *)

fun
tokenizer
(
  cs: List0(char)
) : stream(token) = let
//
val
kp_token = kparser_decode(kp_token)
//
in
//
$delay
(
//
case+ cs of
| nil() =>
  stream_nil()
| cons _ =>
  kp_token(cs, lam(inp, tok) => stream_cons(tok, tokenizer(inp)))
//
) : stream_con(token)
//
end // end of [tokenizer]

(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println!
  ("Hello from [tokenizer]!")
//
val inp = stdin_ref
val out = stdout_ref
//
val cs0 =
  fileref_get_file_charlst(inp)
//
val toks = tokenizer(list_vt2t(cs0))
//
fun
loop
(
  toks: stream(token)
) : void =
(
case+ !toks of
| stream_nil() => ()
| stream_cons(tok, toks) =>
    (fprintln! (out, "token = ", tok); loop(toks))
)
//
val () = loop(toks)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tokenizer.dats] *)
