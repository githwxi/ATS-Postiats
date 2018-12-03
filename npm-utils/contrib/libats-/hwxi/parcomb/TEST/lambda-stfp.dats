(* ****** ****** *)
/*
HX:
For testing parcomb
*/
(* ****** ****** *)

local
#define MAIN_NONE
in(*in-of-local*)
#include "./tokenizer.dats"
end // end of [local]
//
(* ****** ****** *)

datatype term =
//
  | TMvar of tvar
//
  | TMlam of (tvar, term)
  | TMapp of (term, term)
//
  | TMint of (int)
//
  | TMfix of (tvar(*f*), tvar(*x*), term)
//
  | TMift of (term, term, term) // if non-zero then ... else ...
//
where
tvar = string
and
topr = string
and
termlst = list0(term)

(* ****** ****** *)

fun
TMapplst
(
t0, ts: termlst
) : term =
(
auxlst(t0, ts)
) where
{
fun
auxlst(t0: term, ts: termlst): term = 
(
case+ ts of
| list0_nil() => t0
| list0_cons(t1, ts) => auxlst(TMapp(t0, t1), ts)
)
}
//
(* ****** ****** *)

extern
fun
print_term : (term) -> void
and
prerr_term : (term) -> void
extern
fun
fprint_term : (FILEref, term) -> void

overload print with print_term
overload prerr with prerr_term
overload fprint with fprint_term

(* ****** ****** *)

implement
print_term(t0) = 
fprint_term(stdout_ref, t0)
implement
prerr_term(t0) = 
fprint_term(stderr_ref, t0)

local

implement
fprint_val<term> = fprint_term

in (* in-of-local *)

implement
fprint_term
  (out, t0) =
(
case+ t0 of
//
| TMvar(x1) =>
  fprint!(out, "TMvar(", x1, ")")
//
| TMlam(x1, t2) =>
  fprint!
  (out, "TMlam(", x1, "; ", t2, ")")
| TMapp(t1, t2) =>
  fprint!
  (out, "TMapp(", t1, "; ", t2, ")")
//
| TMint(i1) =>
  fprint!(out, "TMint(", i1, ")")
//
| TMfix(f1, x2, t3) =>
  fprint!
  (out, "TMfix(", f1, "; ", x2, "; ", t3, ")")
//
| TMift(t1, t2, t3) =>
  fprint!
  (out, "TMift(", t1, "; ", t2, "; ", t3, ")")
//
) (* end of [fprint_term] *)

end // end of [local]

(* ****** ****** *)
//
extern
fun
toksat
( test
: token -<cloref1> bool
) : parser(token, token)
//
implement
toksat(test) =
sat_parser_cloref<token><token>
  (any_parser<token>(), test)
//
val
par_COMMA =
toksat
(
lam x =>
case+ x of
| TOKspc(',') => true | _ => false
)
//
val
par_LPAREN =
toksat
(
lam x =>
case+ x of
| TOKspc('\(') => true | _ => false
)
val
par_RPAREN =
toksat
(
lam x =>
case+ x of
| TOKspc('\)') => true | _ => false
)
//
val
par_IFT =
toksat
(
  lam x =>
  case+ x of
  | TOKkwd("ift") => true | _ => false
)
val
par_THEN =
toksat
(
  lam x =>
  case+ x of
  | TOKkwd("then") => true | _ => false
)
val
par_ELSE =
toksat
(
  lam x =>
  case+ x of
  | TOKkwd("else") => true | _ => false
)
//
(* ****** ****** *)
//
val
par_EQ =
toksat
(
  lam x =>
  case+ x of
  | TOKkwd("=") => true | _ => false
)
val
par_EQGT =
toksat
(
  lam x =>
  case+ x of
  | TOKkwd("=>") => true | _ => false
)
//
(* ****** ****** *)
//
val
par_LAM =
toksat
(
lam x =>
case+ x of
| TOKkwd("lam") => true | _ => false
)
val
par_FIX =
toksat
(
lam x =>
case+ x of
| TOKkwd("fix") => true | _ => false
)
//
(* ****** ****** *)
//
val
par_LET =
toksat
(
lam x =>
case+ x of
| TOKkwd("let") => true | _ => false
)
val
par_IN =
toksat
(
lam x =>
case+ x of
| TOKkwd("in") => true | _ => false
)
val
par_END =
toksat
(
lam x =>
case+ x of
| TOKkwd("end") => true | _ => false
)
//
(* ****** ****** *)

val
par_var =
seq1wth_parser_fun<token><token,tvar>
(
toksat
(
  lam tok =>
  case+ tok of
  | TOKide _ => true | _ => false
)
,
lam(tok) =>
let val-TOKide(name) = tok in name end
)

(* ****** ****** *)

val
par_TMint =
seq1wth_parser_fun<token><token,term>
(
toksat
(
  lam tok =>
  case+ tok of
  | TOKint _ => true | _ => false
)
,
lam(tok) =>
let val-TOKint(i0) = tok in TMint(i0) end
)

