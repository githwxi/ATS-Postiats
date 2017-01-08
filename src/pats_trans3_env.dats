(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: October, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload
UT = "./pats_utils.sats"
vtypedef
charlst_vt = $UT.charlst_vt
macdef charset_listize = $UT.charset_listize

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"
vtypedef
intinflst_vt = $INTINF.intinflst_vt
macdef intinfset_listize = $INTINF.intinfset_listize

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_env"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"
staload "./pats_patcst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload TR2 = "./pats_trans2.sats"
staload TRENV2 = "./pats_trans2_env.sats"

(* ****** ****** *)

staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
filenv_get_d3eclistopt (fenv) = let
  val p = $TRENV2.filenv_getref_d3eclistopt (fenv) in $UN.ptrget<d3eclistopt> (p)
end // end of [filenv_get_d3eclistopt]

(* ****** ****** *)

implement
c3nstr_prop
  (loc, s2e) = '{
  c3nstr_loc= loc
, c3nstr_kind= C3TKmain()
, c3nstr_node= C3NSTRprop(s2e)
} // end of [c3nstr_prop]

implement
c3nstr_itmlst
  (loc, knd, s3is) = '{
  c3nstr_loc= loc
, c3nstr_kind= knd
, c3nstr_node= C3NSTRitmlst (s3is)
} // end of [c3nstr_itmlst]

implement
c3nstr_case_exhaustiveness
  (loc, casknd, p2tcs) = let
  val p2tcs = list_vt_copy (p2tcs)
in '{
  c3nstr_loc= loc
, c3nstr_kind=
    C3TKcase_exhaustiveness (casknd, (l2l)p2tcs)
  // c3nstr_kind
, c3nstr_node= C3NSTRprop(s2exp_bool(false))
} end // end of [c3nstr_case_exhaustiveness]

implement
c3nstr_termet_isnat
  (loc, s2e) = '{
  c3nstr_loc= loc
, c3nstr_kind= C3TKtermet_isnat
, c3nstr_node=
    C3NSTRprop(s2exp_intgte(s2e, s2exp_int(0)))
  // end of [c3str_node]
} // end of [c3nstr_termet_isnat]

implement
c3nstr_termet_isdec
  (loc, met, mbd) = '{
  c3nstr_loc= loc
, c3nstr_kind= C3TKtermet_isdec
, c3nstr_node= C3NSTRprop(s2exp_metdec(met, mbd))
} // end of [c3nstr_termet_isdec]

(* ****** ****** *)

implement
c3nstr_solverify
  (loc, s2e_prop) = let
in '{
  c3nstr_loc=loc
, c3nstr_kind= C3TKsolverify()
, c3nstr_node= C3NSTRsolverify(s2e_prop)
} end // end of [c3nstr_solverify]

(* ****** ****** *)

implement
c3nstroptref_make_none
  (loc) = let
  val ref = ref<c3nstropt> (None)
in '{
  c3nstroptref_loc= loc, c3nstroptref_ref= ref
} end // end of [c3nstroptref_make_none]

(* ****** ****** *)

implement
h3ypo_prop
  (loc, s2p) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOprop (s2p)
} // end of [h3ypo_prop]

implement
h3ypo_bind
  (loc, s2v1, s2f2) = let
  val s2e2 = s2hnf2exp (s2f2) in '{
  h3ypo_loc= loc, h3ypo_node = H3YPObind (s2v1, s2e2)
} end // end of [h3ypo_bind]

implement
h3ypo_eqeq
  (loc, s2f1, s2f2) = let
  val s2e1 = s2hnf2exp (s2f1)
  val s2e2 = s2hnf2exp (s2f2) in '{
  h3ypo_loc= loc, h3ypo_node = H3YPOeqeq (s2e1, s2e2)
} end // end of [h3ypo_eqeq]

(* ****** ****** *)

implement
s2exp_Var_make_srt
  (loc, s2t) = let
  val s2V = s2Var_make_srt (loc, s2t)
  val () = trans3_env_add_sVar (s2V)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_srt]

implement
s2exp_Var_make_var (loc, s2v) = let
(*
  val () = begin
    print "s2exp_Var_make_var: s2v = "; print_s2var s2v; print_newline ()
  end // end of [val]
*)
  val s2V = s2Var_make_var (loc, s2v)
(*
  val () = begin
    print "s2exp_Var_make_var: s2V = "; print_s2Var s2V; print_newline ()
  end // end of [val]
*)
  val () = trans3_env_add_sVar (s2V)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_var]

(* ****** ****** *)

implement
stasub_make_svarlst
  (loc, s2vs) = let
(*
val () = (
  print "stasub_make_svarlst: s2vs = ";
  print_s2varlst (s2vs); print_newline ()
) // end of [val]
*)
fun loop (
  loc: location, s2vs: s2varlst, sub: &stasub
) : void =
  case+ s2vs of
  | list_cons (s2v, s2vs) => let
      val s2e =
        s2exp_Var_make_var (loc, s2v)
      // end of [val]
      val () = stasub_add (sub, s2v, s2e)
    in
      loop (loc, s2vs, sub)
    end // end of [list_cons]
  | list_nil () => ()
// end of [loop]
//
var sub = stasub_make_nil ()
val () = loop (loc, s2vs, sub)
//
in
  sub
end // end of [stasub_make_svarlst]

(* ****** ****** *)

local

fun
stasub_s2varlst_instantiate_none
(
  sub: &stasub
, locarg: location, s2vs: s2varlst
, err: &int // HX: [err] is not used
) : void = let
//
macdef loop = stasub_s2varlst_instantiate_none
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
    val s2e =
      s2exp_Var_make_var (locarg, s2v)
    // end of [val]
    val () = stasub_add (sub, s2v, s2e)
  in
    loop (sub, locarg, s2vs, err)
  end // end of [list_cons]
| list_nil () => () // end of [list_nil]
//
end // end of [stasub_s2varlst_instantiate_none]

fun
stasub_s2varlst_instantiate_some
(
  sub: &stasub
, locarg: location, s2vs: s2varlst, s2es: s2explst
, err: &int
) : void = let
//
macdef loop = stasub_s2varlst_instantiate_some
//
fun
auxerr1
(
  locarg: location, serr: int
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "stasub_s2varlst_instantiate_some"
  val () = prerr ": static arity mismatch"
  val () = if serr > 0 then prerr ": more arguments are expected."
  val () = if serr < 0 then prerr ": fewer arguments are expected."
  val () = prerr_newline ((*void*))
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_arity (locarg, serr))
end // end of [auxerr1]
fun
auxerr2
(
  locarg: location, s2t1: s2rt, s2t2: s2rt
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "stasub_s2varlst_instantiate_some"
  val () = prerr ": mismatch of sorts:\n"
  val () = prerrln! ("the needed sort is [", s2t1, "];")
  val () = prerrln! ("the actual sort is [", s2t2, "].")
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_srtck (locarg, s2t1, s2t2))
end // end of [auxerr2]
//
in
//
case+ s2vs of
| list_cons
    (s2v, s2vs) => (
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val s2t1 = s2var_get_srt (s2v)
      val s2t2 = s2e.s2exp_srt
      val ismat = s2rt_ltmat1 (s2t2, s2t1)
    in
      if ismat then let
        val () = stasub_add (sub, s2v, s2e)
      in
        loop (sub, locarg, s2vs, s2es, err)
      end else let
        val () = err := err + 1
        val () = auxerr2 (locarg, s2t1, s2t2)
        val () = stasub_add (sub, s2v, s2exp_errexp(s2t1))
      in
        loop (sub, locarg, s2vs, s2es, err)
      end (* end of [if] *)
    end // end of [list_cons]
  | list_nil () => let
      val () = err := err + 1
      val () = auxerr1 (locarg, 1) // HX: more arguments expected
    in
      // nothing
    end // end of [list_nil]
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es of
  | list_cons _ => let
      val () = err := err + 1
      val () = auxerr1 (locarg, ~1) // HX: fewer arguments expected
    in
      // nothing
    end // end of [list_cons]
  | list_nil () => ()
  ) // end of [list_nil]
