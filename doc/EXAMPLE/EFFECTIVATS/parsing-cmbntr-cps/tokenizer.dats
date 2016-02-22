(* ****** ****** *)
(*
** For testing kparser
*)
(* ****** ****** *)
(*
//
// For use in Effective ATS
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
#include
"{$LIBATSHWXI}/teaching/kparcomb/HATS/kparcomb.hats"
//
(* ****** ****** *)
//
datatype token =
  | TOKeof of () // end-of-file
  | TOKint of int // integer
  | TOKident of string // identifier
  | TOKspchr of char // special char
  | TOKcomment of () // comment
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
| TOKeof() => fprint! (out, "TOKeof(", ")")
| TOKint(x) => fprint! (out, "TOKint(", x, ")")
| TOKident(x) => fprint! (out, "TOKident(", x, ")")
| TOKspchr(x) => fprint! (out, "TOKspchr(", x, ")")
| TOKcomment() => fprint! (out, "TOKcomment(", ")")
)
//
(* ****** ****** *)

stadef kp = kparser

(* ****** ****** *)

assume
parinp_type = List0(char)

(* ****** ****** *)

val
kp_eof =
kparser_encode
  {int}(
//
lam(inp, kont) =>
(
  case+ inp of
  | nil() => kont(0, inp) | cons(c, inp2) => $raise ParFailExn()
)
//
) (* kparser_encode *)

(* ****** ****** *)

implement
{}(*tmp*)
kparser_char
  ((*void*)) =
kparser_encode
  {char}(
//
lam(inp, kont) =>
(
  case+ inp of
  | cons(c, inp2) => kont(c, inp2) | nil() => $raise ParFailExn()
)
//
) (* kparser_char *)

(* ****** ****** *)
//
val
kp_alpha = kparser_alpha()
val
kp_alnum = kparser_alnum()
val
kp_digit = kparser_digit()
//
(* ****** ****** *)
//
extern
fun
charlst2int : List0(char) -> int
extern
fun
charlst2str : List0(char) -> string
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
typedef charlst = List0(char)
//
(* ****** ****** *)
//
val
kp_int =
kparser_fmap<charlst><int>
(
  kparser_repeat1(kp_digit), lam(cs) => charlst2int(cs)
)
//
val
kp_ident = // parsing identifiers
kparser_fmap2<char,charlst><string>
( kp_alpha
, kparser_repeat0(kp_alnum), lam(c, cs) => charlst2str(cons(c, cs))
)
//
val kp_spchr = kparser_char<>((*void*))
//
(* ****** ****** *)

val
kp_comment = let
//
fun
aux1
(
  l0: int
, cs: parinp
, kont: parcont(int)
) : parout =
(
case+ cs of
| nil() =>
  kont(0, cs)
| cons (c, cs) =>
  (
    case+ c of
    | '*' =>
       aux21 (l0, cs, kont)
    | '\(' =>
       aux22 (l0, cs, kont)
    |  _  => aux1 (l0, cs, kont)
  )
)
//
and
aux21
(
  l0: int
, cs: parinp
, kont: parcont(int)
) : parout =
(
case+ cs of
| nil() =>
  kont(0, cs)
| cons (c, cs) =>
  (
    case+ c of
    | ')' => let
        val l0 = l0 - 1
      in
        if l0 > 0 then aux1 (l0, cs, kont) else kont(0, cs)
      end // end of ...
    |  _ => aux1 (l0, cs, kont)
  )
)
//
and
aux22
(
  l0: int
, cs: parinp
, kont: parcont(int)
) : parout =
(
case+ cs of
| nil() =>
  kont(0, cs)
| cons (c, cs) =>
  (
    case+ c of
    | '*' =>
      (
        aux1 (l0+1, cs, kont)
      )
    |  _  => aux1 (l0, cs, kont)
  )
)
//
val
kp_comment_rest =
kparser_encode{int}
(
lam(inp, kont) => aux1(0, inp, kont)
)
//
in
  kparser_literal("(*") >> kp_comment_rest
end // end of [val]

(* ****** ****** *)
//
val
kp_TOKeof =
kparser_fmap(kp_eof, lam(x) => TOKeof())
//
val
kp_TOKint =
kparser_fmap(kp_int, lam(x) => TOKint(x))
//
val
kp_TOKident =
kparser_fmap(kp_ident, lam(x) => TOKident(x))
//
val
kp_TOKspchr =
kparser_fmap(kp_spchr, lam(x) => TOKspchr(x))
//
val
kp_TOKcomment =
kparser_fmap(kp_comment, lam(x) => TOKcomment())
//
(* ****** ****** *)
//
symintr ||
overload || with kparser_orelse
//
(* ****** ****** *)
//
val
kp_token =
kp_TOKint || kp_TOKident ||
kp_TOKcomment || kp_TOKspchr || kp_TOKeof
//
(* ****** ****** *)

assume
parout_type = stream_con(token)

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
  kp_token(cs, lam(tok, inp) => stream_cons(tok, tokenizer(inp)))
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
