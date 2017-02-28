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
// Start Time: November, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*UNSAFE*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement
prerr_FILENAME<>
  ((*void*)) = prerr ("pats_trans3_decl")
//
(* ****** ****** *)
//
staload EFF = "./pats_effect.sats"
//
(* ****** ****** *)
//
staload LOC = "./pats_location.sats"
overload print with $LOC.print_location
//
(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
//
staload "./pats_patcst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"
//
(* ****** ****** *)

staload
TRENV2 = "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

extern
fun i2mpdec_tr (d2c: i2mpdec): i3mpdec

extern
fun f2undec_tr (f2d: f2undec): d3exp
extern
fun f2undeclst_tr (
  knd: funkind, decarg: s2qualst, f2ds: f2undeclst
) : f3undeclst // end of [f2undeclst_tr]

(* ****** ****** *)

extern
fun v2aldec_tr
  (knd: valkind, v2d: v2aldec): v3aldec
extern
fun v2aldeclst_tr
  (knd: valkind, v2ds: v2aldeclst): v3aldeclst
// end of [v2aldeclst_tr]
extern
fun v2aldeclst_rec_tr
  (knd: valkind, v2ds: v2aldeclst): v3aldeclst
// end of [v2aldeclst_rec_tr]

(* ****** ****** *)

extern
fun v2ardec_tr (v2d: v2ardec): v3ardec
extern
fun v2ardeclst_tr (v2ds: v2ardeclst): v3ardeclst

extern
fun prv2ardec_tr (v2d: prv2ardec): prv3ardec
extern
fun prv2ardeclst_tr (v2ds: prv2ardeclst): prv3ardeclst

(* ****** ****** *)

extern fun d2ecl_tr_staload (d2c: d2ecl): d3ecl
extern fun d2ecl_tr_staloadloc (d2c: d2ecl): d3ecl
extern fun d2ecl_tr_dynload (d2c: d2ecl): d3ecl

(* ****** ****** *)

implement
d2ecl_tr(d2c0) = let
//
val loc0 = d2c0.d2ecl_loc
//
val d3c0 = (
case+ d2c0.d2ecl_node of
//
| D2Cnone() => d3ecl_none (loc0)
//
| D2Clist(d2cs) =>
  (
    d3ecl_list(loc0, d2eclist_tr(d2cs))
  ) (*D2Clist*)
//
| D2Csymintr _ => d3ecl_none (loc0)
| D2Csymelim _ => d3ecl_none (loc0)
//
| D2Coverload
    (id, _, _) => d3ecl_none (loc0)
  // D2Coverload
//
| D2Cpragma _ => d3ecl_none (loc0)
| D2Ccodegen _ => d3ecl_none (loc0)
//
| D2Cstacsts _ => d3ecl_none (loc0)
| D2Cstacons _ => d3ecl_none (loc0)
//
| D2Csaspdec(d2c) => let
//
    val loc = d2c.s2aspdec_loc
    val s2c = d2c.s2aspdec_cst
    val s2e = d2c.s2aspdec_def
//
    val s2f_def = s2exp2hnf(s2e)
    val s2e_def = s2hnf2exp(s2f_def)
//
// HX-2017-02-01:
// For handling abstypes of unspecified sized
//
    extern
    fun
    s2cst_set_isabs
    (
      s2c: s2cst, opt: s2expopt
    ) : void = "patsopts2cst_set_isabs"
//
    val s2eoptopt = s2cst_get_isabs(s2c)
//
    val ((*void*)) =
    (
      case+
      s2eoptopt
      of (*case+*)
      | Some(s2eopt) =>
        (
          case+ s2eopt of
          | None() => let
              val
              s2eopt = Some(s2e_def)
            in
              s2cst_set_isabs(s2c, s2eopt)
            end // end of [None]
          | Some _(*s2exp*) => ((*void*))
        )
      | None((*void*)) => ((*void*))
    ) : void // end of [val]
//
    val ((*void*)) =
      the_s2cstbindlst_bind_and_add(loc, s2c, s2f_def)
    // end of [val]
  in
    d3ecl_saspdec (loc0, d2c)
  end // end of [D2Csaspec]
//
| D2Creassume(s2c) =>
  d3ecl_reassume(loc0, s2c) where
  {
//
    val s2eopt = s2cst_get_isasp(s2c)
//
    val ((*void*)) =
    (
      case+
      s2eopt
      of (*case+*)
      | None() => () where
        {
          val () =
          prerr_error3_loc(loc0);
          val () =
          prerrln!
          (
           ": the abstype type [", s2c, "] is not yet assumed."
          ) (* println! *)
          val () =
          the_trans3errlst_add
          (
            T3E_reassume_tr_isnotasp(loc0, s2c)
          ) (* the_trans3errlst_add *)
        }
      | Some(s2e) => () where
        {
          val () = s2cst_set_def(s2c, Some(s2e))
        } (* end of [Some] *)
    ) : void // end of [val]
//
  } (* end of [D2Creassume] *) 
//
| D2Cextype
    (name, s2e_def) =>
    d3ecl_extype(d2c0.d2ecl_loc, name, s2e_def)
| D2Cextvar
    (name, d2e_def) => let
    val d3e_def = d2exp_trup (d2e_def)
  in
    d3ecl_extvar (d2c0.d2ecl_loc, name, d3e_def)
  end // end of [D2Cextvar]
//
| D2Cextcode
    (knd, pos, code) =>
    d3ecl_extcode(loc0, knd, pos, code)
//
| D2Cexndecs // HX: exnconst decls
    (d2cs) => d3ecl_exndecs(loc0, d2cs)
| D2Cdatdecs // HX: datatype decls
    (knd, s2cs) => d3ecl_datdecs(loc0, knd, s2cs)
//
| D2Cdcstdecs
  (
    knd, dck, d2cs
  ) => d3ecl_dcstdecs(loc0, knd, dck, d2cs)
//
| D2Cimpdec
    (knd, d2c) => let
    val d3c = i2mpdec_tr(d2c)
  in
    d3ecl_impdec (loc0, knd, d3c)
  end // end of [D2Cimpdec]
//
| D2Cfundecs
    (knd, s2qs, f2ds) => let
    val f3ds =
      f2undeclst_tr(knd, s2qs, f2ds)
    // end of [val]
  in
    d3ecl_fundecs (loc0, knd, s2qs, f3ds)
  end // end of [D2Cfundecs]
//
| D2Cvaldecs
    (knd, v2ds) => let
    val v3ds =
      v2aldeclst_tr(knd, v2ds)
    // end of [val]
  in
    d3ecl_valdecs (loc0, knd, v3ds)
  end // end of [D2Cvaldecs]
| D2Cvaldecs_rec
    (knd, v2ds) => let
    val v3ds =
      v2aldeclst_rec_tr(knd, v2ds)
    // end of [val]
  in
    d3ecl_valdecs_rec (loc0, knd, v3ds)
  end // end of [D2Cvaldecs_rec]
//
| D2Cvardecs (v2ds) => let
    val v3ds =
      v2ardeclst_tr(v2ds) in d3ecl_vardecs (loc0, v3ds)
    // end of [val]
  end // end of [D2Cvardecs]
| D2Cprvardecs (v2ds) => let
    val v3ds =
      prv2ardeclst_tr(v2ds) in d3ecl_prvardecs (loc0, v3ds)
    // end of [val]
  end // end of [D2Cprvardecs]
//
| D2Cinclude (knd, d2cs) => let
    val d3cs = d2eclist_tr(d2cs) in d3ecl_include (loc0, knd, d3cs)
  end // end of [D2Cinclude]
//
| D2Cstaload _ => d2ecl_tr_staload (d2c0)
| D2Cstaloadloc _ => d2ecl_tr_staloadloc (d2c0)
//
| D2Cdynload _ => d2ecl_tr_dynload (d2c0)
//
| D2Clocal
    (d2cs_head, d2cs_body) => let
    val (pf1 | ()) = the_s2cstbindlst_push ()
    val d3cs_head = d2eclist_tr (d2cs_head)
    val (pf2 | ()) = the_s2cstbindlst_push ()
    val d3cs_body = d2eclist_tr (d2cs_body)
    val s2cs_body = the_s2cstbindlst_pop (pf2 | (*void*))
    val ((*void*)) = the_s2cstbindlst_pop_and_unbind (pf1 | (*void*))
    val ((*void*)) = the_s2cstbindlst_addlst (s2cs_body)
  in
    d3ecl_local (loc0, d3cs_head, d3cs_body)
  end // end of [D2Clocal]
//
| _ => let
    val () = println! (loc0)
    val () = println! ("d2ecl_tr: d2c0 = ", d2c0)
    val () = assertloc (false)
  in
    exit (1)
  end // end of [_]
//
) : d3ecl // end of [val]
//
in
//
d3c0 (* the return value *)
//
end // end of [d2ecl_tr]

(* ****** ****** *)

implement
d2eclist_tr
  (d2cs) = (l2l)d3cs where
{
  val d3cs = list_map_fun(d2cs, d2ecl_tr)
} (* end of [d2eclist_tr] *)

(* ****** ****** *)

implement
d2eclist_tr_errck
  (d2cs) = d3cs where {
  val d3cs = d2eclist_tr(d2cs)
  val () = the_trans3errlst_finalize((*void*))
} // end of [d2eclist_tr_errck]

(* ****** ****** *)

implement
i2mpdec_tr (impdec) = let
//
  val loc0 = impdec.i2mpdec_loc
  val locid = impdec.i2mpdec_locid
//
  val d2c0 = impdec.i2mpdec_cst
//
  val imparg = impdec.i2mpdec_imparg
//
  val tmparg = impdec.i2mpdec_tmparg
  val tmpgua = impdec.i2mpdec_tmpgua
//
(*
  val () = (
    println! ("d2ec_tr: D2Cimpdec: impdec = ", impdec)
  ) (* end of [val] *)
*)
//
  val (pf0 | ()) = trans3_env_push()
  val ((*void*)) = trans3_env_add_svarlst(imparg)
//
(*
  val () = trans3_env_add_proplstlst (locid, tmpgua)
*)
//
  val d3e_def = d2exp_trup(impdec.i2mpdec_def)
  val ((*void*)) = trans3_env_pop_and_add_main(pf0 | loc0)
//
in
  i3mpdec_make(loc0, d2c0, imparg, tmparg, d3e_def)
end // end of [i2mpdec_tr]

(* ****** ****** *)

implement
f2undec_tr
  (d2c0) = d3e_def where
{
//
  val opt = d2c0.f2undec_ann
//
  val d2v_loc = d2c0.f2undec_loc
  val d2v_fun = d2c0.f2undec_var
  val d2e_def = d2c0.f2undec_def
  val d2v_decarg = d2var_get_decarg(d2v_fun)
//
  val (pf0 | ()) = trans3_env_push((*void*))
  val ((*void*)) = trans3_env_add_squalst(d2v_decarg)
//
  val d3e_def = (
    case+ opt of
    | Some(s2e_ann) => let
(*
        val () = (
          print "f2undec_tr: s2e_ann = "; print_s2exp (s2e_ann); print_newline ();
          print "f2undec_tr: d2e_def = "; print_d2exp (d2e_def); print_newline ();
        ) // end of [val]
*)
      in
        d2exp_trdn(d2e_def, s2e_ann)
      end // end of [Some]
    | None((*void*)) => d2exp_trup(d2e_def)
  ) : d3exp // end of [val]
//
  val ((*void*)) = trans3_env_pop_and_add_main(pf0 | d2v_loc)
//
} (* end of [f2undec_tr] *)

(* ****** ****** *)

local

fun
d2exp_metfun_load
(
  d2e0: d2exp
, d2vs_fun: SHARED(d2varlst)
) : void = aux (d2e0) where {
  fun aux (
    d2e0: d2exp
  ) :<cloref1> void =
    case+ d2e0.d2exp_node of
    | D2Elam_dyn
        (_, _, _, d2e) => aux (d2e)
      // D2Elam_dyn
    | D2Elam_sta (_, _, d2e) => aux (d2e)
    | D2Elam_met (ref, _, _) => !ref := d2vs_fun
    | _ (* rest-of-D2Elam *) => ((*void*))
  // end of [aux]
} (* end of [d2exp_metfn_load] *)

fun termet_sortcheck
  (os2ts0: &s2rtlstopt, os2ts: s2rtlstopt): bool = let
  fun aux (
    s2ts0: s2rtlst, s2ts: s2rtlst, sgn: &int(0) >> int
  ) : bool =
    case+ s2ts0 of
    | list_nil
        ((*void*)) =>
      (
        case+ s2ts of
        | list_cons _ => (sgn := ~1; true) | list_nil() => true
      ) (* end of [list_nil] *)
    | list_cons
        (s2t0, s2ts0) => (
      case+ s2ts of
      | list_nil
          ((*void*)) => (sgn := 1; true)
        // end of [list_nil]
      | list_cons
          (s2t, s2ts) =>
          if s2rt_ltmat1 (s2t, s2t0) then aux (s2ts0, s2ts, sgn) else false
        // end of [list_cons]
      ) (* end of [list_cons] *)
  // end of [aux]
in
//
case+ os2ts0 of
| Some s2ts0 => (
  case+ os2ts of
  | Some s2ts => let
      var sgn: int = 0
      val test = aux (s2ts0, s2ts, sgn)
      val () = if test then (
        if sgn < 0 then (os2ts0 := os2ts)
      ) // end of [val]
    in
      test
    end // end of [Some]
  | None () => true
  ) // end of [Some]
| None () => (os2ts0 := os2ts; true)
//
end // end of [termet_sortcheck]

in (* in of [local] *)

implement
f2undeclst_tr
  (knd, decarg, d2cs) = let
//
val isrec = funkind_is_recursive (knd)
//
fun aux_init
(
  d2cs: f2undeclst
, d2vs_fun: SHARED(d2varlst)
, os2ts0: &s2rtlstopt
) : void = let
in
//
case+ d2cs of
| list_nil
    ((*void*)) => ()
  // end of [list_nil]
| list_cons
    (d2c, d2cs) => let
    val d2v_fun = d2c.f2undec_var
    val d2e_def = d2c.f2undec_def
    val () = d2exp_metfun_load (d2e_def, d2vs_fun)
    var s2e_fun: s2exp =
    (
      case+ d2c.f2undec_ann of
      | Some s2e_ann => s2e_ann
      | None ((*void*)) => d2exp_syn_type (d2e_def)
    ) (* end of [val] *)
    var os2ts: s2rtlstopt = None ()
    val opt = s2exp_metfun_load (s2e_fun, d2v_fun)
    val () = (
      case+ opt of
      | ~None_vt() => ()
      | ~Some_vt(x) => (s2e_fun := x.0; os2ts := Some(x.1))
    ) : void // end of [val]
(*
    val () = (
      print "f2undeclst_tr: aux_init: d2v_fun = "; print_d2var (d2v_fun); print_newline ();
      print "f2undeclst_tr: aux_init: s2e_fun = "; print_s2exp (s2e_fun); print_newline ();
    ) // end of [val]
*)
    val () = let
      val test =
        termet_sortcheck(os2ts0, os2ts)
      // end of [val]
      val () =
      if ~test then let
        val () =
        prerr_error3_loc(d2c.f2undec_loc);
        val () =
        prerrln!
        (
          ": incompatible termination metric for this function."
        ) (* println! *)
      in
        the_trans3errlst_add(T3E_f2undeclst_tr_termetsrtck(d2c, os2ts))
      end // end of [if] // end of [val]
    in
      (*nothing*)
    end // end of [val]
    val opt = Some (s2e_fun)
    val () = d2var_set_type (d2v_fun, opt)
    val () = d2var_set_mastype (d2v_fun, opt)
  in
    aux_init (d2cs, d2vs_fun, os2ts0)
  end // end of [list_cons]
//
end // end of [aux_ini]
//
fn aux_fini{n:nat}
(
  d2cs: list(f2undec, n)
, d3es: !list_vt(d3exp, n)
) : f3undeclst = let
  fn f (
    d2c: f2undec, d3e: d3exp
  ) : f3undec = let
    val s2e_fun = d3e.d3exp_type // s2hnf
    val d2v_fun = d2c.f2undec_var // d2var
//
// HX-2012-01-22: it is unnecessary if recursive
//
    val () = {
      val opt = Some(s2e_fun)
      val (_) = d2var_set_type (d2v_fun, opt)
      val (_) = d2var_set_mastype (d2v_fun, opt)
    } (* end of [val] *)
  in
    f3undec_make (d2c.f2undec_loc, d2v_fun, d3e)
  end // end of [f]
  val d3cs =
  list_map2_fun
    (d2cs, $UN.castvwtp1{list(d3exp, n)}(d3es), f)
  // end of [val]
in
  (l2l)d3cs
end // end of [aux_fini]
//
val () =
if
isrec
then let
  typedef a = f2undec and b = d2var
  val d2vs_fun = l2l (
    list_map_fun<a><b> (d2cs, lam (d2c) =<1> d2c.f2undec_var)
  ) (* end of [val] *)
  var os2ts0: s2rtlstopt = None ()
  val () = aux_init (d2cs, d2vs_fun, os2ts0)
in
  // nothing
end // end of [then] // end of [if]
//
val d3es =
  list_map_fun (d2cs, f2undec_tr)
// end of [val]
val d3cs = aux_fini (d2cs, d3es(*list_vt*))
val ((*void*)) = list_vt_free (d3es)
//
in
  d3cs
end // end of [f2undeclst_tr]

end // end of [local]

(* ****** ****** *)

implement
v2aldec_tr
  (knd, d2c) = let
//
val loc0 = d2c.v2aldec_loc
val p2t_val = d2c.v2aldec_pat
(*
val () =
(
  println! ("v2aldec_tr: p2t_val = ", p2t_val)
) // end of [val]
*)
val isprf = valkind_is_proof (knd)
val [b:bool] isprf = bool1_of_bool (isprf)
val (pfopt | ()) =
  the_effenv_push_set_if (isprf, $EFF.effset_all)
// end of [val]
//
val d3e_def = let
  val d2e = d2c.v2aldec_def
  val opt = d2c.v2aldec_ann // [withtype] annotation
in
  case+ opt of
  | Some s2e => d2exp_trdn (d2e, s2e) | None () => d2exp_trup (d2e)
end : d3exp // end of [val]
//
val () = the_effenv_pop_if (pfopt | isprf)
//
val s2e_def = d3exp_get_type (d3e_def)
(*
val () =
(
  println! ("v2aldec_tr: s2e_def = ", s2e_def)
) // end of [val]
*)
//
val casknd = valkind2caskind (knd)
//
val cp2tcss = (
  case+ casknd of
  | CK_case () =>
      p2atcstlst_comp (list_sing (p2at2cst (p2t_val)))
  | CK_case_pos () =>
      p2atcstlst_comp (list_sing (p2at2cst (p2t_val)))
  | CK_case_neg () => list_vt_nil ()
) : p2atcstlstlst_vt // end of [val]
val isexhaust = ( // HX: always true for [case-]
  if list_vt_is_nil (cp2tcss) then true else false
) : bool // end of [val]
val () = if ~isexhaust then let
  val s2es = list_sing (s2e_def)
  val cp2tcss = p2atcstlstlst_vt_copy (cp2tcss) in
  trans3_env_add_patcstlstlst_false (loc0, casknd, cp2tcss, s2es)
end // end of [val]
val () = p2atcstlstlst_vt_free (cp2tcss)
val () = if ~isexhaust then let
  val _(*err*) = the_effenv_caskind_check_exn (loc0, casknd)
in
  // nothing
end // end of [if] // end of [val]
//
val p3t_val = p2at_trdn (p2t_val, s2e_def)
val () = d3lval_set_pat_type_left (d3e_def, p3t_val)
//
val () = the_d2varenv_add_p3at (p3t_val)
val () = the_pfmanenv_add_p3at (p3t_val)
//
in
  v3aldec_make (loc0, p3t_val, d3e_def)
end // end of [v2aldec_tr]

(* ****** ****** *)

implement
v2aldeclst_tr (knd, d2cs) = let
  val f = lam
    (d2c: v2aldec) =<cloptr1> v2aldec_tr (knd, d2c)
  val d3cs = list_map_cloptr<v2aldec><v3aldec> (d2cs, f)
  val () = cloptr_free (f)
in
  (l2l)d3cs
end // end of [v2aldeclst_tr]

(* ****** ****** *)

implement
v2aldeclst_rec_tr
  (knd, d2cs) = let
//
val p3ts = let
  fn aux1 (
    d2c: v2aldec
  ) : p3at = let
    val p2t = d2c.v2aldec_pat
    val s2e_pat = (case+ d2c.v2aldec_ann of
      | Some s2e => s2e | None () => p2at_syn_type (p2t)
    ) : s2exp // end of [val]
    val () = // checking for nonlinearity
      if s2exp_is_lin (s2e_pat) then let
        val () = prerr_error3_loc (p2t.p2at_loc)
        val () = prerr ": this pattern cannot be assigned a linear type."
        val () = prerr_newline ()
      in
        the_trans3errlst_add (T3E_v2aldeclst_rec_tr_linearity (d2c, s2e_pat))
      end // end of [if]
  in
    p2at_trdn (p2t, s2e_pat)
  end // end of [aux1]
in
  l2l (list_map_fun (d2cs, aux1))
end // end of [val]
//
val d3cs = let
  fun aux2 (
    d2c: v2aldec, p3t: p3at
  ) : v3aldec = let
    val d2e_def = d2c.v2aldec_def
    val s2e_pat = p3at_get_type (p3t)
    val d3e_def = d2exp_trdn (d2e_def, s2e_pat)
  in
    v3aldec_make (d2c.v2aldec_loc, p3t, d3e_def)
  end // end of [aux2]
in
  l2l (list_map2_fun (d2cs, p3ts, aux2))
end // end of [val]
//
in
  d3cs
end // end of [v2aldeclst_rec_tr]

(* ****** ****** *)

local

fun
auxInitCK
(
  loc0: loc_t
, d2v: d2var, s2e1: s2exp, s2e2: s2exp
) : void = let
  val tszeq = s2exp_tszeq (s2e1, s2e2)
in
//
if ~tszeq then let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": initialization for ["
  val () = prerr_d2var (d2v)
  val () = prerr "] cannot be performed properly"
  val () = prerr ": mismatch of var/val type-sizes:\n"
  val () = (prerr "var: ["; prerr_s2exp (s2e1); prerr "]")
  val () = prerr_newline ()
  val () = (prerr "val: ["; prerr_s2exp (s2e2); prerr "]")
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_s2exp_assgn_tszeq (loc0, s2e1, s2e2))
end // end of [if] // end of [val]
//
end // end of [auxInitCK]

