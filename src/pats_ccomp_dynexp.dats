(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
overload
print with $LOC.print_location

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dyncst2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload TYER = "./pats_typerase.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

overload fprint with fprint_funlab
overload fprint with fprint_d2varset
overload fprint with fprint_funlabset
overload fprint with fprint_vbindlst

(* ****** ****** *)

extern
fun d2var_ccomp
(
  env: !ccompenv
, loc0: location, hse0: hisexp, d2v: d2var
) : primval // end of [d2var_ccomp]
extern
fun d2var_ccomp_some
(
  env: !ccompenv
, loc0: location, hse0: hisexp, d2v: d2var, pmv: primval
) : primval // end of [d2var_ccomp_some]

implement
d2var_ccomp
  (env, loc0, hse0, d2v) = let
//
val opt = ccompenv_find_varbind (env, d2v)
//
in
case+ opt of
| ~Some_vt (pmv) =>
    d2var_ccomp_some (env, loc0, hse0, d2v, pmv)
| ~None_vt () =>
    primval_err (loc0, hse0) // HX-2013-04: deadcode?!
//
end // end of [d2var_ccomp]

implement
d2var_ccomp_some
(
  env, loc0, hse0, d2v, pmv
) = let
//
val lev0 = the_d2varlev_get ()
val lev1 = d2var_get_level (d2v)
//
in
//
case+ 0 of
| _ when
    lev1 < lev0 => let (* environval *)
(*
    val () = println! ("d2var_ccomp_some: pmv = ", pmv)
*)
  in
    case+ pmv.primval_node of
    | PMVfunlab (fl) => let
        val () = ccompenv_add_flabsetenv (env, fl)
      in
        pmv
      end // end of [PMVfunlab2]
    | PMVfunlab2 (d2v, fl) => let
        val () = ccompenv_add_flabsetenv (env, fl)
      in
        pmv
      end // end of [PMVfunlab2]
    | _ => let
        val () = ccompenv_add_d2varsetenv (env, d2v)
      in
        if lev1 > 0 then primval_env (loc0, hse0, d2v) else pmv(*toplevel*)
      end (* end of [_] *)
  end // end of [environval]
//
| _ => pmv (* [d2v] is at current-level *)
//
end // end of [d2var_ccomp_some]

(* ****** ****** *)

extern fun hidexp_ccomp_var : hidexp_ccomp_funtype
extern fun hidexp_ccomp_cst : hidexp_ccomp_funtype

extern fun hidexp_ccomp_cstsp : hidexp_ccomp_funtype

extern fun hidexp_ccomp_tmpcst : hidexp_ccomp_funtype
extern fun hidexp_ccomp_tmpvar : hidexp_ccomp_funtype

extern fun hidexp_ccomp_seq : hidexp_ccomp_funtype

extern fun hidexp_ccomp_selab : hidexp_ccomp_funtype

extern fun hidexp_ccomp_sel_var : hidexp_ccomp_funtype
extern fun hidexp_ccomp_sel_ptr : hidexp_ccomp_funtype

extern fun hidexp_ccomp_ptrofvar : hidexp_ccomp_funtype
extern fun hidexp_ccomp_ptrofsel : hidexp_ccomp_funtype

extern fun hidexp_ccomp_refarg : hidexp_ccomp_funtype

extern fun hidexp_ccomp_assgn_var : hidexp_ccomp_funtype
extern fun hidexp_ccomp_assgn_ptr : hidexp_ccomp_funtype

extern fun hidexp_ccomp_xchng_var : hidexp_ccomp_funtype
extern fun hidexp_ccomp_xchng_ptr : hidexp_ccomp_funtype

(* ****** ****** *)

extern
fun hilab_ccomp
  (env: !ccompenv, res: !instrseq, hil: hilab): primlab
// end of [fun hilab_ccomp]
extern
fun hilablst_ccomp
  (env: !ccompenv, res: !instrseq, hils: hilablst): primlablst
// end of [fun hilablst_ccomp]

(* ****** ****** *)

extern
fun hidexp_ccomp_ret_app : hidexp_ccomp_ret_funtype
extern
fun hidexp_ccomp_ret_extfcall : hidexp_ccomp_ret_funtype

extern
fun hidexp_ccomp_ret_if : hidexp_ccomp_ret_funtype
(*
extern
fun hidexp_ccomp_ret_sif : hidexp_ccomp_ret_funtype
*)

extern fun hidexp_ccomp_ret_lst : hidexp_ccomp_ret_funtype
extern fun hidexp_ccomp_ret_rec : hidexp_ccomp_ret_funtype
extern fun hidexp_ccomp_ret_seq : hidexp_ccomp_ret_funtype

extern fun hidexp_ccomp_ret_arrpsz : hidexp_ccomp_ret_funtype

extern fun hidexp_ccomp_ret_raise : hidexp_ccomp_ret_funtype

(* ****** ****** *)

local

fun auxret (
  env: !ccompenv
, res: !instrseq
, hde0: hidexp
) : primval = let
  val loc0 = hde0.hidexp_loc
  val hse0 = hde0.hidexp_type
  val tmpret = tmpvar_make (loc0, hse0)
  val () = hidexp_ccomp_ret (env, res, tmpret, hde0)
in
  primval_make_tmp (loc0, tmpret)
end // end of [auxret]

in // in of [local]

implement
hidexp_ccomp
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val () = println! ("hidexp_ccomp: hde0 = ", hde0)
//
in
//
case+ hde0.hidexp_node of
//
| HDEvar _ => hidexp_ccomp_var (env, res, hde0)
| HDEcst _ => hidexp_ccomp_cst (env, res, hde0)
//
| HDEint (i) => primval_int (loc0, hse0, i)
| HDEintrep (rep) => primval_intrep (loc0, hse0, rep)
//
| HDEbool (b) => primval_bool (loc0, hse0, b)
| HDEchar (c) => primval_char (loc0, hse0, c)
| HDEfloat (rep) => primval_float (loc0, hse0, rep)
| HDEstring (str) => primval_string (loc0, hse0, str)
//
| HDEi0nt (tok) => primval_i0nt (loc0, hse0, tok)
| HDEf0loat (tok) => primval_f0loat (loc0, hse0, tok)
//
| HDEcstsp _ => hidexp_ccomp_cstsp (env, res, hde0)
//
| HDEtop () => primval_top (loc0, hse0)
| HDEempty () => primval_empty (loc0, hse0)
//
| HDEextval (name) =>
    primval_extval (loc0, hse0, name)
//
| HDEcastfn (d2c, arg) => let
    val pmv_arg =
      hidexp_ccomp (env, res, arg)
    // end of [val]
  in
    primval_castfn (loc0, hse0, d2c, pmv_arg)
  end // end of [HDEcastfn]
//
| HDEextfcall _ => auxret (env, res, hde0)
//
| HDEcon _ => auxret (env, res, hde0)
//
| HDEtmpcst _ =>
    hidexp_ccomp_tmpcst (env, res, hde0)
| HDEtmpvar (d2v, t2mas) =>
    hidexp_ccomp_tmpvar (env, res, hde0)
//
| HDElet (hids, hde_scope) => let
//
    val (pfpush | ()) = ccompenv_push (env)
//
    val pmds = hideclist_ccomp (env, hids)
    val ins_push = instr_letpush (loc0, pmds)
    val () = instrseq_add (res, ins_push)
//
    val () =
      println! ("hidexp_ccomp: HDElet: env =")
    val () = fprint_ccompenv (stdout_ref, env)
//
    val pmv_scope = hidexp_ccomp (env, res, hde_scope)
//
    val ins_pop = instr_letpop (loc0)
    val () = instrseq_add (res, ins_pop)
//
    val () = ccompenv_pop (pfpush | env)
//
  in
    pmv_scope
  end // end of [HDElet]
//
| HDEapp _ => auxret (env, res, hde0)
//
| HDEif _ => auxret (env, res, hde0)
//
| HDEcase _ => auxret (env, res, hde0)
//
| HDElst _ => auxret (env, res, hde0)
//
| HDErec _ => auxret (env, res, hde0)
//
| HDEseq _ => hidexp_ccomp_seq (env, res, hde0)
//
| HDEselab _ => hidexp_ccomp_selab (env, res, hde0)
//
| HDEptrofvar _ =>
    hidexp_ccomp_ptrofvar (env, res, hde0)
| HDEptrofsel _ => auxret (env, res, hde0)
//
| HDErefarg _ => hidexp_ccomp_refarg (env, res, hde0)
//
| HDEsel_var _ => hidexp_ccomp_sel_var (env, res, hde0)
| HDEsel_ptr _ => hidexp_ccomp_sel_ptr (env, res, hde0)
//
| HDEassgn_var _ => hidexp_ccomp_assgn_var (env, res, hde0)
| HDEassgn_ptr _ => hidexp_ccomp_assgn_ptr (env, res, hde0)
//
| HDExchng_var _ => hidexp_ccomp_xchng_var (env, res, hde0)
| HDExchng_ptr _ => hidexp_ccomp_xchng_ptr (env, res, hde0)
//
| HDEarrpsz _ => auxret (env, res, hde0)
//
| HDEraise (hde_exn) => auxret (env, res, hde0)
//
| HDElam _ => hidexp_ccomp_lam (env, res, hde0)
//
| HDEloop _ => hidexp_ccomp_loop (env, res, hde0)
| HDEloopexn _ => hidexp_ccomp_loopexn (env, res, hde0)
//
| _ => let
    val () = println! ("hidexp_ccomp: loc0 = ", loc0)
    val () = println! ("hidexp_ccomp: hde0 = ", hde0)
  in
    exitloc (1)
  end // end of [_]
//
end // end of [hidexp_ccomp]

end // end of [local]

(* ****** ****** *)

implement
hidexplst_ccomp
  (env, res, hdes) = let
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hdes: hidexplst
, pmvs: &primvalist_vt? >> primvalist_vt
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val pmv =
      hidexp_ccomp (env, res, hde)
    val () = pmvs := list_vt_cons {..}{0} (pmv, ?)
    val list_vt_cons (_, !p_pmvs) = pmvs
    val () = loop (env, res, hdes, !p_pmvs)
    val () = fold@ (pmvs)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => let
    val () = pmvs := list_vt_nil () in (*nothing*)
  end // end of [list_nil]
//
end // end of [loop]
//
var pmvs: primvalist_vt
val () = loop (env, res, hdes, pmvs)
//
in
//
list_of_list_vt (pmvs)
//
end // end of [hidexplst_ccomp]

(* ****** ****** *)

implement
labhidexplst_ccomp
  (env, res, lhdes) = let
//
fun loop (
  env: !ccompenv
, res: !instrseq
, lhdes: labhidexplst
, lpmvs: &labprimvalist_vt? >> labprimvalist_vt
) : void = let
in
//
case+ lhdes of
| list_cons
    (lhde, lhdes) => let
    val LABHIDEXP (lab, hde) = lhde
    val pmv =
      hidexp_ccomp (env, res, hde)
    val lpmv = LABPRIMVAL (lab, pmv)
    val () = lpmvs := list_vt_cons {..}{0} (lpmv, ?)
    val list_vt_cons (_, !p_lpmvs) = lpmvs
    val () = loop (env, res, lhdes, !p_lpmvs)
    val () = fold@ (lpmvs)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => let
    val () = lpmvs := list_vt_nil () in (*nothing*)
  end // end of [list_nil]
//
end // end of [loop]
//
var lpmvs: labprimvalist_vt
val () = loop (env, res, lhdes, lpmvs)
//
in
//
list_of_list_vt (lpmvs)
//
end // end of [labhidexplst_ccomp]

(* ****** ****** *)

local

fun auxval (
  env: !ccompenv
, res: !instrseq
, tmpret: tmpvar
, hde0: hidexp
) : void = let
  val loc0 = hde0.hidexp_loc
  val pmv = hidexp_ccomp (env, res, hde0)
  val ins = instr_move_val (loc0, tmpret, pmv)
in
  instrseq_add (res, ins)
end // end of [auxval]

in // in of [local]

implement
hidexp_ccomp_ret (
  env, res, tmpret, hde0
) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
in
//
case+ hde0.hidexp_node of
//
| HDEvar _ => auxval (env, res, tmpret, hde0)
| HDEcst _ => auxval (env, res, tmpret, hde0)
//
| HDEint _ => auxval (env, res, tmpret, hde0)
| HDEbool _ => auxval (env, res, tmpret, hde0)
| HDEchar _ => auxval (env, res, tmpret, hde0)
| HDEstring _ => auxval (env, res, tmpret, hde0)
//
| HDEi0nt _ => auxval (env, res, tmpret, hde0)
| HDEf0loat _ => auxval (env, res, tmpret, hde0)
//
| HDEempty _ => auxval (env, res, tmpret, hde0)
//
| HDEextval _ => auxval (env, res, tmpret, hde0)
| HDEcastfn _ => auxval (env, res, tmpret, hde0)
| HDEextfcall _ =>
    hidexp_ccomp_ret_extfcall (env, res, tmpret, hde0)
  (* end of [HDEextfcall] *)
//
| HDEcon (
    d2c, hse_sum, _arg
  ) => let
    val lpmvs = labhidexplst_ccomp (env, res, _arg)
    val ins = instr_move_con (loc0, tmpret, d2c, hse_sum, lpmvs)
  in
    instrseq_add (res, ins)
  end // end of [HDEcon]
//
| HDElet (hids, hde_scope) => let
    val (
      pfpush | ()
    ) = ccompenv_push (env)
//
    val pmds =
      hideclist_ccomp (env, hids)
    val ins_push = instr_letpush (loc0, pmds)
    val () = instrseq_add (res, ins_push)
//
    val () =
      println! ("hidexp_ccomp: HDElet: env =")
    val () = fprint_ccompenv (stdout_ref, env)
//
    val () = hidexp_ccomp_ret (env, res, tmpret, hde_scope)
//
    val ins_pop = instr_letpop (loc0)
    val () = instrseq_add (res, ins_pop)
    val () = ccompenv_pop (pfpush | env)
  in
    // nothing
  end // end of [HDElet]
//
| HDEapp _ =>
    hidexp_ccomp_ret_app (env, res, tmpret, hde0)
//
| HDEif _ =>
    hidexp_ccomp_ret_if (env, res, tmpret, hde0)
//
| HDEcase _ =>
    hidexp_ccomp_ret_case (env, res, tmpret, hde0)
//
| HDElst _ =>
    hidexp_ccomp_ret_lst (env, res, tmpret, hde0)
//
| HDErec _ =>
    hidexp_ccomp_ret_rec (env, res, tmpret, hde0)
//
| HDEseq _ =>
    hidexp_ccomp_ret_seq (env, res, tmpret, hde0)
//
| HDEselab _ => auxval (env, res, tmpret, hde0)
//
| HDEptrofvar _ => auxval (env, res, tmpret, hde0)
| HDEptrofsel _ => auxval (env, res, tmpret, hde0)
//
| HDEsel_var _ => auxval (env, res, tmpret, hde0)
| HDEsel_ptr _ => auxval (env, res, tmpret, hde0)
//
| HDEassgn_var _ => auxval (env, res, tmpret, hde0)
| HDEassgn_ptr _ => auxval (env, res, tmpret, hde0)
//
| HDExchng_var _ => auxval (env, res, tmpret, hde0)
| HDExchng_ptr _ => auxval (env, res, tmpret, hde0)
//
| HDEarrpsz _ => hidexp_ccomp_ret_arrpsz (env, res, tmpret, hde0)
//
| HDEraise (hde_exn) => hidexp_ccomp_ret_raise (env, res, tmpret, hde0)
//
| HDElam _ => auxval (env, res, tmpret, hde0)
//
| HDEloop _ => auxval (env, res, tmpret, hde0)
| HDEloopexn _ => auxval (env, res, tmpret, hde0)
//
| _ => let
    val () = println! ("hidexp_ccomp_ret: loc0 = ", loc0)
    val () = println! ("hidexp_ccomp_ret: hde0 = ", hde0)
  in
    exitloc (1)
  end // end of [_]
//
end // end of [hidexp_ccomp_ret]

end // end of [local]

(* ****** ****** *)

implement
hilab_ccomp
  (env, res, hil) = let
  val loc = hil.hilab_loc
in
//
case+ hil.hilab_node of
| HILlab (lab) =>
    primlab_lab (loc, lab)
  // end of [HILlab]
| HILind (hdes_ind) => let
    val pmvs_ind = hidexplst_ccomp (env, res, hdes_ind)
  in
    primlab_ind (loc, pmvs_ind)
  end // end of [HILind]
//
end // end of [hilab_ccomp]

implement
hilablst_ccomp
  (env, res, hils) = let
in
//
case hils of
| list_cons (hil, hils) => let
    val pml = hilab_ccomp (env, res, hil)
    val pmls = hilablst_ccomp (env, res, hils)
  in
    list_cons (pml, pmls)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [hilablst_ccomp]

(* ****** ****** *)

implement
hidexp_ccomp_var
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEvar (d2v) = hde0.hidexp_node
//
in
  d2var_ccomp (env, loc0, hse0, d2v)
end // end of [hidexp_ccomp_var]

(* ****** ****** *)

implement
hidexp_ccomp_cst
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEcst (d2c) = hde0.hidexp_node
val () = the_dyncstlst_add (d2c)
//
in
  primval_cst (loc0, hse0, d2c)
end // end of [hidexp_ccomp_var]

(* ****** ****** *)

implement
hidexp_ccomp_cstsp
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEcstsp (x) = hde0.hidexp_node
//
val pmc = (
  case+ x of 
  | $SYN.CSTSPmyfil () => let
      val fil =
        $LOC.location_get_filename (loc0)
      // end of [val]
    in
      PMCSTSPmyfil (fil)
    end // end of [CSTSPmyfil]
  | $SYN.CSTSPmyloc () => PMCSTSPmyloc (loc0)
  | $SYN.CSTSPmyfun () => let
      val () = assertloc (false) in exit (1)
    end // end of [CSTSPmyfun]
) : primcstsp // end of [val]
//
in
  primval_cstsp (loc0, hse0, pmc)
end // end of [hidexp_ccomp_cstsp]

(* ****** ****** *)

implement
hidexp_ccomp_tmpcst
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEtmpcst (d2c, t2mas) = hde0.hidexp_node
//
val tmplev = ccompenv_get_tmplevel (env)
//
in
//
case+ 0 of
| _ when
    d2cst_is_sizeof (d2c) => let
    val-list_cons (t2ma, _) = t2mas
    val tloc = t2ma.t2mpmarg_loc
    val-list_cons (targ, _) = t2ma.t2mpmarg_arg
    val hselt = $TYER.s2exp_tyer_shallow (tloc, targ)
  in
    primval_make_sizeof (loc0, hselt)
  end // ...
| _ when
    tmplev > 0 => let
  in
    primval_tmpltcst (loc0, hse0, d2c, t2mas)
  end // ...
| _ => let
    val tmpmat =
      ccompenv_tmpcst_match (env, d2c, t2mas)
    // end of [val]
(*
    val () = print (
      "hidexp_ccomp_tmpcst:\n"
    ) // end of [val]
    val () = println! ("d2c = ", d2c)
    val () = print ("t2mas = ")
    val () = fpprint_t2mpmarglst (stdout_ref, t2mas)
    val () = print_newline ()
    val () = print ("mat = ")
    val () = fprint_tmpcstmat (stdout_ref, tmpmat)
    val () = print_newline ()
*)
  in
    ccomp_tmpcstmat (env, loc0, hse0, d2c, t2mas, tmpmat)
  end // end of [if]
//
end // end of [hidexp_ccomp_tmpcst]

(* ****** ****** *)

implement
hidexp_ccomp_tmpvar
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEtmpvar (d2v, t2mas) = hde0.hidexp_node
//
val tmplev = ccompenv_get_tmplevel (env)
//
in
//
case+ 0 of
| _ when
    tmplev > 0 => let
  in
    primval_tmpltvar (loc0, hse0, d2v, t2mas)
  end // end of [_ when ...]
| _ => let
    val tmpmat =
      ccompenv_tmpvar_match (env, d2v, t2mas)
    // end of [val]
// (*
    val () = print (
      "hidexp_ccomp_tmpvar:\n"
    ) // end of [val]
    val () = println! ("d2v = ", d2v)
    val () = print ("t2mas = ")
    val () = fpprint_t2mpmarglst (stdout_ref, t2mas)
    val () = print_newline ()
    val () = print ("mat = ")
    val () = fprint_tmpvarmat (stdout_ref, tmpmat)
    val () = print_newline ()
// *)
  in
    ccomp_tmpvarmat (env, loc0, hse0, d2v, t2mas, tmpmat)
  end // end of [if]
//
end // end of [hidexp_ccomp_tmpvar]

(* ****** ****** *)

implement
hidexp_ccomp_seq
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val-HDEseq (hdes) = hde0.hidexp_node
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hde0: hidexp, hdes: hidexplst
) : primval = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val _(*void*) =
      hidexp_ccomp (env, res, hde0)
    // end of [list_cons]
  in
    loop (env, res, hde, hdes)
  end // end of [list_cons]
