(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
STRING =
"libats/libc/SATS/string.sats"
//
(* ****** ****** *)

staload "./../SATS/catsparse.sats"
staload "./../SATS/catsparse_syntax.sats"

(* ****** ****** *)

infix ++
overload ++ with location_combine

(* ****** ****** *)

implement
synent_decode2{a}
  (x) = let
  val res = synent_decode{a}(x)
  prval ((*void*)) = topize (x) in res
end // end of [synent_decode2]

(* ****** ****** *)

implement
synent_null{a} () = $UN.cast{a}(the_null_ptr)

(* ****** ****** *)
//
implement
synent_is_null (ent) = iseqz ($UN.cast2ptr(ent))
implement
synent_isnot_null (ent) = isneqz ($UN.cast2ptr(ent))
//
(* ****** ****** *)
//
implement
i0dex_make_sym
  (loc, sym) = '{ i0dex_loc= loc, i0dex_sym= sym }
//
implement
i0dex_make_string
  (loc, name) = let
  val sym = symbol_make (name) in i0dex_make_sym (loc, sym)
end // end of [i0dex_make_string]
//
(* ****** ****** *)
//
fun
s0exp_make_node
  (loc, node) = '{
  s0exp_loc=loc, s0exp_node=node
} (* end of [s0exp_make_node] *)
//
(* ****** ****** *)
//
implement
s0exp_ide (loc, id) =
  s0exp_make_node (loc, S0Eide (id.i0dex_sym))
//
implement
s0exp_list (loc, s0es) = s0exp_make_node (loc, S0Elist (s0es))
//
implement
s0exp_appid (id, s0e) = let
//
val loc =
  id.i0dex_loc ++ s0e.s0exp_loc
//
val-S0Elist (s0es) = s0e.s0exp_node
//
in
  s0exp_make_node (loc, S0Eappid (id, s0es))
end // end of [s0exp_appid]
//
(* ****** ****** *)
//
// HX: for constructing dynamic expressions
//
(* ****** ****** *)
//
fun
d0exp_make_node
  (loc, node) = '{
  d0exp_loc=loc, d0exp_node=node
} (* end of [d0exp_make_node] *)
//
(* ****** ****** *)
//
implement
d0exp_ide (id) = let
  val loc = id.i0dex_loc
in
  d0exp_make_node(loc, D0Eide(id))
end // end of [d0exp_ide]
//
implement
d0exp_list
  (loc, d0es) =
  d0exp_make_node (loc, D0Elist(d0es))
//
implement
d0exp_appid
  (id, d0e_arg) = let
//
val loc =
  id.i0dex_loc ++ d0e_arg.d0exp_loc
//
val-D0Elist (d0es_arg) = d0e_arg.d0exp_node
//
in
  d0exp_make_node (loc, D0Eappid (id, d0es_arg))
end // end of [d0exp_appid]
//
implement
d0exp_appexp
  (d0e_fun, d0e_arg) = let
//
val loc =
  d0e_fun.d0exp_loc ++ d0e_arg.d0exp_loc
//
val-D0Elist (d0es_arg) = d0e_arg.d0exp_node
//
in
  d0exp_make_node (loc, D0Eappexp (d0e_fun, d0es_arg))
end // end of [d0exp_appexp]
//
(* ****** ****** *)
//
implement
ATSPMVint_make
(
  tok1, int, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVint (int))
end // end of [ATSPMVint]
//
implement
ATSPMVintrep_make
(
  tok1, int, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVintrep (int))
end // end of [ATSPMVintrep]
//
(* ****** ****** *)

implement
ATSPMVbool_make
(
  tok1, tfv, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVbool (tfv))
end // end of [ATSPMVbool]

(* ****** ****** *)

implement
ATSPMVfloat_make
(
  tok1, float, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVfloat (float))
end // end of [ATSPMVfloat]

(* ****** ****** *)

implement
ATSPMVstring_make
(
  tok1, str, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVstring (str))
end // end of [ATSPMVstring]

(* ****** ****** *)

implement
ATSPMVi0nt_make
(
  tok1, int, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVi0nt (int))
end // end of [ATSPMVi0nt]

(* ****** ****** *)

implement
ATSPMVf0loat_make
(
  tok1, float, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVf0loat (float))
end // end of [ATSPMVf0loat]

(* ****** ****** *)
//
implement
ATSPMVempty_make
(
  tok1, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVempty(0))
end // end of [ATSPMVempty]
//
implement
ATSPMVextval_make
(
  tok1, toks, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVextval(toks))
