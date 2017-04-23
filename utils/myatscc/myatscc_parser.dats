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
"share/HATS/atspre_staload_libats_ML.hats"
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
  fprint(out, tok)
| EXPname(tok) =>
  fprint!(out, "$", tok)
| EXPcall(tok, xs) =>
  fprint!(out, "EXPcall(", tok, "; ", xs, ")")
//
) (* end of [fprint_myexp] *)

(* ****** ****** *)
//
fun
TOKEN
(
// argument
) : parser(token, token) =
  any_parser<token>((*void*))
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
commamyexp_parser(px) =
seq2wth_parser_fun(COMMA(px), myexp_parser(px), lam(_, exp) => exp)
//
(* ****** ****** *)
//
extern
fun
myexpcommaseq0_parser
  (parser(token, token)): parser(token, myexplst)
extern
fun
myexpcommaseq1_parser
  (parser(token, token)): parser(token, myexplst)
//
implement
myexpcommaseq0_parser(px) =
myexpcommaseq1_parser(px) || ret_parser(list_nil)
implement
myexpcommaseq1_parser(px) =
seq2wth_parser_fun<token><myexp,myexplst,myexplst>
  (myexp_parser(px), list0_parser(commamyexp_parser(px)), lam(x, xs) => list_cons(x, xs))
//
(* ****** ****** *)
//
implement
myexp_parser(px) =
(
seq1wth_parser_fun(TOKEN(), lam(x) => myexp_tok(x))
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

implement
tokenlst2myexpseq
  (toks) = exps where
{
  val toks =
  stream_make_list0(g0ofg1(toks))
  val (exps, toks) =
  parser_apply2_stream(myexpseq_parser(TOKEN()), toks)
} (* end of [tokenlst2myexpseq] *)

(* ****** ****** *)

(* end of [myatscc_parser.dats] *)