| list_nil () => hidexp_ccomp (env, res, hde0)
//
end // end of [loop]
//
in
//
case+ hdes of
| list_cons
     (hde, hdes) => loop (env, res, hde, hdes)
| list_nil () => primval_empty (loc0, hse0)
//
end // end of [hidexp_ccomp_seq]

(* ****** ****** *)

implement
hidexp_ccomp_selab
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val-HDEselab (hde, hse_rt, hils) = hde0.hidexp_node
//
val pmv = hidexp_ccomp (env, res, hde)
val pmls = hilablst_ccomp (env, res, hils)
//
in
  primval_select2 (loc0, hse0, pmv, hse_rt, pmls)
end // end of [hidexp_ccomp_selab]

(* ****** ****** *)

implement
hidexp_ccomp_sel_var
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEsel_var (d2v, hse_rt, hils) = hde0.hidexp_node
//
val pmv =
  d2var_ccomp (env, loc0, hse_rt, d2v)
//
(*
val () = (
  println! ("hidexp_ccomp_sel_var: d2v = ", d2v);
  println! ("hidexp_ccomp_sel_var: pmv = ", pmv);
) // end of [val]
*)
//
val pmls = hilablst_ccomp (env, res, hils)
//
in
  primval_sel_var (loc0, hse0, pmv, hse_rt, pmls)
