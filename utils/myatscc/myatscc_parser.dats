(* ****** ****** *)
(*
** HX-2017-04-22:
** For parsing string ...
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload UN = $UNSAFE
//
(* ****** ****** *)
//
#include
"$PATSHOMELOCS\
/atscntrb-hx-parcomb/mylibies.hats"
//
#staload $PARCOMB // opening the package
//
(* ****** ****** *)
//
#staload "./myatscc.sats"
//
(* ****** ****** *)
//
fun
myexp_make_node
(
loc: loc_t
,
node: myexp_node
) : myexp = $rec
{
  myexp_loc=loc, myexp_node=node
} (* end of [token_make_node] *)
//
(* ****** ****** *)
//
implement
myexp_tok(tok) =
myexp_make_node
  (tok.token_loc, EXPtok(tok))
//
(* ****** ****** *)
//
implement
myexp_name(tok) =
myexp_make_node
  (tok.token_loc, EXPname(tok))
//
(* ****** ****** *)
//
implement
print_myexp
  (exp) = fprint(stdout_ref, exp)
implement
prerr_myexp
  (exp) = fprint(stderr_ref, exp)
//
(* ****** ****** *)
//
implement
fprint_val<myexp> = fprint_myexp
//
(* ****** ****** *)
//
implement
fprint_myexplst
  (out, xs) = fprint_list_sep(out, xs, ", ")
//
(* ****** ****** *)

implement
fprint_myexp
  (out, exp) =
(
//
case+
exp.myexp_node
of (* case+ *)
| EXPtok(tok) =>
  fprint!(out, tok)
| EXPname(tok) =>
  fprint!(out, tok)
| EXPfcall(tok, xs) =>
  fprint!(out, "EXPfcall(", tok, "; ", xs, ")")
//
) (* end of [fprint_myexp] *)

(* ****** ****** *)
//
fun
token_is_eof
  (tok: token): bool =
(
case+
tok.token_node of
| TOKeof() => true
| _ (*non-TOKeof*) => false
)
fun
token_isnot_eof
  (tok: token): bool =
(
case+
tok.token_node of
| TOKeof() => false
| _ (*non-TOKeof*) => true
)
//
(* ****** ****** *)
//
fun
TOKEN
(
px: parser(token, token)
) : parser(token, token) =
(
sat_parser_fun
  (any_parser<token>(), lam(x) => token_isnot_eof(x))
)
//
(* ****** ****** *)
//
fun
token_is_space
  (tok: token): bool =
(
case+
tok.token_node of
| TOKspchr(' ') => true
| TOKspchr('\t') => true
| _ (*rest-of-token*) => false
)
//
fun
SPACE
(
px: parser(token, token)
) : parser(token, token) =
  sat_parser_fun(px, token_is_space)
//
(* ****** ****** *)
//
fun
token_is_comma
  (tok: token): bool =
(
case+
tok.token_node of
| TOKspchr(',') => true | _ => false
)
//
fun
COMMA
(
px: parser(token, token)
) : parser(token, token) =
  sat_parser_fun(px, token_is_comma)
//
(* ****** ****** *)
//
fun
token_is_lparen
  (tok: token): bool =
(
case+
tok.token_node of
TOKspchr('\(') => true | _ => false
)
//
fun
token_is_rparen(tok: token): bool =
(
case+
tok.token_node of
| TOKspchr(')') => true | _ => false
)
//
fun
LPAREN
(
px: parser(token, token)
) : parser(token, token) =
  sat_parser_fun(px, token_is_lparen)
fun
RPAREN
(
px: parser(token, token)
) : parser(token, token) =
  sat_parser_fun(px, token_is_rparen)
//
(* ****** ****** *)
//
fun
token_is_name_i
  (tok: token): bool =
(
case+
tok.token_node of
TOKname_i(name) => true | _ => false
)
//
fun
token_is_name_s
  (tok: token): bool =
(
case+
tok.token_node of
TOKname_s(name) => true | _ => false
)
//
fun
TOKEN_name_i
(
px: parser(token, token)
) : parser(token, token) =
  sat_parser_fun(px, token_is_name_i)
fun
TOKEN_name_s
(
px: parser(token, token)
) : parser(token, token) =
  sat_parser_fun(px, token_is_name_s)
//
(* ****** ****** *)
//
extern
fun
myexp_parser
  (parser(token, token)): parser(token, myexp)
//
extern
fun
myexp_parser_
  (parser(token, token)): parser(token, myexp)
//
(* ****** ****** *)
//
implement
myexp_parser_
  (px) = let
  val skip = skipall0_parser(SPACE(px))
in
//
seq3wth_parser_fun
  (skip, myexp_parser(px), skip, lam(_, exp, _) => exp)
//
end // end of [myexp_parser_]
//
(* ****** ****** *)
//
extern
fun
commamyexp_parser
  (parser(token, token)): parser(token, myexp)
//
implement
commamyexp_parser
  (px) =
(
seq2wth_parser_fun
(
  COMMA(px), myexp_parser_(px), lam(_, exp) => exp
) (* seq2wth_parser_fun *)
)
//
(* ****** ****** *)
//
extern
fun
myexpcommaseq_parser
  (parser(token, token)): parser(token, myexplst)
//
implement
myexpcommaseq_parser
  (px) = let
//
typedef x = myexp
typedef xs = myexplst
in
//
seq2wth_parser_fun<token><x,xs,xs>
( myexp_parser_(px)
, list0_parser(commamyexp_parser(px)), lam(x, xs) => list_cons(x, xs)
) || ret_parser(list_nil((*void*)))
//
end // end of [myexpcommaseq_parser]
//
(* ****** ****** *)

typedef
myexparg = @(token, myexplst, token)
typedef
myexpargopt = Option@(token, myexplst, token)

(* ****** ****** *)
//
extern
fun
myexparg_parser
(
px: parser(token, token)
) : parser(token, myexparg)
//
implement
myexparg_parser
  (px) =
(
seq3_parser
(
  LPAREN(px)
, myexpcommaseq_parser(px)
, RPAREN(px)
)
) (* end of [myexparg_parser] *)
//
(* ****** ****** *)
//
fun
myexp_fcall
(
  tok: token, arg: myexparg
) : myexp = let
  val loc =
  tok.token_loc + (arg.2).token_loc
in
//
myexp_make_node(loc, EXPfcall(tok, arg.1))
//
end // end of [myexp_fcall]
fun
myexp_fcallopt
(
  tok: token, opt: myexpargopt
) : myexp = (
//
  case+ opt of
  | None() => myexp_name(tok)
  | Some(arg) => myexp_fcall(tok, arg)
//
) (* myexp_fcallopt *)
//
(* ****** ****** *)
//
extern
fun
myexp_lparser
(
px: parser(token, token)
) : lazy(parser(token, myexp))
//
implement
myexp_parser(px) =
parser_unlazy(myexp_lparser(px))
//
implement
myexp_lparser(px) = $delay
(
seq1wth_parser_fun
(
  TOKEN_name_i(px), lam(x) => myexp_name(x)
) ||
//
seq2wth_parser_fun
(
  TOKEN_name_s(px)
, option_parser(myexparg_parser(px))
, lam(tok, opt) => myexp_fcallopt(tok, opt)
) ||
//
seq1wth_parser_fun(TOKEN(px), lam(x) => myexp_tok(x))
//
)
//
(* ****** ****** *)
//
extern
fun
myexpseq_parser
  (parser(token, token)): parser(token, myexplst)
//
implement
myexpseq_parser(px) = list0_parser(myexp_parser(px))
//
(* ****** ****** *)

fun
tokenlst_streamize
(
xs: List(token)
) : stream(token) = let
//
val eof = token_eof((*void*))
//
in
//
$delay
(
case+ xs of
| list_nil() =>
  stream_cons
    (eof, tokenlst_streamize(xs))
  // list_nil
| list_cons(x, xs) =>
  stream_cons(x, tokenlst_streamize(xs))
)
//
end // end of [tokenlst_streamize]

(* ****** ****** *)

implement
myexpseq_parse
  (inp) = exps where
{
  val px =
  any_parser<token>()
  val toks =
  tokenlst_streamize(inp)
  val (exps, toks) =
  parser_apply2_stream(myexpseq_parser(px), toks)
} (* end of [tokenlst2myexpseq] *)

(* ****** ****** *)

(* end of [myatscc_parser.dats] *)