end // end of [stasub_s2varlst_instantiate_some]

fun
stasub_s2varlst_instcollect
(
  sub: &stasub
, locarg: location, s2vs: s2varlst, res: s2explst_vt
) : s2explst_vt = let
//
macdef loop = stasub_s2varlst_instcollect
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
(*
    val () = (
      print "stasub_addsvs: s2v = "; print_s2var s2v; print_newline ()
    ) // end of [val]
*)
    val s2e =
      s2exp_Var_make_var (locarg, s2v)
    // end of [val]
    val () = stasub_add (sub, s2v, s2e)
    val res = list_vt_cons (s2e, res)
  in
    loop (sub, locarg, s2vs, res)
  end // end of [list_cons]
| list_nil () => list_vt_reverse (res)
//
end // end of [stasub_s2varlst_instcollect]

in (* in of [local] *)

implement
s2exp_exiuni_instantiate_all
  (knd, s2e0, locarg, err) = let // HX: [err] is not used
//
fun loop (
  sub: &stasub
, s2f: s2hnf
, s2ps_res: &s2explst_vt
, err: &int
) :<cloref1> s2exp = let
  val s2e = s2hnf2exp (s2f)
  var s2vs: s2varlst
  and s2ps: s2explst
  var s2e1: s2exp // scope
  val ans = uns2exp_exiuni (knd, s2e, s2vs, s2ps, s2e1)
in
//
case+ ans of
| true => let
    // HX: [sub] should be properly extended first
    val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
    val s2ps = s2explst_subst_vt (sub, s2ps)
    val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
    val s2f1 = s2exp2hnf (s2e1)
  in
    loop (sub, s2f1, s2ps_res, err)
  end // end of [S2Euni/S2Eexi]
| false => s2exp_subst (sub, s2e)
//
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val s2f0 = s2exp2hnf (s2e0)
var s2ps_res: s2explst_vt = list_vt_nil ()
val s2e_res = loop (sub, s2f0, s2ps_res, err)
val () = stasub_free (sub)
val s2ps_res = list_vt_reverse (s2ps_res)
//
in
  (s2e_res, s2ps_res)
end // end of [s2exp_exiuni_instantiate_all]

implement
s2exp_exi_instantiate_all
  (s2e0, locarg, err) =
  s2exp_exiuni_instantiate_all (0, s2e0, locarg, err)
// end of [s2exp_exi_instantiate_all]

implement
s2exp_uni_instantiate_all
  (s2e0, locarg, err) =
  s2exp_exiuni_instantiate_all (1, s2e0, locarg, err)
// end of [s2exp_uni_instantiate_all]

implement
s2exp_unimet_instantiate_all
  (s2e0, locarg, err) = let
  val (s2e, s2ps_fst) =
    s2exp_uni_instantiate_all(s2e0, locarg, err)
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf2exp (s2f)
in
//
case s2e.s2exp_node of
| S2Emetfun
    (opt, s2es_met, s2e) => (
  case+ opt of
  | Some stamp => let
      val () = s2exp_termet_instantiate (locarg, stamp, s2es_met)
      val (s2e, s2ps_rest) = s2exp_uni_instantiate_all (s2e, locarg, err)
      val s2ps_all = (
        case+ s2ps_rest of
        | list_vt_cons _ => let
            prval () = fold@(s2ps_rest) in list_vt_append(s2ps_fst, s2ps_rest)
          end // end of [list_vt_cons]
        | ~list_vt_nil () => s2ps_fst
      ) : s2explst_vt // end of [val]
    in
      (s2e, s2ps_all)
    end // end of [S2Emetfun]
  | None () => (s2e, s2ps_fst)
  ) // end of [S2Emetfun]
| _ => (s2e, s2ps_fst)
//
end // end of [s2exp_unimet_instantiate_all]

(* ****** ****** *)

implement
s2exp_exi_instantiate_sexparg
  (s2e0, s2a, err) = let
//
val locarg = s2a.s2exparg_loc
//
fun
auxerr
(
  locarg: location
) : void = let
  val () =
  prerr_error3_loc(locarg)
  val () =
  filprerr_ifdebug "s2exp_exi_instantiate_sexparg"
  val () =
  prerrln! ": the static abstraction is overly done."
in
  the_trans3errlst_add(T3E_s2varlst_instantiate_nabs(locarg, 1))
end (* end of [auxerr] *)
//
in
//
case+
s2a.s2exparg_node
of (* case+ *)
//
| S2EXPARGall () =>
    s2exp_exi_instantiate_all (s2e0, locarg, err)
  // end of [S2EXPARGall]
//
| S2EXPARGone () => let
    val s2e0 = s2exp_hnfize (s2e0)
  in
    case+
    s2e0.s2exp_node
    of // case+
    | S2Eexi (
        s2vs, s2ps, s2e1
      ) => let
        var sub: stasub = stasub_make_nil ()
        val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
        val s2e1 = s2exp_subst (sub, s2e1)
        val s2ps = s2explst_subst_vt (sub, s2ps)
        val ((*freed*)) = stasub_free (sub)
      in
        (s2e1, s2ps)
      end // end of [S2Eexi]
    | _ (*non-S2Eexi*) => let
        val () = err := err + 1
        val () = auxerr (locarg) in (s2e0, list_vt_nil)
      end // end of [_]
   end
//
| S2EXPARGseq (s2es) => let
    val s2e0 = s2exp_hnfize (s2e0)
  in
    case+
    s2e0.s2exp_node
    of // case+
    | S2Eexi (
        s2vs, s2ps, s2e1
      ) => let
        var sub: stasub = stasub_make_nil ()
        val () = stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, err)
        val s2e1 = s2exp_subst (sub, s2e1)
        val s2ps = s2explst_subst_vt (sub, s2ps)
        val () = stasub_free (sub)
      in
        (s2e1, s2ps)
      end // end of [S2Eexi]
    | _ (*non-S2Eexi*) => let
        val () = err := err + 1
        val () = auxerr (locarg) in (s2e0, list_vt_nil)
      end (* end of [_] *)
  end // end of [S2EXPARGseq]
//
end // end of [s2exp_exi_instantiate_sexparg]

(* ****** ****** *)

implement
s2exp_uni_instantiate_sexparglst
  (s2e0, s2as, err) = let