end // end of [hidexp_ccomp_sel_var]

(* ****** ****** *)

implement
hidexp_ccomp_sel_ptr
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEsel_ptr (hde, hse_rt, hils) = hde0.hidexp_node
val pmv = hidexp_ccomp (env, res, hde)
val pmls = hilablst_ccomp (env, res, hils)
//
in
  primval_sel_ptr (loc0, hse0, pmv, hse_rt, pmls)
end // end of [hidexp_ccomp_sel_ptr]

(* ****** ****** *)

implement
hidexp_ccomp_ptrofvar
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDEptrofvar (d2v) = hde0.hidexp_node
//
val hse = hisexp_void_type ()
val pmv = d2var_ccomp (env, loc0, hse, d2v)
//
in
  primval_make_ptrof (loc0, pmv)
end // end of [hidexp_ccomp_ptrofvar]

(* ****** ****** *)

implement
hidexp_ccomp_ptrofsel
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDEptrofsel
  (hde, hse_rt, hils) = hde0.hidexp_node
//
val pmv = hidexp_ccomp (env, res, hde)
val pmls = hilablst_ccomp (env, res, hils)
in
  primval_make_ptrofsel (loc0, pmv, hse_rt, pmls)
end // end of [hidexp_ccomp_ptrofsel]

(* ****** ****** *)

