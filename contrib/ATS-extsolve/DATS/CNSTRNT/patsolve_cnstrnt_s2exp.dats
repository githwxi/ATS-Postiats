(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)

implement
s2exp_make_node
  (s2t, s2en) = '{
  s2exp_srt= s2t, s2exp_node= s2en
} (* end of [s2exp_make_node] *)

(* ****** ****** *)
//
implement
s2exp_var(s2v) =
  s2exp_make_node(s2v.srt(), S2Evar(s2v))
implement
s2exp_eqeq(s2e1, s2e2) =
  s2exp_make_node(s2rt_bool(), S2Eeqeq(s2e1, s2e2))
//
(* ****** ****** *)
//
implement
s2exp_is_impred
  (s2e0) = s2rt_is_impred(s2e0.s2exp_srt)
//
(* ****** ****** *)

implement
fprint_tyreckind
  (out, knd) = (
//
case+ knd of
//
| TYRECKINDbox() =>
    fprint! (out, "TYRECKINDbox(", ")")
| TYRECKINDbox_lin() =>
    fprint! (out, "TYRECKINDbox_lin(", ")")
//
| TYRECKINDflt0() =>
    fprint! (out, "TYRECKINDflt0(", ")")
| TYRECKINDflt1(stamp) =>
    fprint! (out, "TYRECKINDflt1(", stamp, ")")
| TYRECKINDflt_ext (name) =>
    fprint! (out, "TYRECKINDflt_ext(", name, ")")
//
) (* end of [fprint_tyreckind] *)

(* ****** ****** *)

implement
fprint_s2exp
  (out, s2e) = let
in
//
case+
s2e.s2exp_node
of // case+
//
| S2Eint(i) => fprint! (out, "S2Eint(", i, ")")
| S2Eintinf(i) => fprint! (out, "S2Eintinf(", i, ")")
//
| S2Ecst(s2c) => fprint! (out, "S2Ecst(", s2c, ")")
| S2Evar(s2v) => fprint! (out, "S2Evar(", s2v, ")")
| S2EVar(s2V) => fprint! (out, "S2EVar(", s2V, ")")
//
| S2Eeqeq(s2e1, s2e2) =>
    fprint! (out, "S2Eeqeq(", s2e1, ", ", s2e2, ")")
//
| S2Esizeof(s2e) => fprint! (out, "S2Esizeof(", s2e, ")")
//
| S2Eapp(s2e_fun, s2es_arg) =>
    fprint! (out, "S2Eapp(", s2e_fun, "; ", s2es_arg, ")")
//
| S2Emetdec(s2es_met, s2es_bound) =>
    fprint! (out, "S2Emetdec(", s2es_met, "; ", s2es_bound, ")")
//
| S2Etop(knd, s2e) =>
    fprint! (out, "S2Etop(", knd, ", ", s2e, ")")
//
| S2Einvar(s2e) => fprint! (out, "S2Einvar(", s2e, ")")
//
| S2Efun(nof, s2es, s2e) =>
    fprint! (out, "S2Efun(", s2es, "; ", s2e, ")")
//
| S2Euni(s2vs, s2ps, s2e) =>
    fprint! (out, "S2Euni(", s2vs, "; ", s2ps, "; ", s2e, ")")
| S2Eexi(s2vs, s2ps, s2e) =>
    fprint! (out, "S2Eexi(", s2vs, "; ", s2ps, "; ", s2e, ")")
//
| S2Etyrec(knd, npf, s2es_elt) =>
    fprint! (out, "S2Etyrec(", knd, "; ", s2es_elt, ")")
//
| S2Eextype(name) => fprint! (out, "S2Eextype(", name, ")")
| S2Eextkind(name) => fprint! (out, "S2Eextkind(", name, ")")
//
| S2Eerror((*void*)) => fprint! (out, "S2Eerror()")
//
end // end of [fprint_s2exp]

(* ****** ****** *)

implement
fprint_s2explst
  (out, s2es) = let
//
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<s2exp> (out, s2es)
end // end of [fprint_s2explst]

(* ****** ****** *)

implement
fprint_labs2exp
  (out, ls2e) = let
//
val+SLABELED(l, s2e) = ls2e
//
in
  fprint! (out, l, "->", s2e)
end // end of [fprint_labs2exp]

(* ****** ****** *)

implement
fprint_labs2explst
  (out, ls2es) = let
//
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<labs2exp> (out, ls2es)
end // end of [fprint_labs2explst]

(* ****** ****** *)

(* end of [patsolve_cnstrnt_s2exp.dats] *)