end // end of [ATSPMVextval]
//
(* ****** ****** *)

implement
ATSPMVrefarg0_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVrefarg0 (d0e))
end // end of [ATSPMVrefarg0]

(* ****** ****** *)

implement
ATSPMVrefarg1_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVrefarg1 (d0e))
end // end of [ATSPMVrefarg1]

(* ****** ****** *)

implement
ATSPMVfunlab_make
(
  tok1, flab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVfunlab (flab))
end // end of [ATSPMVfunlab]

(* ****** ****** *)

implement
ATSPMVcfunlab_make
(
  tok1, knd, fl, arg, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
val+SIGNED (_, knd) = knd
val-D0Elist (d0es) = arg.d0exp_node
//
in
  d0exp_make_node (loc, ATSPMVcfunlab(knd, fl, d0es))
end // end of [ATSPMVcfunlab]

(* ****** ****** *)

implement
ATSPMVcastfn_make
(
  tok1, fid, s0e_res, arg, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSPMVcastfn(fid, s0e_res, arg))
end // end of [ATSPMVcastfn_make]

(* ****** ****** *)

implement
ATSCSTSPmyloc_make
(
  tok1, str, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCSTSPmyloc (str))
end // end of [ATSCSTSPmyloc_make]

(* ****** ****** *)
//
implement
ATSCKiseqz_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKiseqz (d0e))
end // end of [ATSCKiseqz_make]
//
implement
ATSCKisneqz_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKisneqz (d0e))
end // end of [ATSCKisneqz_make]
//
(* ****** ****** *)
//
implement
ATSCKptriscons_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKptriscons (d0e))
end // end of [ATSCKptriscons_make]
//
implement
ATSCKptrisnull_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKptrisnull (d0e))
end // end of [ATSCKptrisnull_make]
//
(* ****** ****** *)

implement
ATSCKpat_int_make
(
  tok1, d0e, int, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKpat_int (d0e, int))
end // end of [ATSCKpat_int_make]

implement
ATSCKpat_bool_make
(
  tok1, d0e, bool, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKpat_bool (d0e, bool))
end // end of [ATSCKpat_bool_make]

implement
ATSCKpat_string_make
(
  tok1, d0e, string, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSCKpat_string (d0e, string))
end // end of [ATSCKpat_string_make]

(* ****** ****** *)