implement
hidexp_ccomp_refarg
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDErefarg
  (knd, freeknd, hde) = hde0.hidexp_node
//
val pmv = hidexp_ccomp (env, res, hde)
//
in
  primval_make_refarg (loc0, knd, pmv)
end // end of [hidexp_ccomp_refarg]

(* ****** ****** *)

implement
hidexp_ccomp_assgn_var
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEassgn_var
  (d2v_l, hse_rt, hils, hde_r) = hde0.hidexp_node
// end of [val]
val pmv_l =
  d2var_ccomp (env, loc0, hse_rt, d2v_l)
val pmls = hilablst_ccomp (env, res, hils)
val pmv_r = hidexp_ccomp (env, res, hde_r)
val ins = instr_store_varofs (loc0, pmv_l, hse_rt, pmls, pmv_r)
val () = instrseq_add (res, ins)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_assgn_var]

implement
hidexp_ccomp_assgn_ptr
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEassgn_ptr
  (hde_l, hse_rt, hils, hde_r) = hde0.hidexp_node
// end of [val]
val pmv1 = hidexp_ccomp (env, res, hde_l)
val pmls = hilablst_ccomp (env, res, hils)
val pmv2 = hidexp_ccomp (env, res, hde_r)
val ins = instr_store_ptrofs (loc0, pmv1, hse_rt, pmls, pmv2)
val () = instrseq_add (res, ins)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_assgn_ptr]