in (* in of [local] *)

implement
v2ardec_tr
  (v2d) = let
//
val loc0 = v2d.v2ardec_loc
val stadyn = v2d.v2ardec_knd
val d2v = v2d.v2ardec_dvar
val locvar = d2var_get_loc (d2v)
val ann = v2d.v2ardec_type
val init2 = v2d.v2ardec_init
var init3 : d3expopt = None ()
//
val s2e0 = (
  case+ ann of
  | Some s2e_ann => (
    case+ init2 of
    | Some (d2e) => let
        val d3e = d2exp_trup (d2e)
        val () = init3 := Some (d3e)
        val () = d3exp_open_and_add (d3e)
        val s2e = d3exp_get_type (d3e)
        val () = auxInitCK (loc0, d2v, s2e_ann, s2e)
        val () = d2var_set_type (d2v, Some s2e)
      in
        s2e_ann
      end // end of [Some]
    | None () => let
        val s2e = s2exp_topize_0 (s2e_ann)
        val () = d2var_set_type (d2v, Some (s2e))
      in        
        s2e_ann
      end // end of [None]
    ) // end of [Some]
  | None () => (
    case+ init2 of
    | Some (d2e) => let
        val d3e = d2exp_trup (d2e)
        val () = init3 := Some (d3e)
        val () = d3exp_open_and_add (d3e)
        val s2e = d3exp_get_type (d3e)
        val () = d2var_set_type (d2v, Some (s2e))
      in
        s2exp_topize_0 (s2e)
      end // end of [Some]
    | None () => let
        val s2e =
          s2exp_Var_make_srt (locvar, s2rt_t0ype)
        val () = d2var_set_type (d2v, Some (s2e))
      in
        s2e
      end // end of [None]
    ) // end of [None]
) : s2exp // end of [val]
(*
val () = println! ("v2ardec_tr: s2e0 = ", s2e0)
*)
val d2vw =
  d2var_mutablize (locvar, d2v, s2e0, v2d.v2ardec_pfat)