implement
ATSCKpat_con0_make
(
  tok1, d0e, ctag, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
val+SIGNED (_, ctag) = ctag
//
in
  d0exp_make_node (loc, ATSCKpat_con0 (d0e, ctag))
end // end of [ATSCKpat_con0_make]

(* ****** ****** *)

implement
ATSCKpat_con1_make
(
  tok1, d0e, ctag, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
val+SIGNED (_, ctag) = ctag
//
in
  d0exp_make_node (loc, ATSCKpat_con1 (d0e, ctag))
end // end of [ATSCKpat_con1_make]

(* ****** ****** *)

implement
ATSSELcon_make
(
  tok1, d0e, s0e, lab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSSELcon (d0e, s0e, lab))
end // end of [ATSSELcon_make]

(* ****** ****** *)

implement
ATSSELrecsin_make
(
  tok1, d0e, s0e, lab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSSELrecsin (d0e, s0e, lab))
end // end of [ATSSELrecsin_make]

(* ****** ****** *)

implement
ATSSELboxrec_make
(
  tok1, d0e, s0e, lab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSSELboxrec (d0e, s0e, lab))
end // end of [ATSSELboxrec_make]

(* ****** ****** *)

implement
ATSSELfltrec_make
(
  tok1, d0e, s0e, lab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0exp_make_node (loc, ATSSELfltrec (d0e, s0e, lab))
end // end of [ATSSELfltrec_make]

(* ****** ****** *)

implement
ATSextfcall_make
(
  tok1, _fun, _arg, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
val-D0Elist(d0es_arg) = _arg.d0exp_node
//
in
  d0exp_make_node (loc, ATSextfcall (_fun, d0es_arg))
end // end of [ATSextfcall_make]

(* ****** ****** *)

implement
ATSextmcall_make
(
  tok1, _obj, _mtd, _arg, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
val-D0Elist(d0es_arg) = _arg.d0exp_node
//
in
  d0exp_make_node (loc, ATSextmcall (_obj, _mtd, d0es_arg))
end // end of [ATSextmcall_make]

(* ****** ****** *)

implement
ATSfunclo_fun_make
(
  tok1, d0e, arg, res, tok2, opt
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
val d0e_fun =
  d0exp_make_node (loc, ATSfunclo_fun(d0e, arg, res))
//
in
//
case+ opt of
| None () => d0e
| Some (d0e_arg) => let
    val loc2 = loc ++ d0e_arg.d0exp_loc
    val-D0Elist (d0es_arg) = d0e_arg.d0exp_node
  in
    d0exp_make_node (loc2, D0Eappexp(d0e_fun, d0es_arg))
  end // end of [Some]
//
end // end of [ATSfunclo_fun_make]

(* ****** ****** *)

implement
ATSfunclo_clo_make
(
  tok1, d0e, arg, res, tok2, opt
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
val d0e_clo =
  d0exp_make_node (loc, ATSfunclo_clo(d0e, arg, res))
//
in
//
case+ opt of
| None () => d0e
| Some (d0e_arg) => let
    val loc2 = loc ++ d0e_arg.d0exp_loc
    val-D0Elist (d0es_arg) = d0e_arg.d0exp_node
  in
    d0exp_make_node (loc2, D0Eappexp(d0e_clo, d0es_arg))
  end // end of [Some]
//
end // end of [ATSfunclo_clo_make]

(* ****** ****** *)

implement
tyfld_make
  (s0e, id) = let
//
val loc = s0e.s0exp_loc ++ id.i0dex_loc
//
in '{
  tyfld_loc= loc, tyfld_node= TYFLD (id, s0e)
} end // end of [tyfld_make]

(* ****** ****** *)

implement
tyrec_make
(
  tok1, tyflds, tok2
) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in '{
  tyrec_loc= loc, tyrec_node= tyflds
} end // end of [tyrec_make]

(* ****** ****** *)
//
implement
f0arg_none
  (s0e) = '{
  f0arg_loc= s0e.s0exp_loc
, f0arg_node= F0ARGnone (s0e)
} (* end of [f0arg_none] *)
//
implement
f0arg_some
  (s0e, id) = let
//
(*
val () = println! ("f0arg_some: id = ", id)
val () = println! ("f0arg_some: s0e = ", s0e)
*)
//
val loc =
  s0e.s0exp_loc ++ id.i0dex_loc
//
in '{
  f0arg_loc= loc
, f0arg_node= F0ARGsome (id, s0e)
} end // end of [f0arg_some]
//
(* ****** ****** *)
//
implement
f0marg_isneqz
  (f0ma) = isneqz (f0ma.f0marg_node)
//
(* ****** ****** *)

implement
f0marg_make
(
  tok1, f0as, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in '{
  f0marg_loc= loc, f0marg_node = f0as
} end // end of [f0marg_make]

(* ****** ****** *)
//
implement
fkind_extern
  (tok1, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in '{
  fkind_loc= loc, fkind_node = FKextern ()
} end // end of [fkind_extern]
//
implement
fkind_static
  (tok1, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in '{
  fkind_loc= loc, fkind_node = FKstatic ()
} end // end of [fkind_static]
//
(* ****** ****** *)

implement
f0head_get_f0arglst
  (fhd) = f0ma.f0marg_node where
{
//
val+F0HEAD (_, f0ma, _) = fhd.f0head_node
//
} (* end of [f0head_get_f0arglst] *)

(* ****** ****** *)

implement
f0head_make
(
  res, id, marg
) = let
//
val loc =
  res.s0exp_loc ++ marg.f0marg_loc
//
in '{
  f0head_loc= loc
, f0head_node= F0HEAD (id, marg, res)
} end // end of [f0head_make]

(* ****** ****** *)
//
implement
tmpvar_is_sta(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "sta", i2sz(3)) = 0
) (* end of [tmpvar_is_sta] *)
implement
tmpvar_is_arg(tmp) =
(
  $STRING.strncmp (symbol_get_name(tmp), "arg", i2sz(3)) = 0
) (* end of [tmpvar_is_arg] *)
implement
tmpvar_is_apy(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "apy", i2sz(3)) = 0
) (* end of [tmpvar_is_apy] *)
//  
implement
tmpvar_is_env(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "env", i2sz(3)) = 0
) (* end of [tmpvar_is_env] *)
//
implement
tmpvar_is_tmp(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "tmp", i2sz(3)) = 0
) (* end of [tmpvar_is_tmp] *)
implement
tmpvar_is_tmpret(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "tmpret", i2sz(6)) = 0
) (* end of [tmpvar_is_tmpret] *)
//
(* ****** ****** *)
//
(*
implement
tmpvar_is_a2rg(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "a2rg", i2sz(4)) = 0
) (* end of [tmpvar_is_a2rg] *)
implement
tmpvar_is_a2py(tmp) =
(
  $STRING.strncmp(symbol_get_name(tmp), "a2py", i2sz(4)) = 0
) (* end of [tmpvar_is_a2py] *)
*)
//
(* ****** ****** *)