(* ****** ****** *)

implement
hidexp_ccomp_xchng_var
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDExchng_var
  (d2v_l, hse_rt, hils, hde_r) = hde0.hidexp_node
// end of [val]
val hse_r = hde_r.hidexp_type
val tmp = tmpvar_make (loc0, hse_r)
val pmv_l =
  d2var_ccomp (env, loc0, hse_rt, d2v_l)
val pmls = hilablst_ccomp (env, res, hils)
val pmv_r = hidexp_ccomp (env, res, hde_r)
val ins = instr_xstore_varofs (loc0, tmp, pmv_l, hse_rt, pmls, pmv_r)
val () = instrseq_add (res, ins)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_xchng_var]

implement
hidexp_ccomp_xchng_ptr
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDExchng_ptr
  (hde_l, hse_rt, hils, hde_r) = hde0.hidexp_node
// end of [val]
val hse_r = hde_r.hidexp_type
val tmp = tmpvar_make (loc0, hse_r)
val pmv1 = hidexp_ccomp (env, res, hde_l)
val pmls = hilablst_ccomp (env, res, hils)
val pmv2 = hidexp_ccomp (env, res, hde_r)
val ins = instr_xstore_ptrofs (loc0, tmp, pmv1, hse_rt, pmls, pmv2)
val () = instrseq_add (res, ins)
//
in
  primval_empty (loc0, hse0)