val-Some(s2l) = d2var_get_addr (d2v)
//
val s2e0_top = s2exp_topize_0 (s2e0)
val s2at0_top = s2exp_at (s2e0_top, s2l)
val ((*void*)) = d2var_set_finknd (d2vw, D2VFINsome_lvar (s2at0_top))
//
val d2vopt = v2d.v2ardec_dvaropt
val () =
(
case+ d2vopt of
| None () => ()
| Some (d2v2) =>
  {
    val () = d2var_set_type (d2v2, d2var_get_type (d2v))
    val () = d2var_set_mastype (d2v2, d2var_get_mastype (d2v))
  }
) (* end of [val] *)
//
val d3c =
  v3ardec_make (loc0, stadyn, d2v, d2vw, s2e0, init3, d2vopt)
// end of [val]
val () = the_d2varenv_add_dvar (d2v)
val () = the_pfmanenv_add_dvar (d2v)
//
in
  d3c
end // end of [v2ardec_tr]

end // end of [local]

(* ****** ****** *)

implement
v2ardeclst_tr (v2ds) = let
//
val (
) = list_app_fun<v2ardec>
(
  v2ds
, lam v2d =<1>
    trans3_env_add_svar (v2d.v2ardec_svar)
  // end of [lam]
) // end of [fcall] // end of [val]
//
in
  list_of_list_vt (list_map_fun (v2ds, v2ardec_tr))