local
//
fun
skipds
(
  p1: ptr
) : ptr = let
  val c1 = $UN.ptr0_get<char>(p1)
in
  if isdigit(c1)
    then skipds(ptr_succ<char>(p1)) else p1
  // end of [if]
end // end of [skipds]
//
in (* in-of-local *)

implement
tmpvar_is_axrg(tmp) = let
//
val p0 =
string2ptr
  (symbol_get_name(tmp))
//
val c0 =
  $UN.ptr0_get<char>(p0)
//
in
//
if
(c0 = 'a')
then let
//
val p1 =
  skipds(ptr_succ<char>(p0))
//
val c1 = $UN.ptr0_get<char>(p1)
//
in
//
if
(c1 = 'r')
then let
  val p2 = ptr_succ<char>(p1)
  val c2 = $UN.ptr0_get<char>(p2)
in
  if (c2 = 'g') then true else false
end // end of [then]
else false
//
end // end of [then]
else false
//
end // end of [tmpvar_is_axrg]

implement
tmpvar_is_axpy(tmp) = let
//
val p0 =
string2ptr
  (symbol_get_name(tmp))
//
val c0 =
  $UN.ptr0_get<char>(p0)
//
in
//
if
(c0 = 'a')
then let
//
val p1 =
  skipds(ptr_succ<char>(p0))
//
val c1 = $UN.ptr0_get<char>(p1)
//
in
//
if
(c1 = 'p')
then let
  val p2 = ptr_succ<char>(p1)
  val c2 = $UN.ptr0_get<char>(p2)
in
  if (c2 = 'y') then true else false
end // end of [then]
else false
//
end // end of [then]
else false
//
end // end of [tmpvar_is_axpy]

end // end of [local]

(* ****** ****** *)
//
implement
tmpvar_is_local (tmp) =
(
  ifcase
  | tmpvar_is_tmp(tmp) => true
//
  | tmpvar_is_arg(tmp) => true
  | tmpvar_is_apy(tmp) => true
//
  | tmpvar_is_env(tmp) => true
//
  | tmpvar_is_axrg(tmp) => true
  | tmpvar_is_axpy(tmp) => true
//
  | _ (* else *) => false
) (* end of [tmpvar_is_local] *)
//
(* ****** ****** *)

implement
tmpdec_make_none
(
  tok_kwd, tmp, tok_end
) = let
//
val loc =
tok_kwd.token_loc ++ tok_end.token_loc
//
in '{
  tmpdec_loc= loc, tmpdec_node= TMPDECnone (tmp)
} end // end of [tmpdec_make_none]

(* ****** ****** *)

implement
tmpdec_make_some
(
  tok_kwd, tmp, s0e, tok_end
) = let
//
val loc =
tok_kwd.token_loc ++ tok_end.token_loc
//
in '{
  tmpdec_loc= loc, tmpdec_node= TMPDECsome (tmp, s0e)
} end // end of [tmpdec_make_some]

(* ****** ****** *)

implement
instrlst_skip_linepragma
  (inss) = (
//
case+ inss of
| list_nil () => list_nil ()
| list_cons (ins, inss2) =>
  (
    case+ ins.instr_node of
    | ATSlinepragma _ => inss2 | _ => inss
  )
//
) (* end of [instrlst_skip_linepragma] *)

(* ****** ****** *)

fun
instr_make_node (
  loc: loc_t, node: instr_node
) : instr = '{ instr_loc= loc, instr_node= node }

(* ****** ****** *)

implement
ATSif_make
(
  tok_if, d0e, ins1, insopt2
) = let
//
val loc =
(
case+ insopt2 of
| Some (ins2) => tok_if.token_loc ++ ins2.instr_loc
| None ((*void*)) => tok_if.token_loc ++ ins1.instr_loc
) : loc_t // end of [val]
//
val inss_then = let
  val-ATSthen(inss) = ins1.instr_node in inss