end // end of [hidexp_ccomp_xchng_ptr]

(* ****** ****** *)

implement
hidexp_ccomp_ret_app
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEapp (hde_fun, hse_fun, hdes_arg) = hde0.hidexp_node
//
val pmv_fun = hidexp_ccomp (env, res, hde_fun)
val pmvs_arg = hidexplst_ccomp (env, res, hdes_arg)
//
val ins = instr_fcall (loc0, tmpret, pmv_fun, hse_fun, pmvs_arg)
//
in
  instrseq_add (res, ins)
end // end of [hidexp_ccomp_ret_app]

(* ****** ****** *)

implement
hidexp_ccomp_ret_extfcall
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEextfcall (_fun, hdes_arg) = hde0.hidexp_node
//
val pmvs_arg = hidexplst_ccomp (env, res, hdes_arg)
//
val ins = instr_extfcall (loc0, tmpret, _fun, pmvs_arg)
//
in
  instrseq_add (res, ins)
end // end of [hidexp_ccomp_ret_extfcall]

(* ****** ****** *)

implement
hidexp_ccomp_ret_if
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDEif (hde_cond, hde_then, hde_else) = hde0.hidexp_node
//
val pmv_cond = hidexp_ccomp (env, res, hde_cond)
//
val tmpret_then = tmpret
val res_then = instrseq_make_nil ()
val (pfpush | ()) = ccompenv_push (env)
val () = hidexp_ccomp_ret (env, res_then, tmpret_then, hde_then)
val () = ccompenv_pop (pfpush | env)
val inss_then = instrseq_get_free (res_then)
//
val tmpret_else = tmpret
val res_else = instrseq_make_nil ()
val (pfpush | ()) = ccompenv_push (env)
val () = hidexp_ccomp_ret (env, res_else, tmpret_else, hde_else)
val () = ccompenv_pop (pfpush | env)
val inss_else = instrseq_get_free (res_else)
//
val ins = instr_cond (loc0, pmv_cond, inss_then, inss_else)
//
in
  instrseq_add (res, ins)
end // end of [hidexp_ccomp_ret_if]

(* ****** ****** *)

local