end // end of [v2ardeclst_tr]

(* ****** ****** *)

implement
prv2ardec_tr (v2d) = let
//
val loc = v2d.prv2ardec_loc
val d2v = v2d.prv2ardec_dvar
val loc_d2v = d2var_get_loc (d2v)
val () = d2var_set_linval (d2v, 0)
//
val s2eopt = v2d.prv2ardec_type
//
val d2e =
(
case+
v2d.prv2ardec_init of
| Some (d2e) => d2e | None () => d2exp_empty (loc_d2v)
) : d2exp // end of [val]
//
val d3e =
(
case+ s2eopt of
| Some (s2e) => d2exp_trdn (d2e, s2e) | None () => d2exp_trup (d2e)
) : d3exp // end of [val]
//
val s2e = d3exp_get_type (d3e)
val s2f = s2exp2hnf (s2e)
val s2e = s2hnf_opnexi_and_add (loc_d2v, s2f)
val () = d2var_set_type (d2v, Some (s2e))
//
val () = the_d2varenv_add_dvar (d2v)
val () = the_pfmanenv_add_dvar (d2v)
//
in
  prv3ardec_make (loc, d2v, s2e, d3e)
end // end of [prv2ardec_tr]

implement
prv2ardeclst_tr (v2ds) =
  list_of_list_vt (list_map_fun (v2ds, prv2ardec_tr))