end // end of [val]
val inssopt_else = (
//
case+ insopt2 of
| Some (ins2) => let
    val-ATSelse(inss) = ins2.instr_node in Some(inss)
  end // end of [Some]
| None ((*void*)) => None ()
//
) : instrlstopt // end of [val]
//
in
  instr_make_node (loc, ATSif (d0e, inss_then, inssopt_else))
end // end of [ATSif_make]

(* ****** ****** *)

implement
ATSifthen_make
(
  tok1, d0e, inss, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSifthen (d0e, inss))
end // end of [ATSifthen_make]

(* ****** ****** *)

implement
ATSifnthen_make
(
  tok1, d0e, inss, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSifnthen (d0e, inss))
end // end of [ATSifnthen_make]

(* ****** ****** *)
//
implement
ATSthen_make
  (tok1, inss, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSthen (inss))
end // end of [ATSthen_make]
//
implement
ATSelse_make
  (tok1, inss, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSelse (inss))
end // end of [ATSelse_make]
//
(* ****** ****** *)

implement
ATSbranchseq_make
(
  tok1, inss, tok2
) = let
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSbranchseq (inss))
end // end of [ATSbranchseq_make]

(* ****** ****** *)

implement
caseofseq_get_tmplablst
  (ins0) = let
//
vtypedef res = labelist_vt
//
fun
auxlst
(
  xs: instrlst, res: res
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) =>
  (
    case+ x.instr_node of
    | ATSINSlab(lab) =>
        auxlst(xs, cons_vt(lab, res))
    | _(*non-ATSINSlab*) => auxlst(xs, res)
  )
) (* end of [auxlst] *)
//
fun
auxlst2
(
  xs: instrlst, res: res
) : res =
(
case+ xs of
| list_nil () => res
| list_cons (x, xs) =>
  (
    case- x.instr_node of
    | ATSbranchseq(inss) =>
      auxlst2(xs, auxlst(inss, res))
  ) (* end of [list_cons] *)
) (* end of [auxlst2] *)
//
val-
ATScaseofseq(inss) = ins0.instr_node
//
val res = auxlst2(inss, list_vt_nil())
//
in
  list_vt2t(list_vt_reverse(res))
end // end of [caseofseq_get_tmplablst]

(* ****** ****** *)

implement
ATScaseofseq_make
(
  tok1, inss, tok2
) = let
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATScaseofseq (inss))
end // end of [ATScaseofseq_make]

(* ****** ****** *)

implement
funbodyseq_get_funlab
  (ins0) = flab where
{
//
val-
ATSfunbodyseq(inss) = ins0.instr_node
val
inss = instrlst_skip_linepragma (inss)
//
val-list_cons (ins1, _(*inss2*)) = inss
val-ATSINSflab (flab) = ins1.instr_node
//
} // end of [funbodyseq_get_funlab]

(* ****** ****** *)

implement
ATSfunbodyseq_make
(
  tok1, inss, tok2
) = let
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSfunbodyseq (inss))
end // end of [ATSfunbodyseq_make]

(* ****** ****** *)

implement
ATSreturn_make
(
  tok1, tmp, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSreturn (tmp))
end // end of [ATSreturn_make]

(* ****** ****** *)

implement
ATSreturn_void_make
(
  tok1, tmp, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSreturn_void (tmp))
end // end of [ATSreturn_void_make]

(* ****** ****** *)

implement
ATSlinepragma_make
  (tok_kwd, line, file) = let
//
val loc = tok_kwd.token_loc ++ file.token_loc
//
in
  instr_make_node (loc, ATSlinepragma (line, file))
end // end of [ATSlinepragma_make]

(* ****** ****** *)

(* ****** ****** *)

implement
ATSINSlab_make
(
  tok1, lab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSlab (lab))
end // end of [ATSINSlab_make]

(* ****** ****** *)

implement
ATSINSgoto_make
(
  tok1, lab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSgoto (lab))
end // end of [ATSINSgoto_make]

(* ****** ****** *)

implement
ATSINSflab_make
(
  tok1, flab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSflab (flab))
end // end of [ATSINSlab_make]

(* ****** ****** *)

implement
ATSINSfgoto_make
(
  tok1, flab, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSfgoto (flab))
end // end of [ATSINSfgoto_make]

(* ****** ****** *)

implement
ATSINSfreeclo_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSfreeclo (d0e))
end // end of [ATSINSfreeclo_make]

implement
ATSINSfreecon_make
(
  tok1, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSfreecon (d0e))
end // end of [ATSINSfreecon_make]

(* ****** ****** *)

implement
ATSINSmove_make
(
  tok1, tmp, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove (tmp, d0e))
