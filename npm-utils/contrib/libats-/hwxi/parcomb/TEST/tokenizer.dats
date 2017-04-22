(* ****** ****** *)
/*
HX:
For testing parcomb
*/
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
staload "./../SATS/parcomb.sats"
staload _ = "./../DATS/parcomb.dats"
//
(* ****** ****** *)

#define :: list_cons
#define i2c int2char0

(* ****** ****** *)
//
fun
idfst_test
  (i: int): bool =
(
  isalpha(i) orelse i2c(i) = '_'
)
fun
idrst_test
  (i: int): bool =
(
  isalnum(i) orelse i2c(i) = '_'
)
//
fun
idfst_parser
(
p0: parser(int, int)
) : parser(int, int) =
  sat_parser_fun(p0, idfst_test)
fun
idrst_parser
(
p0: parser(int, int)
) : parser(int, int) =
  sat_parser_fun(p0, idrst_test)
//  
(* ****** ****** *)

local
//
fun
ident_make
(
  c: int, cs: List0(int)
) : string = let
  val cs =
    list_map_fun<int><char>(c::cs, lam c => i2c(c))
  val ident =
    string_make_list($UN.castvwtp1{List0(charNZ)}(cs))
  val ((*freed*)) = list_vt_free<char>(cs)
in
  strnptr2string(ident)
end // end of [ident_make]
//
in
//
fun
ident_parser
(
p0: parser(int, int)
) : parser(int, string) =
(
seq2wth_parser_fun
  (idfst_parser(p0), list0_parser(idrst_parser(p0)), ident_make)
) (* end of [seq2wth_parser_fun] *)
//
end // end of [local]

(* ****** ****** *)

fun
digit_parser
(
p0: parser(int, int)
) : parser(int, int) =
(
seq1wth_parser_fun
  (sat_parser_fun(p0, lam i => isdigit(i)), lam i => i2c(i)-'0')
) (* end of [digit_parser] *)

(* ****** ****** *)

local

fun
int_of_digits
(
  xs: List0(int)
) : int = let
//
implement
list_foldleft$fopr<int><int>
  (acc, x) = 10 * acc + x
//
in
  list_foldleft<int><int> (xs, 0)
end // end of [int_of_digits]

in (* in-of-local *)
//
fun
integer_parser
(
p0: parser(int, int)
) : parser(int, int) =
  seq1wth_parser_fun(list1_parser(digit_parser(p0)), int_of_digits)
//
end // end of [local]

(* ****** ****** *)

fun
spechar_parser
(
p0: parser(int, int)
) : parser(int, int) =
  sat_parser_fun(p0, lam i => i >= 0)

(* ****** ****** *)
//
datatype token =
  | TOKide of string
  | TOKint of (int)
  | TOKspchr of (char)
//
(* ****** ****** *)
//
extern
fun
fprint_token
  (out: FILEref, tok: token): void
overload fprint with fprint_token
//
implement
fprint_token
  (out, tok) =
(
case+ tok of
| TOKide(x) => fprint! (out, "TOKide(", x, ")")
| TOKint(x) => fprint! (out, "TOKint(", x, ")")
| TOKspchr(x) => fprint! (out, "TOKspchr(", x, ")")
)
//
implement
fprint_val<token> = fprint_token
//
(* ****** ****** *)
//
fun
token_parser
(
p0: parser(int, int)
) : parser(int, token) =
(
//
seq1wth_parser_fun
  (ident_parser(p0), lam x => TOKide(x)) ||
seq1wth_parser_fun
  (integer_parser(p0), lam x => TOKint(x)) ||
seq1wth_parser_fun
  (spechar_parser(p0), lam x => TOKspchr(i2c(x)))
//
) (* end of [token_parser] *)
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)
//
fun
cstream_gen
(
// argless
) : stream(int) =
  $delay(stream_cons(getchar0(), cstream_gen()))
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val ts0 = cstream_gen()
//
val ptok =
token_parser(any_parser<int>())
//
val ptoklst = list0_parser(ptok)
//
val toks = parser_apply_stream(ptoklst, ts0)
//
val out = stdout_ref
val ((*void*)) = fprintln!(out, "toks = ", toks)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tokenizer] *)