fun auxnode (
  env: !ccompenv
, res: !instrseq
, tmphd: tmpvar, tmptl: tmpvar
, hse_elt: hisexp, hde: hidexp
) : void = let
//
val loc = hde.hidexp_loc
//
val ins = instr_pmove_list_cons (loc, tmptl, hse_elt)
val ( ) = instrseq_add (res, ins)
val ins = instr_move_list_phead (loc, tmphd, tmptl, hse_elt)
val ( ) = instrseq_add (res, ins)
//
val pmv = hidexp_ccomp (env, res, hde)
val ins = instr_pmove_val (loc, tmphd, pmv)
val () = instrseq_add (res, ins)
//
val ins = instr_move_list_ptail (loc, tmptl, tmptl, hse_elt)
val () = instrseq_add (res, ins)
//
in
  // nothing
end // end of [auxnode]

fun auxnodelst (
  env: !ccompenv
, res: !instrseq
, tmphd: tmpvar, tmptl: tmpvar
, loc0: location, hse_elt: hisexp, hdes: hidexplst
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val () =
      auxnode (env, res, tmphd, tmptl, hse_elt, hde)
    // end of [list_cons]
  in
    auxnodelst (env, res, tmphd, tmptl, loc0, hse_elt, hdes)
  end // end of [list_cons]
| list_nil () => let
    val ins =
      instr_pmove_list_nil (loc0, tmptl) in instrseq_add (res, ins)
    // end of [val]
  end // end of [list_nil]
//
end // end of [auxnodelst]

in // in of [local]

implement
hidexp_ccomp_ret_lst
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val (
) = instrseq_add_tmpdec (res, loc0, tmpret)
//
val-HDElst (knd, hse_elt, hdes) = hde0.hidexp_node
//
in
//
case+ hdes of
| list_cons _ => let
    val pmv = primval_make_tmp (loc0, tmpret)
    val pmv_ptr = primval_make_ptrof (loc0, pmv)
    val tmphd = tmpvar_make (loc0, hisexp_datconptr)
    val tmptl = tmpvar_make (loc0, hisexp_datconptr)
    val ins = instr_move_val (loc0, tmptl, pmv_ptr)
    val () = instrseq_add (res, ins)
  in
    auxnodelst (env, res, tmphd, tmptl, loc0, hse_elt, hdes)
  end // end of [list_cons]
| list_nil () => let
    val ins =
      instr_move_list_nil (loc0, tmpret) in instrseq_add (res, ins)
    // end of [val]
  end // end of [list_nil]
end // end of [hidexp_ccomp_ret_lst]

end // end of [local]

(* ****** ****** *)

local
 
fun auxlst (
  env: !ccompenv, res: !instrseq, lxs: labhidexplst
) : labprimvalist = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val LABHIDEXP (l, x) = lx
    val pmv =
      hidexp_ccomp (env, res, x)
    // end of [val]
    val lpmv = LABPRIMVAL (l, pmv)
    val lpmvs = auxlst (env, res, lxs)
  in
    list_cons (lpmv, lpmvs)
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]

in // in of [local]

implement
hidexp_ccomp_ret_rec
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val-HDErec (knd, lhdes, hse_rec) = hde0.hidexp_node
//
val lpmvs = auxlst (env, res, lhdes)
//
val ins = (
  if knd > 0 then
    instr_move_boxrec (loc0, tmpret, lpmvs, hse_rec)
  else
    instr_move_fltrec2 (loc0, tmpret, lpmvs, hse_rec)
  // end of [if]
) : instr // end of [val]
//
in
  instrseq_add (res, ins)
end // end of [hidexp_ccomp_ret_rec]

end // end of [local]

(* ****** ****** *)

implement
hidexp_ccomp_ret_seq
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val-HDEseq (hdes) = hde0.hidexp_node
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hde0: hidexp, hdes: hidexplst
, tmpret: tmpvar
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val _(*void*) =
      hidexp_ccomp (env, res, hde0)
    // end of [list_cons]
  in
    loop (env, res, hde, hdes, tmpret)
  end // end of [list_cons]
| list_nil () => hidexp_ccomp_ret (env, res, tmpret, hde0)
//
end // end of [loop]
//
in
//
case+ hdes of
| list_cons (
    hde, hdes
  ) => loop (env, res, hde, hdes, tmpret)
| list_nil () => ()
//
end // end of [hidexp_ccomp_ret_seq]

(* ****** ****** *)

local