end // end of [ATSINSmove_make]

(* ****** ****** *)

implement
ATSINSmove_void_make
(
  tok1, tmp, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_void (tmp, d0e))
end // end of [ATSINSmove_void_make]

(* ****** ****** *)

implement
ATSINSmove_nil_make
(
  tok1, tmp, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_nil (tmp))
end // end of [ATSINSmove_nil_make]

(* ****** ****** *)

implement
ATSINSmove_con0_make
(
  tok1, tmp, ctag, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_con0 (tmp, ctag))
end // end of [ATSINSmove_con0_make]

(* ****** ****** *)

implement
ATSINSmove_con1_make
(
  tok1, inss, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_con1 (inss))
end // end of [ATSINSmove_con1_make]

(* ****** ****** *)

implement
ATSINSmove_con1_new_make
(
  tok1, tmp, s0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_con1_new (tmp, s0e))
end // end of [ATSINSmove_con1_new_make]

(* ****** ****** *)

implement
ATSINSstore_con1_tag_make
(
  tok1, tmp, ctag, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSstore_con1_tag (tmp, ctag))
end // end of [ATSINSstore_con1_ctag_make]

(* ****** ****** *)

implement
ATSINSstore_con1_ofs_make
(
  tok1, tmp, s0e, lab, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSstore_con1_ofs (tmp, s0e, lab, d0e))
end // end of [ATSINSstore_con1_ofs_make]

(* ****** ****** *)

implement
ATSINSmove_boxrec_make
(
  tok1, inss, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_boxrec (inss))
end // end of [ATSINSmove_boxrec_make]

(* ****** ****** *)

implement
ATSINSmove_boxrec_new_make
(
  tok1, tmp, s0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_boxrec_new (tmp, s0e))
end // end of [ATSINSmove_boxrec_new_make]

(* ****** ****** *)

implement
ATSINSstore_boxrec_ofs_make
(
  tok1, tmp, s0e, lab, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
//
instr_make_node
  (loc, ATSINSstore_boxrec_ofs (tmp, s0e, lab, d0e))
//
end // end of [ATSINSstore_boxrec_ofs_make]

(* ****** ****** *)

implement
ATSINSmove_fltrec_make
(
  tok1, inss, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_fltrec (inss))
end // end of [ATSINSmove_fltrec_make]

(* ****** ****** *)

implement
ATSINSstore_fltrec_ofs_make
(
  tok1, tmp, s0e, lab, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
//
instr_make_node
  (loc, ATSINSstore_fltrec_ofs (tmp, s0e, lab, d0e))
//
end // end of [ATSINSstore_fltrec_ofs_make]

(* ****** ****** *)

implement
ATSINSmove_delay_make
(
  tok1, tmp, s0e_res, thunk, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_delay(tmp, s0e_res, thunk))
end // end of [ATSINSmove_delay_make]

(* ****** ****** *)

implement
ATSINSmove_lazyeval_make
(
  tok1, tmp, s0e_res, lazyval, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_lazyeval(tmp, s0e_res, lazyval))
end // end of [ATSINSmove_lazyeval_make]

(* ****** ****** *)

implement
ATSINSmove_ldelay_make
(
  tok1, tmp, s0e_res, thunk, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_ldelay(tmp, s0e_res, thunk))
end // end of [ATSINSmove_ldelay_make]

(* ****** ****** *)

implement
ATSINSmove_llazyeval_make
(
  tok1, tmp, s0e_res, lazyval, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_llazyeval(tmp, s0e_res, lazyval))
end // end of [ATSINSmove_llazyeval_make]

(* ****** ****** *)

implement
ATStailcalseq_make
(
  tok1, inss, tok2
) = let
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATStailcalseq (inss))
end // end of [ATStailcalseq_make]

(* ****** ****** *)

implement
ATSINSmove_tlcal_make
(
  tok1, apy, d0e, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSmove_tlcal (apy, d0e))
end // end of [ATSINSmove_tlcal_make]

(* ****** ****** *)

implement
ATSINSargmove_tlcal_make
(
  tok1, arg, apy, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSargmove_tlcal (arg, apy))
end // end of [ATSINSargmove_tlcal_make]

(* ****** ****** *)

implement
ATSINSextvar_assign_make
(
  tok1, ext, d0e_r, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSextvar_assign (ext, d0e_r))
end // end of [ATSINSextvar_assign_make]

(* ****** ****** *)

implement
ATSINSdyncst_valbind_make
(
  tok1, d2c, d0e_r, tok2
) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSdyncst_valbind (d2c, d0e_r))
end // end of [ATSINSdyncst_valbind_make]