//
fun
auxerr
(
  locarg: location
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "s2exp_uni_instantiate_sexparglst"
  val () = prerr ": the static application is overly done."
  val () = prerr_newline ((*void*))
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_napp (locarg, 1))
end (* end of [auxerr] *)
//
fun loop
(
  sub: &stasub
, s2f: s2hnf
, s2ps_res: &s2explst_vt
, s2as: s2exparglst
, err: &int
) : s2exp = let
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2as of
| list_cons (s2a, s2as1) => let
    val locarg = s2a.s2exparg_loc
  in
    case+ s2a.s2exparg_node of
    | S2EXPARGall () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          // HX: [sub] should be properly extended first
          val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
          val s2ps = s2explst_subst_vt (sub, s2ps)
          val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2ps_res, s2as, err)
        end
      | _ => loop (sub, s2f, s2ps_res, s2as1, err)
      ) // end of [S2EXPARGall]
    | S2EXPARGone () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          // HX: [sub] should be properly extended first
          val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
          val s2ps = s2explst_subst_vt (sub, s2ps)
          val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2ps_res, s2as1, err)
        end // end of [S2Euni]
      | _ => let
          val () = err := err + 1
          val () = auxerr (locarg)
        in
          loop (sub, s2f, s2ps_res, s2as1, err)
        end (* end of [_] *)
      ) // end of [S2EXPARGone]
    | S2EXPARGseq (s2es) => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          // HX: [sub] should be properly extended first
          val () = stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, err)
          val s2ps = s2explst_subst_vt (sub, s2ps)
          val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2ps_res, s2as1, err)
        end // end of [S2Euni]
      | _ => let
          val () = err := err + 1
          val () = auxerr (locarg)
        in
          loop (sub, s2f, s2ps_res, s2as1, err)
        end (* end of [_] *)
      ) // end of [S2EXPARGseq]
  end // end of [list_cons]
| list_nil () => let
    val s2e = s2hnf2exp (s2f) in s2exp_subst (sub, s2e)
  end // end of [list_nil]
//
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val s2f0 = s2exp2hnf (s2e0)
var s2ps_res: s2explst_vt = list_vt_nil ()
val s2e_res = loop (sub, s2f0, s2ps_res, s2as, err)
val () = stasub_free (sub)
val s2ps_res = list_vt_reverse (s2ps_res)
//
in
  (s2e_res, s2ps_res)
end // end of [s2exp_uni_instantiate_sexparglst]

(* ****** ****** *)

implement
s2exp_tmp_instantiate_rest
  (s2e_tmp, locarg, s2qs, nerr) = let
//
fun loop (
  locarg: location
, sub: &stasub
, s2qs: s2qualst
, t2mas: t2mpmarglst_vt
, nerr: &int // HX: unused
) : t2mpmarglst_vt = let
in
  case+ s2qs of
  | list_nil() =>
      list_vt_reverse (t2mas)
    // end of [list_nil]
  | list_cons(s2q, s2qs) => let
//
      val
      s2vs = s2q.s2qua_svs
      val () =
      assertloc(list_is_nil(s2q.s2qua_sps))
//
      val s2es =
      stasub_s2varlst_instcollect(sub, locarg, s2vs, list_vt_nil)
//
      val t2ma =
        t2mpmarg_make (locarg, (l2l)s2es)
      val t2mas = list_vt_cons (t2ma, t2mas)
//
    in
      loop (locarg, sub, s2qs, t2mas, nerr)
    end // end of [list_cons]
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
//
val
t2mas =
loop (
  locarg, sub, s2qs, list_vt_nil, nerr
) (* end of [val] *)
//
val s2e_res = s2exp_subst (sub, s2e_tmp)
//
val ((*freed*)) = stasub_free (sub)
//
in
  (s2e_res, (l2l)t2mas)
end // end of [s2exp_tmp_instantiate_rest]

(* ****** ****** *)

implement
s2exp_tmp_instantiate_tmpmarglst
  (s2e_tmp, locarg, s2qs, t2mas, nerr) = let
//
fun
auxerr
(
  locarg: location
) : void = let
  val () =
  prerr_error3_loc (locarg)
  val () =
  filprerr_ifdebug "s2exp_tmp_instantiate_tmpmarglst"
  val () =
  prerrln! ": the template instantiation is overly done."
in
  the_trans3errlst_add(T3E_s2varlst_instantiate_napp(locarg, 1))
end (* end of [auxerr] *)
//
var locarg: location = locarg
//
fun
auxsome
(
  sub: &stasub
, locarg: &location
, s2qs: s2qualst
, t2mas: t2mpmarglst
, nerr: &int
) : s2qualst = let
in
//
case+ s2qs of
| list_nil () => (
  case+ t2mas of
  | list_nil() => list_nil ()
  | list_cons(t2ma, t2mas) => let
      val () = nerr := nerr + 1
      val () = locarg := t2ma.t2mpmarg_loc
      val () = auxerr (locarg)
    in
      auxsome (sub, locarg, s2qs, t2mas, nerr)
    end // end of [list_cons]
  ) (* end of [list_nil] *)
| list_cons(s2q, s2qs1) => (
  case+ t2mas of
  | list_nil() => s2qs
  | list_cons(t2ma, t2mas) => let
//
      val
      s2vs = s2q.s2qua_svs
      val () =
      assertloc(list_is_nil(s2q.s2qua_sps))
//
      val
      s2es = t2ma.t2mpmarg_arg
      val () = locarg := t2ma.t2mpmarg_loc
//
      val () =
      stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, nerr)
//
    in
      auxsome (sub, locarg, s2qs1, t2mas, nerr)
    end // end of [list_cons]
  ) (* end of [list_cons] *)
//
end // end of [auxsome]
//
var sub
  : stasub = stasub_make_nil()
// end of [var]
val
s2qs =
auxsome
(
  sub, locarg, s2qs, t2mas, nerr
) (* end of [val] *)
//
val
s2e_res = s2exp_subst (sub, s2e_tmp)
//
val ((*freed*)) = stasub_free (sub)
//
in
//
case+ s2qs of
//
| list_nil() => (s2e_res, t2mas)
//
| list_cons _ => let
    val locarg =
      $LOC.location_rightmost (locarg)
    val (s2e2_res, t2mas2) =
      s2exp_tmp_instantiate_rest (s2e_res, locarg, s2qs, nerr)
  in
    (s2e2_res, list_append (t2mas, t2mas2))
  end // end of [list_cons]
//
end // end of [s2exp_tmp_instantiate_tmpmarglst]

end // end of [local]

(* ****** ****** *)

extern
fun the_s2Varset_env_push (): void
extern
fun the_s2Varset_env_pop (): s2Varset
extern
fun the_s2Varset_env_get (): s2Varset
extern
fun the_s2Varset_env_add (x: s2Var): void

local
//
vtypedef
s2Varsetlst_vt = List_vt(s2Varset)
//
val s2Varset_nil = s2Varset_nil ()
val the_s2Varset = ref_make_elt<s2Varset> (s2Varset_nil)
val the_s2Varsetlst = ref_make_elt<s2Varsetlst_vt> (list_vt_nil ())
//
in (* in of [local] *)

implement
the_s2Varset_env_get () = !the_s2Varset

implement
the_s2Varset_env_add (x) = begin
  !the_s2Varset := s2Varset_add (!the_s2Varset, x)
end // end of [the_s2Varset_env_add]

implement
the_s2Varset_env_push () = let
  val xs = !the_s2Varset
  val (vbox pf | pp) = ref_get_view_ptr (the_s2Varsetlst)
  val () = !pp := list_vt_cons (xs, !pp)
in
  // nothing
end // end of [the_s2Varset_env_push]

implement
the_s2Varset_env_pop () = let
  val s2Vs = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s2Varsetlst)
  in
    case+ !pp of
    | ~list_vt_cons (xs, xss) => let val () = !pp := xss in xs end
    | list_vt_nil () => let prval () = fold@ (!pp) in s2Varset_nil end
  end : s2Varset
  val xs = !the_s2Varset
  val () = !the_s2Varset := s2Vs
in
  xs
