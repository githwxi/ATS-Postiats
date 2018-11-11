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
(*
  | TMstr of (string)
*)
//
  | TMfix of (tvar(*f*), tvar(*x*), term)
//
  | TMift of (term, term, term) // if non-zero then ... else ...
//
  | TMopr of (topr, termlst(*arg*))
//
where
tvar = string
and
topr = string
and
termlst = list0(term)

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
| TMopr(op1, ts2) =>
  fprint!(out, "TMopr(", op1, "; ", ts2)
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
| TOKspchr(',') => true | _ => false
)
//
val
par_LPAREN =
toksat
(
lam x =>
case+ x of
| TOKspchr('\(') => true | _ => false
)
val
par_RPAREN =
toksat
(
lam x =>
case+ x of
| TOKspchr('\)') => true | _ => false
)
//
val
par_IFT =
toksat
(
  lam x =>
  case+ x of
  | TOKide("ift") => true | _ => false
)
val
par_THEN =
toksat
(
  lam x =>
  case+ x of
  | TOKide("then") => true | _ => false
)
val
par_ELSE =
toksat
(
  lam x =>
  case+ x of
  | TOKide("else") => true | _ => false
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
  | TOKsym("=") => true | _ => false
)
val
par_EQGT =
toksat
(
  lam x =>
  case+ x of
  | TOKsym("=>") => true | _ => false
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
| TOKide("lam") => true | _ => false
)
val
par_FIX =
toksat
(
lam x =>
case+ x of
| TOKide("fix") => true | _ => false
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
| TOKide("let") => true | _ => false
)
val
par_IN =
toksat
(
lam x =>
case+ x of
| TOKide("in") => true | _ => false
)
val
par_END =
toksat
(
lam x =>
case+ x of
| TOKide("end") => true | _ => false
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
  | TOKide _ => true | _ => false
)
,
lam(tok) =>
let val-TOKide(id) = tok in TMvar(id) end
)

(* ****** ****** *)
//
extern
fun
lpar_aterm
(
): lazy(parser(token, term))
extern
fun
lpar_term0
(
): lazy(parser(token, term))
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val ts0 = cstream_gen()
//
val pt0 =
token_parser
(any_parser<int>((*void*)))
//
val pts = list0_parser(pt0)
//
val tks =
  parser_apply_stream(pts, ts0)
//
(*
val tks = streamize_list0_elt(tks)
*)
//
val out = stdout_ref
val ((*void*)) = fprintln!(out, "tks = ", tks)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [lambda-stfp.dats] *)