(* ****** ****** *)

implement
ATSINScaseof_fail_make
  (tok1, errmsg, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINScaseof_fail(errmsg))
end // end of [ATSINScaseof_fail_make]

(* ****** ****** *)

implement
ATSINSdeadcode_fail_make
  (tok1, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSINSdeadcode_fail(tok1))
end // end of [ATSINSdeadcode_fail_make]

(* ****** ****** *)

implement
ATSdynload_make
  (tok1, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSdynload(0))
end // end of [ATSdynload_make]

(* ****** ****** *)

implement
ATSdynloadset_make
  (tok1, id, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSdynloadset(id))
end // end of [ATSdynloadset]

(* ****** ****** *)

implement
ATSdynloadfcall_make
  (tok1, id, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSdynloadfcall(id))
end // end of [ATSdynloadfcall]

(* ****** ****** *)

implement
ATSdynloadflag_sta_make
  (tok1, id, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSdynloadflag_sta(id))
end // end of [ATSdynloadflag_sta_make]

(* ****** ****** *)

implement
ATSdynloadflag_ext_make
  (tok1, id, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  instr_make_node (loc, ATSdynloadflag_ext(id))
end // end of [ATSdynloadflag_ext_make]

(* ****** ****** *)

implement
f0body_classify
  (fbody) = let
//
fun
fcount
(
  xs: instrlst, res: int
) : int =
(
case+ xs of
| list_nil () => res
| list_cons (x, xs) => (
    case+ x.instr_node of
    | ATSfunbodyseq _ => fcount (xs, res+1) | _ => fcount (xs, res)
  ) (* end of [list_cons] *)
)
//
fun
istailcal
(
  inss: instrlst
) : bool = let
//
(*
val () =
fprintln!
  (stdout_ref, "istailcal: inss = ", inss)
*)
//
fun
aux (x: instr): bool = let
//
(*
val () =
fprintln! (stdout_ref, "istailcal: aux: x = ", x)
*)
//
in
//
case+
x.instr_node
of // case+
| ATStailcalseq _ => true
| ATSif (_, _then, _else) =>
    if auxlst (_then) then true else auxlstopt (_else)
| ATSbranchseq (inss) => auxlst (inss)
| ATScaseofseq (inss) => auxlst (inss)
| ATSfunbodyseq (inss) => auxlst (inss)
| _(*rest-of-instr*) => false
//
end // end of [aux]
//
and auxlst
  (xs: instrlst): bool =
(
case+ xs of
| list_nil () => false
| list_cons (x, xs) =>
    if aux (x) then true else auxlst (xs)
  // end of [list_cons]
)
//
and auxlstopt
  (opt: instrlstopt): bool =
(
case+ opt of
| None () => false | Some (inss) => auxlst (inss)
)
//
in
  auxlst (inss)
end // end of [istailcal]
//
in
//
case+
fbody.f0body_node of
| F0BODY
    (tds, inss) => let
    val nf = fcount (inss, 0)
(*
    val () =
      fprintln! (stdout_ref, "f0body_classify: nf = ", nf)
    // end of [val]
*)
  in
    if nf >= 2 then 2 else (if istailcal (inss) then 1 else 0)
  end // end of [...]
//
end // end of [f0body_classify]

(* ****** ****** *)

implement
f0body_get_tmpdeclst
  (fbody) =
(
//
case+
fbody.f0body_node of F0BODY (tds, _) => tds
//
) (* end of [f0body_get_tmpdeclst] *)

(* ****** ****** *)

implement
f0body_get_bdinstrlst
  (fbody) =
(
//
case+
fbody.f0body_node of F0BODY (_, inss) => inss
//
) (* end of [f0body_get_bdinstrlst] *)

(* ****** ****** *)

implement
f0body_make
(
  tok_beg, tmps, inss, tok_end
) = let
//
val loc =
  tok_beg.token_loc ++ tok_end.token_loc
//
in '{
  f0body_loc= loc, f0body_node= F0BODY (tmps, inss)
} end // end of [f0body_make]

(* ****** ****** *)

implement
f0decl_none
  (head) = let
//
val loc = head.f0head_loc
//
in '{
  f0decl_loc= loc, f0decl_node= F0DECLnone(head)
} end // end of [f0decl_none]

(* ****** ****** *)

implement
f0decl_some
  (head, body) = let