end // end of [the_s2Varset_env_pop]

end // end of [local]

(* ****** ****** *)
//
// HX:
// it is declared in [pats_staexp2_util.sats]
//
implement
s2exp_hnfize_flag_svar
  (s2e0, s2v, flag) = let
//
(*
val () =
(
  print ("s2exp_hnfize_flag_svar: s2v = ", s2v)
) (* end of [val] *)
*)
//
val ans = the_s2varbindmap_search (s2v)
//
in
//
case+ ans of
| ~None_vt () => s2e0
| ~Some_vt s2e => let
    val () = flag := flag + 1 in s2exp_hnfize (s2e)
  end // end of [Some_vt]
//
end // end of [s2exp_hnfize_flag_svar]

(* ****** ****** *)

local
//
typedef
aux1_type
(
  a:type
) = (s2var, a) -> bool
//
extern
fun aux1_s2exp: aux1_type(s2exp)
and aux1_s2explst: aux1_type(s2explst)
and aux1_s2explstlst: aux1_type(s2explstlst)
//
extern
fun aux1_s2var: aux1_type(s2var)
//
in (* in-of-local *)

implement
aux1_s2exp
  (s2v0, s2e0) = let
//
(*
val () =
println!
  ("aux1_s2exp: s2v0 = ", s2v0)
val () =
println!
  ("aux1_s2exp: s2e0 = ", s2e0)
*)
//
in
//
case+
s2e0.s2exp_node
of // case+
(*
//
| S2Eint _ => false
| S2Eintinf _ => false
//
| S2Efloat _ => false
| S2Estring _ => false
//
| S2Ecst(s2c) => false
//
*)
| S2Evar(s2v) =>
  if (s2v0 = s2v)
    then true else aux1_s2var(s2v0, s2v)
  // end of [if]  
//
| S2Eapp(s2e, s2es) =>
  if aux1_s2exp(s2v0, s2e)
    then true else aux1_s2explst(s2v0, s2es)
  // end of [if] // end of [S2Eapp]
//
| S2Eextype
    (_(*name*), s2ess) =>
    aux1_s2explstlst (s2v0, s2ess)
| S2Eextkind
    (_(*name*), s2ess) =>
    aux1_s2explstlst (s2v0, s2ess)
//
| S2Esizeof(s2e) => aux1_s2exp(s2v0, s2e)
//
| S2Eeqeq(s2e1, s2e2) =>
  if aux1_s2exp(s2v0, s2e1)
    then true else aux1_s2exp(s2v0, s2e2)
  // end of [if] // end of [S2Eeqeq]
//
| S2Einvar(s2e) => aux1_s2exp(s2v0, s2e)
| S2Erefarg (_, s2e) => aux1_s2exp(s2v0, s2e)
//
| S2Elam(s2vs, s2e) => aux1_s2exp(s2v0, s2e)
//
| S2Efun(
    fc,  lin, s2fe
  , npf, s2es_arg, s2e_res
  ) =>
  if aux1_s2explst(s2v0, s2es_arg)
    then true else aux1_s2exp(s2v0, s2e_res)
  // end of [if] // end of [S2Efun]
//
| _ (* rest-of-S2E *) => false
//
end // end of [aux1_s2exp]

implement
aux1_s2explst
  (s2v0, s2es) =
(
case+ s2es of
| list_nil() => false
| list_cons(s2e, s2es) =>
  if aux1_s2exp(s2v0, s2e)
    then true else aux1_s2explst(s2v0, s2es)
  // end of [if] // end of [list_cons]
)

implement
aux1_s2explstlst
  (s2v0, s2ess) =
(
case+ s2ess of
| list_nil() => false
| list_cons(s2es, s2ess) =>
  if aux1_s2explst(s2v0, s2es)
    then true else aux1_s2explstlst(s2v0, s2ess)
  // end of [if] // end of [list_cons]
)

implement
aux1_s2var
  (s2v0, s2v) = let
//
val ans =
  the_s2varbindmap_search (s2v)
//
in
//
case+ ans of
| ~None_vt() => false
| ~Some_vt(s2e) => aux1_s2exp(s2v0, s2e)
//
end // end of [aux1_s2var]

(* ****** ****** *)

implement
s2var_occurcheck_s2exp
  (s2v0, s2e0) = let
//
(*
val () =
println!
  ("s2var_occurcheck_s2exp: s2v0 = ", s2v0)
val () =
println!
  ("s2var_occurcheck_s2exp: s2e0 = ", s2e0)
*)
//
in
//
  aux1_s2exp (s2v0, s2e0)
//
end // end of [s2var_occurcheck_s2exp]

end // end of [local]

(* ****** ****** *)
//
extern
fun
the_s3itmlst_env_push(): void
//
extern
fun the_s3itmlst_env_pop (): s3itmlst_vt
extern
fun the_s3itmlst_env_add (s3i: s3itm): void
//
(* ****** ****** *)

local
//
vtypedef
s3itmlstlst_vt = List_vt (s3itmlst_vt)
//
val the_s3itmlst = ref_make_elt<s3itmlst_vt> (list_vt_nil ())
val the_s3itmlstlst = ref_make_elt<s3itmlstlst_vt> (list_vt_nil ())
//
in (* in of [local] *)

implement
the_s3itmlst_env_push
  ((*void*)) = let
  val s3is = s3is where {
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
    val s3is = !p
    val () = !p := list_vt_nil ()
  } // end of [val]
  val () = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s3itmlstlst)
  in
    !pp := list_vt_cons (s3is, !pp)
  end // end of [val]
in
  // nothing
end // end of [the_s3itmlst_env_push]

implement
the_s3itmlst_env_pop () = let
  val s3is = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s3itmlstlst)
  in
    case+ !pp of
    | ~list_vt_cons (xs, xss) => let val () = !pp := xss in xs end
    | list_vt_nil () => let prval () = fold@ (!pp) in list_vt_nil end
  end : s3itmlst_vt
  val s3is = xs where {
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
    val xs = !p
    val () = !p := s3is
  } // end of [val]
in
  list_vt_reverse (s3is)
end // end of [the_s3itmlst_env_pop]

implement
the_s3itmlst_env_add (s3i) = let
  val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
in
  !p := list_vt_cons (s3i, !p)
end // end of [the_s3itmlst_env_add]

(* ****** ****** *)

implement
fprint_the_s3itmlst
  (out) = let
//
val s3is = let
  val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
in
  $UN.castvwtp1{s3itmlst}(!p)
end // end of [val]
//
in
  fprint_s3itmlst (out, s3is)
end // end of [fprint_the_s3itmlst]

implement
fprint_the_s3itmlstlst
  (out) = let
//
val s3iss = let
  val (vbox pf | pp) = ref_get_view_ptr (the_s3itmlstlst)
in
  $UN.castvwtp1{s3itmlstlst}(!pp)
end // end of [val]
//
in
  fprint_s3itmlstlst (out, s3iss)
end // end of [fprint_the_s3itmlstlst]

end // end of [local]
  
(* ****** ****** *)

implement
trans3_env_add_svar
  (s2v) = () where {
  val s3i = S3ITMsvar (s2v)
  val () = the_s3itmlst_env_add (s3i)
} // end of [trans3_env_add_svar]

implement
trans3_env_add_svarlst (s2vs) =
  list_app_fun<s2var> (s2vs, trans3_env_add_svar)
// end of [trans3_env_add_svarlst]

(* ****** ****** *)