fun auxlst (
  env: !ccompenv
, res: !instrseq
, arrp: tmpvar
, loc0: location, hse_elt: hisexp, hdes: hidexplst
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val loc = hde.hidexp_loc
//
    val pmv = hidexp_ccomp (env, res, hde)
    val ins = instr_pmove_val (loc, arrp, pmv)
    val () = instrseq_add (res, ins)
//
    val () = (
      case+ hdes of
      | list_cons _ => let
          val ins = instr_update_ptrinc (loc, arrp, hse_elt)
        in
          instrseq_add (res, ins)
        end // end of [list_cons]
      | list_nil () => ()
    ) : void // end of [val]
  in
    auxlst (env, res, arrp, loc0, hse_elt, hdes)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

in // in of [local]

implement
hidexp_ccomp_ret_arrpsz
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
val (
) = instrseq_add_tmpdec (res, loc0, tmpret)
//
val-HDEarrpsz
  (hse_elt, hdes, asz) = hde0.hidexp_node
//
val ins =
  instr_store_arrpsz_asz (loc0, tmpret, asz)
val () = instrseq_add (res, ins)
val ins =
  instr_store_arrpsz_ptr (loc0, tmpret, hse_elt, asz)
val () = instrseq_add (res, ins)
//
val arrp = tmpvar_make (loc0, hisexp_arrptr)
val ins = instr_move_arrpsz_ptr (loc0, arrp, tmpret)
val () = instrseq_add (res, ins)
//
in
  auxlst (env, res, arrp, loc0, hse_elt, hdes)
end // end of [hidexp_ccomp_ret_arrpsz]

end // end of [local]

(* ****** ****** *)

implement
hidexp_ccomp_ret_raise
  (env, res, tmpret, hde0) = let
//
val loc0 = hde0.hidexp_loc
val-HDEraise (hde_exn) = hde0.hidexp_node
val pmv_exn = hidexp_ccomp (env, res, hde_exn)
//
val ins = instr_raise (loc0, tmpret, pmv_exn)
val () = instrseq_add (res, ins)
//
in
  // nothing
end // end of [hidexp_ccomp_ret_raise]

(* ****** ****** *)

implement
hidexp_ccomp_funlab_arg_body
(
  env
, flab
, imparg
, tmparg
, prolog
, loc_fun
, hips_arg
, hde_body
) = let
(*
val () = begin
  println! ("hidexp_ccomp_funlab_arg_body: flab = ", flab)
end // end of [val]
*)
//
val lev0 = the_d2varlev_get ()
//
val res = instrseq_make_nil ()
val ((*void*)) = instrseq_addlst (res, prolog)
//
val (pfinc | ()) = the_d2varlev_inc ()
//
val () = ccompenv_inc_flabsetenv (env)
val () = ccompenv_inc_d2varsetenv (env)
val () = ccompenv_inc_vbindlstenv (env)
//
val () = let
  val lev1 = the_d2varlev_get () in
  hifunarg_ccomp (env, res, flab, lev1, loc_fun, hips_arg)
end // end of [val]
//
val loc_body = hde_body.hidexp_loc
val hse_body = hde_body.hidexp_type
val tmpret = tmpvar_make_ret (loc_body, hse_body)
val () = hidexp_ccomp_ret (env, res, tmpret, hde_body)
//
val flset = ccompenv_getdec_flabsetenv (env)
val d2vset = ccompenv_getdec_d2varsetenv (env)
val vblst = ccompenv_getdec_vbindlstenv (env)
//
val () = the_d2varlev_dec (pfinc | (*none*))
//
val inss = instrseq_get_free (res)
//
val () = ccompenv_addset_flabsetenv (env, lev0, flset)
val () = ccompenv_addset_d2varsetenv (env, lev0, d2vset)
//
val out = stdout_ref
val () = fprintln! (out, "hidexp_ccomp_funlab_arg_body: flab = ", flab)
val () = fprintln! (out, "hidexp_ccomp_funlab_arg_body: flset = ", flset)
val () = fprintln! (out, "hidexp_ccomp_funlab_arg_body: d2vset = ", d2vset)
val () = fprintln! (out, "hidexp_ccomp_funlab_arg_body: vblst = ", vblst)
//
val
fent = funent_make2
(
  loc_fun, lev0, flab, imparg, tmparg, tmpret, flset, d2vset, vblst, inss
) (* end of [val] *)
//
in
  fent
end // end of [hidexp_ccomp_funlab_arg_body]

(* ****** ****** *)

implement
hidexp_ccomp_lam
  (env, res, hde0)  = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
val-HDElam (hips_arg, hde_body) = hde0.hidexp_node
val flab = funlab_make_type (hse0)
val fent = let
  val imparg = list_nil(*s2vs*)
  val tmparg = list_nil(*s2ess*)
  val ins = instr_funlab (loc0, flab)
  val prolog = list_sing (ins)
in
  hidexp_ccomp_funlab_arg_body
    (env, flab, imparg, tmparg, prolog, loc0, hips_arg, hde_body)
  // end of [hidexp_ccomp_funlab_arg_body]
end // end of [val]
//
val () = the_funlablst_add (flab)
val () = funlab_set_funent (flab, Some (fent))
//
val () = println! ("hidexp_ccomp_lam: fent = ", fent)
//
in
  primval_make_funlab (loc0, flab)
end // end of [hidexp_ccomp_lam]

(* ****** ****** *)

(* end of [pats_ccomp_dynexp.dats] *)