//
val loc =
  head.f0head_loc ++ body.f0body_loc
//
in '{
  f0decl_loc= loc, f0decl_node= F0DECLsome(head, body)
} end // end of [f0decl_some]

(* ****** ****** *)

fun
d0ecl_make_node
(
  loc: loc_t, node: d0ecl_node
) : d0ecl = '{ d0ecl_loc= loc, d0ecl_node= node }

(* ****** ****** *)

implement
d0ecl_include
  (tok, fname) = let
//
val loc = tok.token_loc ++ fname.token_loc
//
in
  d0ecl_make_node (loc, D0Cinclude (fname))
end // end of [d0ecl_include]

(* ****** ****** *)

implement
d0ecl_ifdef
(
  tok1, id, d0cs, tok2
) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cifdef (id, d0cs))
end // end of [d0ecl_ifdef]
  
(* ****** ****** *)

implement
d0ecl_ifndef
(
  tok1, id, d0cs, tok2
) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cifdef (id, d0cs))
end // end of [d0ecl_ifndef]
  
(* ****** ****** *)

implement
d0ecl_assume
  (tok1, name, tok2) = let
//
val loc =
  tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cassume (name))
end // end of [d0ecl_assume]

(* ****** ****** *)

implement
d0ecl_dyncst_mac
  (tok1, name, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdyncst_mac (name))
end // end of [d0ecl_dyncst_mac]

(* ****** ****** *)

implement
d0ecl_dyncst_extfun
  (tok1, name, s0es, s0e, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
//
d0ecl_make_node(loc, D0Cdyncst_extfun(name, s0es, s0e))
//
end // end of [d0ecl_dyncst_extfun]

(* ****** ****** *)

implement
d0ecl_dyncst_valdec
  (tok1, name, d0c_type, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdyncst_valdec(name, d0c_type))
end // end of [d0ecl_dyncst_valdec]

(* ****** ****** *)

implement
d0ecl_dyncst_valimp
  (tok1, name, d0v_type, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdyncst_valimp(name, d0v_type))
end // end of [d0ecl_dyncst_valimp]

(* ****** ****** *)

implement
d0ecl_typedef
  (tok, tyrec, id) = let
//
val loc = tok.token_loc ++ id.i0dex_loc
//
in
  d0ecl_make_node (loc, D0Ctypedef (id, tyrec))
end // end of [d0ecl_typedef]

(* ****** ****** *)

implement
d0ecl_extcode
(
  tok1, extcode, tok2
) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cextcode (extcode))
end // end of [d0ecl_extcode]

(* ****** ****** *)
//
implement
d0ecl_statmp_none
  (tok1, tmp, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cstatmp (tmp, None()))
end // end of [d0ecl_statmp_none]
//
implement
d0ecl_statmp_some
  (tok1, tmp, s0e, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cstatmp (tmp, Some(s0e)))
end // end of [d0ecl_statmp_some]
//
(* ****** ****** *)

implement
d0ecl_fundecl
  (fk, fdec) = let
//
val loc = fk.fkind_loc ++ fdec.f0decl_loc
//
in
  d0ecl_make_node (loc, D0Cfundecl (fk, fdec))
end // end of [d0ecl_fundecl]

(* ****** ****** *)

implement
d0ecl_closurerize
(
  tok1, fl, env, arg, res, tok2
) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cclosurerize (fl, env, arg, res))
end // end of [d0ecl_closurerize]

(* ****** ****** *)

implement
d0ecl_dynloadflag_init
  (tok1, flag, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdynloadflag_init (flag))
end // end of [d0ecl_dynloadflag_init]

implement
d0ecl_dynloadflag_minit
  (tok1, flag, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdynloadflag_minit (flag))
end // end of [d0ecl_dynloadflag_minit]

(* ****** ****** *)

implement
d0ecl_dynexn_dec
  (tok1, idexn, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdynexn_dec (idexn))
end // end of [d0ecl_dynexn_dec]

implement
d0ecl_dynexn_extdec
  (tok1, idexn, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdynexn_extdec (idexn))
end // end of [d0ecl_dynexn_extdec]

implement
d0ecl_dynexn_initize
  (tok1, idexn, fullname, tok2) = let
//
val loc = tok1.token_loc ++ tok2.token_loc
//
in
  d0ecl_make_node (loc, D0Cdynexn_initize (idexn, fullname))
end // end of [d0ecl_dynexn_initize]

(* ****** ****** *)

(* end of [catsparse_syntax.dats] *)
