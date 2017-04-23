(*
** HX-2017-04-22:
** For turning string into tokens
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
#include
"$PATSHOMELOCS/atscntrb-hx-parcomb/mylibies.hats"
//
(* ****** ****** *)

#staload "./myatscc.sats"

(* ****** ****** *)
//
#define :: list_cons
#define i2c int2char0
//
(* ****** ****** *)
//
abst@ype
ichar_t0ype = @(int, char)
//
typedef ichar = ichar_t0ype
//
local
assume ichar_t0ype = @(int, char)
in (*nothing*) end
//
(* ****** ****** *)
//
extern
fun{}
ichar_get_pos(ichar): int
extern
fun{}
ichar_get_char(ic: ichar): char
//
overload .pos with ichar_get_pos
overload .char with ichar_get_char
//
implement
{}(*tmp*)
ichar_get_pos(ic) =
ic.0 where { reassume ichar_t0ype }
implement
{}(*tmp*)
ichar_get_char(ic) =
ic.1 where { reassume ichar_t0ype }
//
(* ****** ****** *)
//
extern
fun
string2icharlst
  (cs: string): stream(ichar)
//
implement
string2icharlst
  (cs) = let
//
reassume ichar_t0ype
//
fun
auxmain
(
 i: int, p: ptr
) : stream(@(int, char)) = $delay
(
let
  val c = $UN.ptr0_get<Char>(p) 
in
  if
  iseqz(c)
  then (
    stream_cons(@(i, c), auxmain(i, p))
  ) else (
    stream_cons(@(i, c), auxmain(i+1, ptr_succ<char>(p)))
  ) // end of [if]
end // end of [let]
)
//
in
  auxmain(0, string2ptr(cs))
end // end of [string2icharlst]

(* ****** ****** *)
//
fun
token_make_node
(
loc: loc_t
,
node: token_node
) : token = $rec
{
  token_loc=loc, token_node=node
} (* end of [token_make_node] *)
//
(* ****** ****** *)

implement
token_make_ide
  (p0, p1, ide) = let
//
  val
  loc = loc_t_make(p0, p1)
//
in
  token_make_node(loc, TOKide(ide))
end // end of [token_make_ide]

implement
token_make_int
  (p0, p1, int) = let
//
  val
  loc = loc_t_make(p0, p1)
//
in
  token_make_node(loc, TOKint(int))
end // end of [token_make_int]

implement
token_make_spchr
  (p0, chr) = let
  val
  loc = loc_t_make(p0, p0+1)
in
  token_make_node(loc, TOKspchr(chr))
end // end of [token_make_spchr]

(* ****** ****** *)
//
implement
print_token
  (tok) = fprint(stdout_ref, tok)
implement
prerr_token
  (tok) = fprint(stderr_ref, tok)
//
implement
fprint_token
  (out, tok) =
(
case+
tok.token_node of
| TOKide(ide) =>
  fprint!(out, "TOKide(", ide, ")")
| TOKint(int) =>
  fprint!(out, "TOKint(", int, ")")
| TOKspchr(chr) =>
  fprint!(out, "TOKspchr(", chr, ")")
)
//
(* ****** ****** *)
//
local
//
fun
idfst_test
(
ic: ichar
) : bool = let
  val c = ic.char()
in
  isalpha(c) orelse (c = '_')
end // end of [idfst_test]
fun
idrst_test
(
ic: ichar
) : bool = let
  val c = ic.char()
in
  isalnum(c) orelse (c = '_')
end // end of [idfst_test]
//
fun
idfst_parser
(
px: parser(ichar, ichar)
) : parser(ichar, ichar) =
  sat_parser_fun(px, idfst_test)
fun
idrst_parser
(
px: parser(ichar, ichar)
) : parser(ichar, ichar) =
  sat_parser_fun(px, idrst_test)
//
fun
ident_make
(
  ic: ichar, ics: List0(ichar)
) : token = let
  val p0 = ic.pos()
  val p1 = loop(p0, ics) where
  {
    fun
    loop
    (
      p0: int, ics: List0(ichar)
    ) : int =
    (
      case+ ics of
      | list_nil() => p0+1
      | list_cons
          (ic, ics) => loop(ic.pos(), ics)
        // list_cons
    )
  }
  val c0 = ic.char()
  val cs =
    list_map_fun<ichar><char>
      (ics, lam ic => ic.char())
  val cs = list_vt_cons(c0, cs)
  val cs =
    $UN.castvwtp0{List0_vt(charNZ)}(cs)
  val ide =
    string_make_list($UN.list_vt2t{charNZ}(cs))
  val ((*freed*)) = list_vt_free<char>(cs)
in
  token_make_ide(p0, p1, strnptr2string(ide))
end // end of [ident_make]
//
in (* in-of-local *)
//
fun
token_ide_parser
(
p0: parser(ichar, ichar)
) : parser(ichar, token) =
(
seq2wth_parser_fun
( idfst_parser(p0)
, list0_parser(idrst_parser(p0)), ident_make
)
) (* end of [seq2wth_parser_fun] *)
//
end // end of [local]
  
(* ****** ****** *)
//
fun
token_spchr_parser
(
p0: parser(ichar, ichar)
) : parser(ichar, token) =
(
seq1wth_parser_fun
( sat_parser_fun(p0, lam ic => isneqz(ic.char()))
, lam(ic) => token_make_spchr(ic.pos(), ic.char())
) (* seq1wth_parser_fun *)
)
//
(* ****** ****** *)

fun
token_parser
(
p0: parser(ichar, ichar)
) : parser(ichar, token) =
(
//
token_ide_parser(p0)
//
(*
||
//
token_int_parser(p0)
*)
//
||
//
token_spchr_parser(p0)
//
) (* end of [token_parser] *)

(* ****** ****** *)

implement
string_tokenize
  (cs) = let
//
val
ics = string2icharlst(cs)
val
partok =
token_parser(any_parser<ichar>())
//
in
  parser_apply_stream(list0_parser(partok), ics)
end // end of [string_tokenize]

(* ****** ****** *)

(* end of [myatscc_lexer.dats] *)
