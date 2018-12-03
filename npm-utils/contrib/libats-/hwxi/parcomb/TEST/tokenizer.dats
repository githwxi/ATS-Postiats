(* ****** ****** *)
/*
HX:
For testing parcomb
*/
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $PARCOMB // HX: opening it!
//
(* ****** ****** *)

#define i2c int2char0

(* ****** ****** *)

fun
digit_parser
(
p0: parser(int, int)
) : parser(int, int) =
(
seq1wth_parser_fun
(
sat_parser_fun
( p0
, lam i => isdigit(i)), lam i => i2c(i)-'0'
)
) (* end of [digit_parser] *)

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

fun
symbl_test
  (i0: int): bool =
( string_exists
  ("%&+-./:=@~`^|*!?<>#$", lam(c) => c0 = c)
) where
{
  val c0 = i2c(i0)
}
fun
symbl_parser
(
p0: parser(int, int)
) : parser(int, int) =
  sat_parser_fun(p0, symbl_test)

(* ****** ****** *)

local
//
fun
ide_make
(
  c: int, cs: list0(int)
) : string = let
  val cs =
  list0_map<int><char>
  (
  list0_cons(c, cs), lam c => i2c(c)
  )
in
  string_make_list0
  ($UN.castvwtp1{list0(charNZ)}(cs))
end // end of [ide_make]
//
in
//
fun
ide_parser
(
p0: parser(int, int)
) : parser(int, string) =
(
seq2wth_parser_fun
( idfst_parser(p0)
, list0_parser(idrst_parser(p0)), ide_make)
) (* end of [seq2wth_parser_fun] *)
//
end // end of [local]

(* ****** ****** *)

local
//
fun
sym_make
(
cs: list0(int)
) : string = let
  val cs =
  list0_map<int><char>(cs, lam c => i2c(c))
in
  string_make_list0($UN.castvwtp1{list0(charNZ)}(cs))
end // end of [sym_make]
//
in
//
fun
sym_parser
(
p0: parser(int, int)
) : parser(int, string) =
(
seq1wth_parser_fun
  (list1_parser(symbl_parser(p0)), sym_make)
) (* end of [seq1wth_parser_fun] *)
//
end // end of [local]

(* ****** ****** *)

local

fun
int_of_digits
(
  xs: list0(int)
) : int = let
//
in
  list0_foldleft<int><int> (xs, 0, lam(r, x) => 10 * r + x)
end // end of [int_of_digits]

in (* in-of-local *)
//
fun
int_parser
(
p0: parser(int, int)
) : parser(int, int) =
  seq1wth_parser_fun(list1_parser(digit_parser(p0)), int_of_digits)
//
end // end of [local]

(* ****** ****** *)

fun
spc_parser
(
p0: parser(int, int)
) : parser(int, int) =
  sat_parser_fun(p0, lam i => i >= 0)

(* ****** ****** *)
//
datatype token =
  | TOKint of (int)
  | TOKide of string
  | TOKsym of string
  | TOKkwd of string
  | TOKspc of (char)
  | TOKeof of ((*void*))
//
(* ****** ****** *)

fun
ide_is_keywd
(x0: string): bool =
(
ifcase
| x0 = "lam" => true
| x0 = "fix" => true
//
| x0 = "let" => true
| x0 = "in" => true
| x0 = "end" => true
//
| x0 = "ift" => true
| x0 = "then" => true
| x0 = "else" => true
//
| _ (* else *) => false
)

fun
sym_is_keywd
(x0: string): bool =
(
ifcase
//
| x0 = "=" => true
| x0 = "=>" => true
//
| _ (* else *) => false
)

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
| TOKint(x) => fprint! (out, "TOKint(", x, ")")
| TOKide(x) => fprint! (out, "TOKide(", x, ")")
| TOKsym(x) => fprint! (out, "TOKsym(", x, ")")
| TOKkwd(x) => fprint! (out, "TOKkwd(", x, ")")
| TOKspc(x) => fprint! (out, "TOKspc(", x, ")")
| TOKeof( ) => fprint! (out, "TOKeof(",    ")")
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
  ( int_parser(p0)
  , lam x => TOKint(x)) ||
seq1wth_parser_fun
  ( ide_parser(p0)
  , lam x =>
    if ide_is_keywd(x)
      then TOKkwd(x) else TOKide(x)) ||
seq1wth_parser_fun
  ( sym_parser(p0)
  , lam x =>
    if sym_is_keywd(x)
      then TOKkwd(x) else TOKsym(x)) ||
seq1wth_parser_fun
  (spc_parser(p0), lam x => TOKspc(i2c(x)))
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

#ifdef
MAIN_NONE
#then
#else
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
#endif // end of [#ifdef]

(* ****** ****** *)

(* end of [tokenizer] *)