// end of [prv2ardeclst_tr]

(* ****** ****** *)

implement
d2ecl_tr_staload
  (d2c0) = let
//
val loc0 = d2c0.d2ecl_loc
val-D2Cstaload (
  idopt, fil, loadflag, fenv, loaded
) = d2c0.d2ecl_node // end of [val]
val () = let
  val opt = filenv_get_d3eclistopt (fenv)
in
  case+ opt of
  | Some _ => ()
  | None _ => let
      val d2cs =
        $TRENV2.filenv_get_d2eclist(fenv)
      // end of [val]
      val (pfpush|()) = the_s2cstbindlst_push()
      val d3cs = d2eclist_tr (d2cs)
      val () = the_s2cstbindlst_pop_and_unbind(pfpush|(*none*))
      val p = $TRENV2.filenv_getref_d3eclistopt(fenv)
      val () = $UN.ptrset<d3eclistopt> (p, Some(d3cs))
    in
      // nothing
    end // end of [None]
end // end of [val]
//
in
  d3ecl_staload(loc0, idopt, fil, loadflag, fenv, loaded)
end // end of [d2ecl_tr_staload]

(* ****** ****** *)

implement
d2ecl_tr_staloadloc
  (d2c0) = let
//
val loc0 = d2c0.d2ecl_loc
//
val-D2Cstaloadloc
  (pfil, nspace, fenv) = d2c0.d2ecl_node
//
val d2cs = $TRENV2.filenv_get_d2eclist(fenv)
//
val (pfpush|()) = the_s2cstbindlst_push()
val d3cs = d2eclist_tr(d2cs)
val () = the_s2cstbindlst_pop_and_unbind(pfpush|(*none*))
//
val p0 = $TRENV2.filenv_getref_d3eclistopt(fenv)
val () = $UN.ptrset<d3eclistopt> (p0, Some(d3cs))
//
in
  d3ecl_staloadloc(loc0, pfil, nspace, fenv)
end // end of [d2ecl_tr_staloadloc]

(* ****** ****** *)

implement
d2ecl_tr_dynload
  (d2c0) = let
//
val loc0 = d2c0.d2ecl_loc
val-D2Cdynload (cfil) = d2c0.d2ecl_node
//
in
  d3ecl_dynload (loc0, cfil)
end // end of [d2ecl_tr_dynload]

(* ****** ****** *)

(* end of [pats_trans3_decl.dats] *)