implement
trans3_env_add_squa
  (s2q) = () where {
  val () = trans3_env_add_svarlst (s2q.s2qua_svs)
} // end of [trans3_env_add_svar]

implement
trans3_env_add_squalst (s2qs) =
  list_app_fun<s2qua> (s2qs, trans3_env_add_squa)
// end of [trans3_env_add_squalst]

(* ****** ****** *)

implement
trans3_env_add_sp2at
  (sp2t) = (
  case+ sp2t.sp2at_node of
  | SP2Tcon (s2c, s2vs) => trans3_env_add_svarlst (s2vs)
  | SP2Terr () => ()
) // end of [trans3_env_add_sp2at]

(* ****** ****** *)

implement
trans3_env_add_sVar
  (s2V) = () where {
  val s3i = S3ITMsVar (s2V)
//
  val () = the_s2Varset_env_add (s2V)
//
  val () = the_s3itmlst_env_add (s3i)
//
} // end of [trans3_env_add_sVar]

implement
trans3_env_add_sVarlst (s2Vs) =
  list_app_fun<s2Var> (s2Vs, trans3_env_add_sVar)
// end of [trans3_env_add_sVarlst]

implement
trans3_env_add_cnstr
  (c3t) = () where {
  val () = the_s3itmlst_env_add (S3ITMcnstr (c3t))
} // end of [trans3_env_add_cnstr]

implement
trans3_env_add_cnstr_ref
  (ref) = () where {
  val () = the_s3itmlst_env_add (S3ITMcnstr_ref (ref))
} // end of [trans3_env_add_cnstr_ref]

(* ****** ****** *)

implement
trans3_env_add_prop
  (loc, s2p) = case+ s2p.s2exp_node of
  | _ => let
      val c3t = c3nstr_prop (loc, s2p) in trans3_env_add_cnstr (c3t)
    end // end of [_]
// end of [trans3_env_add_prop]