val
par_TMvar =
seq1wth_parser_fun<token><token,term>
(
toksat
(
  lam tok =>
  case+ tok of
  | TOKide _ => true
  | TOKsym _ => true | _ => false
)
,
lam(tok) =>
(
case- tok of
| TOKide(ide) => TMvar(ide) | TOKsym(sym) => TMvar(sym)
)
)

(* ****** ****** *)
//
extern
fun
lpar_aterm
(
// argless
) : lazy(parser(token, term))
extern
fun
lpar_term0
(
// argless
) : lazy(parser(token, term))
//
(* ****** ****** *)

val
par_aterm =
parser_unlazy(lpar_aterm())
val
par_term0 =
parser_unlazy(lpar_term0())

(* ****** ****** *)
//
extern
fun
{t:t0p}
{a1,a2:t0p}
par_tup2_fst
( p1: parser(t, a1)
, p2: parser(t, a2)): parser(t, a1)
extern
fun
{t:t0p}
{a1,a2:t0p}
par_tup2_snd
( p1: parser(t, a1)
, p2: parser(t, a2)): parser(t, a2)
//
overload << with par_tup2_fst
overload >> with par_tup2_snd
//
(* ****** ****** *)
//
implement
{t}{a1,a2}
par_tup2_fst(p1, p2) =
seq2wth_parser_fun<t><a1,a2,a1>
  (p1, p2, lam(x1, x2) => x1)
//
implement
{t}{a1,a2}
par_tup2_snd(p1, p2) =
seq2wth_parser_fun<t><a1,a2,a2>
  (p1, p2, lam(x1, x2) => x2)
//
(* ****** ****** *)

val
par_TMlam =
seq2wth_parser_fun<token><tvar,term,term>
(
  par_LAM >> par_var
, par_EQGT >> par_term0
, lam(x, t) => TMlam(x, t)
)

(* ****** ****** *)
//
val
par_TMfix =
seq3wth_parser_fun<token><tvar,tvar,term,term>
(
  par_FIX >> par_var
, par_LPAREN >> (par_var << par_RPAREN)
, par_EQGT >> par_term0
, lam(f, x, t) => TMfix(f, x, t)
)
//
(* ****** ****** *)

val
par_TMift =
seq3wth_parser_fun<token><term,term,term,term>
(
  par_IFT >> par_term0
, par_THEN >> par_term0
, par_ELSE >> par_term0
, lam(t0, t1, t2) => TMift(t0, t1, t2)
)

(* ****** ****** *)

val
par_TMapplst =
seq2wth_parser_fun<token><term,termlst,term>
(
  par_aterm,
  list0_parser(par_aterm)
, lam(t0, ts) => TMapplst(t0, ts)
)

(* ****** ****** *)

implement
lpar_aterm() = $delay
(
par_TMint ||
par_TMvar ||
(par_LPAREN >> (par_term0 << par_RPAREN))
)

(* ****** ****** *)

implement
lpar_term0() = $delay
(
  par_TMlam ||
  par_TMfix ||
  par_TMift ||
  par_TMapplst || 
  fail_parser<token><term>()
)

(* ****** ****** *)

fun
cstream_eof
(
cs: stream(int)
) : stream(int) = $delay
(
case+ !cs of
| stream_nil
    () => stream_sing(~1)
| stream_cons
    (c0, cs) => stream_cons(c0, cstream_eof(cs))
)

(* ****** ****** *)

fun
token_is_space
  .<>.
  (t0: token):<> bool =
(
case+ t0 of TOKspc(' ') => true | _ => false
)

fun
tstream_despc_eof
(
ts: stream(token)
) : stream(token) = $delay
(
case+ !ts of
| stream_nil
    () => stream_sing(TOKeof)
| stream_cons
    (t0, ts) =>
  (
    if
    token_is_space(t0)
    then !(tstream_despc_eof(ts))
    else stream_cons(t0, tstream_despc_eof(ts))
    // end of [if]
  )
)

(* ****** ****** *)

val
prgm1 =
"lam x => (+ x x)"
val
prgm1 =
"fix f(x) => ift (> x 0) then (* x (f(- x 1))) else 1"

(* ****** ****** *)

implement
main0((*void*)) =
{
//
(*
val ts0 = cstream_gen()
*)
//
val ts1 =
streamize_string_char
  (prgm1)
val ts1 = stream_vt2t(ts1)
val ts1 =
stream_map_cloref
( ts1
, lam(c) => char2int0(c))
val ts1 = cstream_eof(ts1)
//
val pt0 =
token_parser
(any_parser<int>((*void*)))
//
val pts = list0_parser(pt0)
//
val tks =
  parser_apply_stream(pts, ts1)
//
val tks =
streamize_list0_elt(tks)
val tks = stream_vt2t(tks)
val tks = tstream_despc_eof(tks)
//
val tm1 =
parser_apply_stream(par_term0, tks)
val ((*void*)) = println! ("tm1 = ", tm1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [lambda-stfp.dats] *)