implement
trans3_env_add_proplst
  (loc, s2ps) = case+ s2ps of
  | list_cons (s2p, s2ps) => (
      trans3_env_add_prop (loc, s2p); trans3_env_add_proplst (loc, s2ps)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [trans3_env_add_proplst]

implement
trans3_env_add_proplst_vt
  (loc, s2ps) = () where {
  val () = trans3_env_add_proplst (loc, $UN.castvwtp1 {s2explst} (s2ps))
  val () = list_vt_free (s2ps)
} // end of [trans3_env_add_proplst_vt]

(* ****** ****** *)

implement
trans3_env_add_eqeq
  (loc, s2e1, s2e2) = let
(*
  val () = (
    println! ("trans3_env_add_eqeq: s2e1 = ", s2e1);
    println! ("trans3_env_add_eqeq: s2e2 = ", s2e2);
  ) // end of [val]
*)
  val s2p = s2exp_eqeq (s2e1, s2e2)
in
  trans3_env_add_prop (loc, s2p)
end // end of [trans3_env_add_eqeq]

(* ****** ****** *)
//
// HX: for checking pattern matching exhaustiveness
//
implement
trans3_env_add_patcstlstlst_false
  (loc0, casknd, cp2tcss, s2es) = let
//
fun loop (
  xss: p2atcstlstlst_vt
) :<cloptr1> void =
(
case+ xss of
| ~list_vt_nil () => ()
| ~list_vt_cons (xs, xss) => let
    val (pfpush | ()) = trans3_env_push ()
    val c3t =
      c3nstr_case_exhaustiveness (loc0, casknd, xs)
    // end of [val]
    val () = trans3_env_hypadd_patcstlst (loc0, xs, s2es)
    val () = trans3_env_add_cnstr (c3t)
    val () = trans3_env_pop_and_add_main (pfpush | loc0)
  in
    loop (xss)
  end // end of [list_cons]
) (* end of [aux] *)
//
in
  loop (cp2tcss)
end // end of [trans3_env_add_patcstlstlst_false]

(* ****** ****** *)

implement
trans3_env_hypadd_prop
  (loc, s2p) = let
(*
//
val () =
println!
  ("trans3_env_hypadd_prop: s2p = ", s2p)
//
*)
//
val h3p =
  h3ypo_prop (loc, s2p)
//
val s3i = S3ITMhypo (h3p)
//
in
  the_s3itmlst_env_add (s3i)
end // end of [trans3_env_hypadd_prop]

implement
trans3_env_hypadd_proplst
  (loc, s2ps) = case+ s2ps of
  | list_nil() => ()
  | list_cons(s2p, s2ps) => (
      trans3_env_hypadd_prop (loc, s2p); trans3_env_hypadd_proplst (loc, s2ps)
    ) // end of [list_cons]
// end of [trans3_env_hypadd_proplst]

implement
trans3_env_hypadd_proplst_vt
  (loc, s2ps) = () where {
  val () = trans3_env_hypadd_proplst (loc, $UN.castvwtp1 {s2explst} (s2ps))
  val () = list_vt_free (s2ps)
} // end of [trans3_env_hypadd_proplst_vt]

(* ****** ****** *)

implement
trans3_env_hypadd_propopt
  (loc, opt) =
(
  case+ opt of
  | None () => ()
  | Some (s2p) => trans3_env_hypadd_prop (loc, s2p)
) // end of [trans3_env_hypadd_propopt]

implement
trans3_env_hypadd_propopt_neg
  (loc, opt) =
(
  case+ opt of
  | None () => ()
  | Some (s2p) =>
      trans3_env_hypadd_prop (loc, s2exp_bneg (s2p))
    // end of [Some]
) // end of [trans3_env_hypadd_propopt]

(* ****** ****** *)

implement
trans3_env_hypadd_bind
  (loc, s2v1, s2f2) = let
//
// HX: [s2v1] cannot be bound at this point
//
(*
val () =
(
  print "trans3_env_hypadd_bind: s2v1 = "; print_s2var s2v1; print_newline ();
  print "trans3_env_hypadd_bind: s2f2 = "; pprint_s2hnf s2f2; print_newline ();
) (* end of [val] *)
*)
//
val () =
the_s2varbindmap_insert (s2v1, s2f2)
//
val h3p = h3ypo_bind (loc, s2v1, s2f2)
//
val s3i = S3ITMhypo (h3p)
//
in
  the_s3itmlst_env_add (s3i)
end // end of [trans3_env_hypadd_bind]

implement
trans3_env_hypadd_eqeq
  (loc, s2f1, s2f2) = let
  val s2e1 = s2hnf2exp (s2f1)
  val s2e2 = s2hnf2exp (s2f2)
in
//
case+
(
  s2e1.s2exp_node
, s2e2.s2exp_node
) of // case+
(*
| (S2Evar (s2v1), _) => trans3_env_hypadd_bind (loc, s2v1, s2f2)
| (_, S2Evar (s2v2)) => trans3_env_hypadd_bind (loc, s2v2, s2f1)
*)
| (_, _) => let
    val h3p =
      h3ypo_eqeq (loc, s2f1, s2f2)
    // end of [val]
  in
    the_s3itmlst_env_add (S3ITMhypo (h3p))
  end (* end of [_, _] *)
//
end // end of [trans3_env_hypadd_eqeq]

(* ****** ****** *)

implement
trans3_env_hypadd_patcst
  (loc0, p2tc, s2e0) = let
//
val
s2f0 = s2exp2hnf (s2e0)
//
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val s2f = s2exp2hnf (s2e)
val s2e = s2hnf2exp (s2f)
//
(*
val () = println! ("trans3_env_hypadd_patcst: p2tc = ", p2tc)
*)
//
in
//
case+ p2tc of
//
| P2TCany () => ()
//
| P2TCcon
    (d2c, p2tcs) => let
  in
    case+ s2e.s2exp_node of
    | S2Edatcontyp (d2c1, _) =>
      (
        if (d2c != d2c1)
          then trans3_env_hypadd_prop (loc0, s2exp_bool (false)) else ()
        // end of [if]
      ) // end of [S2Edatcontyp]
    | _ (*non-datcon*) => let
        val @(s2qs_d2c, s2e_d2c) = $TR2.d2con_instantiate (loc0, d2c)
        val-S2Efun (_, _, _, _, s2es_fun_arg, s2e_fun_res) = s2e_d2c.s2exp_node
(*
        val () = (
          print "trans3_env_hypadd_patcst: s2vpss_d2c = "; print_s2qualst s2vpss_d2c; print_newline ();
          print "trans3_env_hypadd_patcst: s2es_fun_arg = "; print_s2explst s2es_fun_arg; print_newline ();
          print "trans3_env_hypadd_patcst: s2e_fun_res = "; print_s2exp s2e_fun_res; print_newline ();
        end (* end of [val] *)
*)
        val () = let
          fun loop (
            loc0: location, s2qs: s2qualst
          ) : void =
            case+ s2qs of
            | list_nil () => ()
            | list_cons (s2q, s2qs) => let
                val () = trans3_env_add_svarlst (s2q.s2qua_svs)
                val () = trans3_env_hypadd_proplst (loc0, s2q.s2qua_sps)
              in
                loop (loc0, s2qs)
              end // end of [list_cons]
          // end of [loop]
        in
          loop (loc0, s2qs_d2c)
        end // end of [val]
        val () = $SOL.s2exp_hypequal_solve (loc0, s2e_fun_res, s2e)
        val p2tcs = list_copy (p2tcs)
      in
        trans3_env_hypadd_patcstlst (loc0, p2tcs, s2es_fun_arg)
      end // end of [_]
    // end of [case-of]
  end // end of [P2TCcon]
//
| P2TCempty _ => ()
//
| P2TCint (i) => let
    val opt = un_s2exp_g1int_index_t0ype (s2f)
  in
    case+ opt of
    | ~None_vt () => ()
    | ~Some_vt (s2e_arg) =>
        $SOL.s2exp_hypequal_solve (loc0, s2e_arg, s2exp_intinf (i))
      // end of [Some_vt]
  end // end of [P2TCint]
//
| P2TCintc (xs) => let
    val opt = un_s2exp_g1int_index_t0ype (s2f)
  in
    case+ opt of
    | ~None_vt () => ()
    | ~Some_vt (s2e_arg) => let
        fun aux
        (
          xs: intinflst_vt
        ) :<cloref1> void = (
          case+ xs of
          | ~list_vt_nil () => ()
          | ~list_vt_cons (x, xs) => let
              val s2p =
                s2exp_intneq (s2e_arg, s2exp_intinf x)
              // end of [val]
              val () = trans3_env_hypadd_prop (loc0, s2p)
            in
              aux (xs)
            end // end of [list_vt_cons]
        ) (* end of [aux] *)
      in
        let val xs = intinfset_listize (xs) in aux (xs) end
      end // end of [Some_vt]
  end // end of [P2Tintc]
//
| P2TCbool (b) => let
    val opt = un_s2exp_bool_index_t0ype (s2f)
  in
    case+ opt of
    | ~None_vt () => () // end of [None_vt]
    | ~Some_vt (s2e_arg) =>
        $SOL.s2exp_hypequal_solve (loc0, s2e_arg, s2exp_bool (b))
      // end of [Some_vt]
  end // end of [P2TCbool]
//
| P2TCchar (c) => let
    val opt = un_s2exp_char_index_t0ype (s2f)
  in
    case+ opt of
    | ~None_vt () => ()
    | ~Some_vt (s2e_arg) =>
        $SOL.s2exp_hypequal_solve (loc0, s2e_arg, s2exp_int_char (c))
      // end of [Some_vt]
  end // end of [P2TCchar]
//
| P2TCcharc (xs) => let
    val opt = un_s2exp_char_index_t0ype (s2f)
  in
    case+ opt of
    | ~None_vt () => ()
    | ~Some_vt (s2e_arg) => let
        fun aux
        (
          xs: charlst_vt
        ) :<cloref1> void = (
          case+ xs of
          | ~list_vt_nil () => ()
          | ~list_vt_cons (x, xs) => let
              val s2p =
                s2exp_intneq (s2e_arg, s2exp_int_char x)
              // end of [val]
              val () = trans3_env_hypadd_prop (loc0, s2p)
            in
              aux (xs)
            end // end of [list_vt_cons]
        ) (* end of [aux] *)
      in
        let val xs = charset_listize (xs) in aux (xs) end
      end // end of [Some_vt]
  end // end of [P2Tcharc]
//
| P2TCfloat (rep) => ()
| P2TCstring (str) => ()
//
| P2TCrec
    (knd, lp2tcs) => let
  in
    case+ s2e.s2exp_node of
    | S2Etyrec (_, _, ls2es) => let
        val lp2tcs = list_copy (lp2tcs)
      in
        trans3_env_hypadd_labpatcstlst (loc0, lp2tcs, ls2es)
      end // end of [S2Etyrec]
    | _ (*non-tyrec*) => ((*void*))
  end // end of [P2TCrec]
//
(*
| _ => let
    val () = (
      println! "trans3_env_hypadd_patcst: p2tc = "; p2tc)
    ) (* end of [val] *)
    val () = assertloc (false)
  in
    exit (1)
  end (* end of [_] *)
*)
end // end of [trans3_env_hypadd_patcst]

(* ****** ****** *)

implement
trans3_env_hypadd_patcstlst
  (loc0, cp2tcs, s2es_pat) = let
//
fun
loop
(
  p2tcs: p2atcstlst_vt, s2es: s2explst, serr: int
) :<cloref1> int = let
in
//
case+ p2tcs of
| ~list_vt_nil () =>
  (
    case+ s2es of
    | list_cons (_, s2es) =>
        loop (list_vt_nil, s2es, serr - 1)
    | list_nil () => serr // the number of errors
  ) (* end of [list_nil] *)
| ~list_vt_cons (p2tc, p2tcs) =>
  (
    case+ s2es of
    | list_cons
        (s2e, s2es) => let
        val () =
          trans3_env_hypadd_patcst (loc0, p2tc, s2e)
        // end of [val]
      in
        loop (p2tcs, s2es, serr)
      end // end of [list_cons]
    | list_nil ((*void*)) => loop (p2tcs, s2es, serr + 1)
  ) (* end of [list_cons] *)
//
end // end of [loop]
//
val serr = loop (cp2tcs, s2es_pat, 0)
//
val () =
if
(serr != 0)
then let
//
val () = prerr_error3_loc (loc0)
val () =
  filprerr_ifdebug "trans3_env_hypadd_patcstlst"
//
val () = print! (": constructor arity mismatch")
val () = if serr < 0 then println! (": more arguments are expected")
val () = if serr > 0 then println! (": fewer arguments are expected")
//
in
  the_trans3errlst_add (T3E_cp2atcstlst_arity (loc0, serr))
end // end of [then]
//
(*
val ((*void*)) = assertloc (serr = 0)
*)
//
in
  (*nothing*)
end // end of [trans3_env_hypadd_patcstlst]

(* ****** ****** *)

implement
trans3_env_hypadd_labpatcstlst
  (loc0, lp2tcs, ls2es) = let
//
fn cmp (
  lx1: labs2exp, lx2: labs2exp, env: !ptr
) :<0> int = let
  val SLABELED (l1, _, _) = lx1
  and SLABELED (l2, _, _) = lx2
in
  $LAB.compare_label_label (l1, l2)
end // end of [fun]
var env: ptr = null
val ls2es = list_mergesort (ls2es, cmp, env)
//
fun aux (
  lp2tcs: List (labp2atcst), ls2es: List (labs2exp)
) :<cloref1> void =
  case+ lp2tcs of
  | list_cons
    (lp2tc, lp2tcs1) => (
    case+ ls2es of
    | list_cons
        (ls2e, ls2es1) => let
        val LABP2ATCST
          (l1, p2tc) = lp2tc
        val SLABELED (l2, _(*name*), s2e) = ls2e
        val sgn = $LAB.compare_label_label (l1, l2)
      in
        if sgn < 0 then
          aux (lp2tcs1, ls2es)
        else if sgn > 0 then
          aux (lp2tcs, ls2es1)
        else let
          val () = trans3_env_hypadd_patcst (loc0, p2tc, s2e)
        in
          aux (lp2tcs1, ls2es1)
        end // end of [if]
      end // end of [list_cons]
    | list_nil () => ()
    ) // end of [list_cons]
  | list_nil () => ()
//
val () = let
  val lp2tcs =
    $UN.castvwtp1 {labp2atcstlst} (lp2tcs)
  val ls2es = $UN.castvwtp1 {labs2explst} (ls2es)
in
  aux (lp2tcs, ls2es)
end // end of [val]
//
val () = list_vt_free (lp2tcs) and () = list_vt_free (ls2es)
//
in
  // nothing
end // end of [trans3_env_hypadd_labpatcstlst]

(* ****** ****** *)

local

fun
trans3_env_hypadd_disj
  (xss: s3itmlstlst): void =
(
  the_s3itmlst_env_add (S3ITMdisj (xss))
) // end of [trans3_env_hypadd_disj]

in (* in of [local] *)
//
// HX: enforcing sequentiality of pattern match
//
implement
trans3_env_hypadd_patcstlstlst
  (loc0, cp2tcss, s2es_pat) = let
//
fun
aux (
  p2tcss: p2atcstlstlst_vt
) :<cloref1> s3itmlstlst =
(
case+ p2tcss of
| ~list_vt_nil
   ((*void*)) => list_nil()
| ~list_vt_cons
    (p2tcs, p2tcss) => let
(*
    val () = (
      print "trans3_env_hypadd_patcstlstlst: aux: p2tcs = ";
      print_p2atcstlst_vt (p2tcs); print_newline ((*void*));
    ) (* end of [val] *)
*)
    val
    (pf|()) = trans3_env_push ((*none*))
    val () = trans3_env_hypadd_patcstlst (loc0, p2tcs, s2es_pat)
    val s3is = trans3_env_pop (pf|(*none*))
  in
    list_cons(l2l(s3is), aux (p2tcss))
  end // end of [list_vt_cons]
) (* end of [aux] *)
//
val s3iss = aux (cp2tcss)
(*
val n = list_length (s3iss)
val () =
(
  print "trans3_env_hypadd_patcstlstlst: ns3iss = "; print n; print_newline ()
) (* end of [val] *)
*)
in
  trans3_env_hypadd_disj (s3iss)
end // end of [trans3_env_hypadd_p2atcstlstlst]

end // end of [local]

(* ****** ****** *)

implement
trans3_env_solver_assert
  (loc0, s2e) = let
//
(*
val () =
println!
(
  "trans3_env_solver_assert: s2e = ", s2e
) (* end of [val] *)
*)
//
in
//
the_s3itmlst_env_add(S3ITMsolassert(s2e))
//
end // end of [trans3_env_solver_assert]

(* ****** ****** *)

implement
trans3_env_solver_verify
  (loc0, s2e) = let
//
val c3t = c3nstr_solverify(loc0, s2e)
//
(*
val () =
println!
(
  "trans3_env_solver_assert: c3t = ", c3t
) (* end of [val] *)
*)
//
in
  the_s3itmlst_env_add(S3ITMcnstr(c3t))
end // end of [trans3_env_solver_verify]

(* ****** ****** *)

local

assume
trans3_env_push_v = unit_v

in (* in of [local] *)

implement
trans3_env_pop
  (pf | (*none*)) = let
  prval () = unit_v_elim (pf)
  val _(*s2Vs*) = the_s2Varset_env_pop ()
  prval pf = __assert () where {
    extern praxi __assert (): s2varbindmap_push_v
  } // end of [prval]
  val () = the_s2varbindmap_pop (pf | (*none*))
in
  the_s3itmlst_env_pop ()
end // end of [trans3_env_pop]

implement
trans3_env_pop_and_add
  (pf | loc, knd) = let
  val s3is = trans3_env_pop (pf | (*none*))
  val c3t = c3nstr_itmlst (loc, knd, (l2l)s3is)
in
  trans3_env_add_cnstr (c3t)
end // end of [trans3_env_pop_and_add]

implement
trans3_env_pop_and_add_main
  (pf | loc) =
  trans3_env_pop_and_add (pf | loc, C3TKmain())
// end of [trans3_env_pop_and_add_main]

implement
trans3_env_push () = let
//
val () = the_s2Varset_env_push ()
//
val (pf | ()) = the_s2varbindmap_push ()
prval () = __assert (pf) where {
  extern praxi __assert (pf: s2varbindmap_push_v): void
} // end of [val]
//
val () = the_s3itmlst_env_push ()
//
in
  (unit_v () | ())
end // end of [trans3_env_push]

end // end of [local]

(* ****** ****** *)

implement
s2hnf_absuni_and_add
  (loc0, s2f0) = let
//
val s2e0 = s2hnf2exp (s2f0)
//
(*
//
val () =
println!
  ("s2exp_absuni_and_add: before: s2e0 = ", s2e0)
//
*)
val s2es2vss2ps = s2exp_absuni (s2e0)
//
(*
val () =
println!
  ("s2exp_absuni_and_add: after: s2e0 = ", s2es2vss2ps.0)
//
*)
val s2vs = s2es2vss2ps.1
//
val () = let
  val s2vs =
    $UN.castvwtp1 {s2varlst} (s2vs)
  // end of [val]
  val s2Vs = the_s2Varset_env_get ()
  val () = s2varlst_set_sVarset (s2vs, s2Vs)
  val () = trans3_env_add_svarlst (s2vs)
//
in
  // nothing
end // end of [val]
//
val ((*freed*)) = list_vt_free (s2vs)
//
val s2ps = s2es2vss2ps.2
val ((*added*)) =
  trans3_env_hypadd_proplst(loc0, $UN.castvwtp1{s2explst}(s2ps))
val ((*freed*)) = list_vt_free (s2ps)
//
in
  s2es2vss2ps.0
end // end of [s2hnf_absuni_and_add]

(* ****** ****** *)

implement
s2hnf_opnexi_and_add
  (loc0, s2f0) = let
//
val s2e0 = s2hnf2exp (s2f0)
//
(*
val () =
println!
  ("s2hnf_opnexi_and_add: before: s2e0 = ", s2e0)
//
*)
val s2es2vss2ps = s2exp_opnexi (s2e0)
(*
val () =
println!
  ("s2exp_opnexi_and_add: after: s2e0 = ", s2es2vss2ps.0)
//
*)
//
val s2vs = s2es2vss2ps.1
//
val () = let
  val s2vs =
    $UN.castvwtp1{s2varlst}(s2vs)
  // end of [val]
  val s2Vs = the_s2Varset_env_get ()
  val () = s2varlst_set_sVarset (s2vs, s2Vs)
  val () = trans3_env_add_svarlst (s2vs)
in
  // nothing
end // end of [val]
//
val ((*freed*)) = list_vt_free (s2vs)
//
val ((*added*)) =
  trans3_env_hypadd_proplst_vt (loc0, s2es2vss2ps.2)
//
in
  s2es2vss2ps.0
end // end of [s2hnf_opnexi_and_add]

(* ****** ****** *)

implement
s2hnf_opn1exi_and_add
  (loc0, s2f0) = let
  val s2e0 = s2hnf2exp (s2f0)
in
//
case+ s2e0.s2exp_node of
| S2Eexi (
    s2vs, s2ps, s2e_body
  ) => let
//
    var sub = stasub_make_nil ()
    val s2vs = stasub_extend_svarlst (sub, s2vs)
    val s2ps = s2explst_subst_vt (sub, s2ps) // HX: returning a linear list
    val s2e_body = s2exp_subst (sub, s2e_body)
    val () = stasub_free (sub)
//
    val () = let
      val s2vs =
        $UN.castvwtp1 {s2varlst} (s2vs)
      // end of [val]
      val s2Vs = the_s2Varset_env_get ()
      val () = s2varlst_set_sVarset (s2vs, s2Vs)
      val () = trans3_env_add_svarlst (s2vs)
    in
      // nothing
    end // end of [val]
    val () = list_vt_free (s2vs)
//
    val () = trans3_env_hypadd_proplst_vt (loc0, s2ps)
//
  in
    s2e_body
  end // end of [S2Eexi]
| _ => s2e0 // end of [_]
//
end // end of [s2hnf_opn1exi_and_add]

(* ****** ****** *)

local

viewtypedef
ws2elstopt = Option_vt (wths2explst)

fun auxres
(
  s2e: s2exp
) : ws2elstopt =
(
case+
s2e.s2exp_node
of // case+
| S2Eexi
    (_, _, s2e) => auxres (s2e)
  // end of [S2Eexi]
| S2Ewthtype
    (_, ws2es) => Some_vt(ws2es)
  // end of [S2Ewthtype]
| _ (*rest-of-S2E*) => None_vt ()
) (* end of [auxres] *)

fun auxarg
(
  loc: location
, s2es: s2explst, ws2es: wths2explst
) : s2explst = let
in
//
case+ s2es of
//
| list_nil
    ((*void*)) => list_nil ()
| list_cons
    (s2e, s2es) => (
  case+ ws2es of
  | WTHS2EXPLSTcons_invar
      (_, _, ws2es) => let
      val-S2Erefarg
        (knd, s2e) = s2e.s2exp_node
      var err: int = 0
      val (s2e, s2ps) =
        s2exp_exi_instantiate_all (s2e, loc, err)
      val () = trans3_env_add_proplst_vt (loc, s2ps)
      val s2e = s2exp_refarg (knd, s2e)
    in
      list_cons (s2e, auxarg (loc, s2es, ws2es))
    end // end of [WTHS2EXPLSTcons_invar]
  | WTHS2EXPLSTcons_trans
      (_, _, ws2es) =>
      list_cons (s2e, auxarg (loc, s2es, ws2es))
  | WTHS2EXPLSTcons_none (ws2es) =>
      list_cons (s2e, auxarg (loc, s2es, ws2es))
  | WTHS2EXPLSTnil((*void*)) => list_nil((*void*))
  ) (* end of [list_cons] *)
//
end // end of [auxarg]

in (* in of [local] *)

implement
s2fun_opninv_and_add
  (locarg, s2es_arg, s2e_res) = let
  val opt = auxres (s2e_res)
in
  case+ opt of
  | ~Some_vt
      (ws2es) => auxarg (locarg, s2es_arg, ws2es)
  | ~None_vt () => s2es_arg
end // end of [s2fun_arg_res_opninv_and_add]

end // end of [local]

(* ****** ****** *)

implement
d2var_opnset_and_add
  (loc, d2v) = let
//
val opt = d2var_get_type (d2v)
//
in
//
case+ opt of
| Some (s2e) => let
    val s2f = s2exp2hnf (s2e)
    val s2e = s2hnf_opnexi_and_add (loc, s2f)
  in
    d2var_set_type (d2v, Some (s2e))
  end // end of [Some]
| None () => d2var_set_type (d2v, None ())
//
end // end of [d2var_opnset_and_add]

(* ****** ****** *)

implement
un_s2exp_wthtype
  (loc, s2e) = let
//
var s2e_res: s2exp = s2e
var wths2es: wths2explst = WTHS2EXPLSTnil ()
//
val
iswth = s2exp_is_wthtype (s2e)
//
val () =
if iswth then let
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf_opnexi_and_add (loc, s2f)
  val-S2Ewthtype (s2e, wths2es1) = s2e.s2exp_node
in
  s2e_res := s2e; wths2es := wths2es1
end : void // end of [val]
//
in
  (iswth, s2e_res, wths2es)
end // end of [un_s2exp_wthtype]

(* ****** ****** *)

implement
d3exp_open_and_add
  (d3e) = let
//
val s2e = d3e.d3exp_type
val s2f = s2exp2hnf (s2e)
//
(*
//
val () =
println!
  ("d3exp_open_and_add: bef: s2e = ", s2e)
//
*)
//
val s2e =
  s2hnf_opnexi_and_add (d3e.d3exp_loc, s2f)
//
(*
//
val () =
println!
  ("d3exp_open_and_add: aft: s2e = ", s2e)
//
*)
in
  d3exp_set_type (d3e, s2e)
end // end of [d3exp_open_and_add]

implement
d3explst_open_and_add
  (d3es) = list_app_fun (d3es, d3exp_open_and_add)
// end of [d3explst_open_and_add]

(* ****** ****** *)

implement
the_trans3_env_initialize
  ((*void*)) = {
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_bool_t0ype)
  val s2c1 = s2cstref_get_cst (the_bool_bool_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_char_t0ype)
  val s2c1 = s2cstref_get_cst (the_char_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_schar_t0ype)
  val s2c1 = s2cstref_get_cst (the_schar_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_uchar_t0ype)
  val s2c1 = s2cstref_get_cst (the_uchar_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_g0int_t0ype)
  val s2c1 = s2cstref_get_cst (the_g1int_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_g0uint_t0ype)
  val s2c1 = s2cstref_get_cst (the_g1uint_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_ptr_type)
  val s2c1 = s2cstref_get_cst (the_ptr_addr_type)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_string_type)
  val s2c1 = s2cstref_get_cst (the_string_int_type)
} // end of [val]
//
} // end of [the_trans3_env_initialize]

(* ****** ****** *)

implement
the_trans3_finget_constraint
  ((*void*)) = let
//
val s3is = the_s3itmlst_env_pop ()
val s3is = list_of_list_vt{s3itm}(s3is)
//
(*
val () =
fprintln!
(
  stdout_ref
, "trans3_finget_constraint: s3is = ", s3is
) (* end of [val] *)
*)
//
in
  c3nstr_itmlst ($LOC.location_dummy, C3TKmain(), s3is)
end // end of [the_trans3_finget_constraint]

(* ****** ****** *)

(* end of [pats_trans3_env.dats] *)
