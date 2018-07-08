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
// Start Time: January, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_p2at"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

staload
LOC = "./pats_location.sats"
macdef
print_location = $LOC.print_location

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)
//
extern
fun
p2at_trdn_any(p2t0: p2at, s2f0: s2hnf): p3at
extern
fun
p2at_trdn_var(p2t0: p2at, s2f0: s2hnf): p3at
//
(* ****** ****** *)

local

extern
fun aux_p2at (p2t0: p2at): s2exp
extern
fun aux_labp2atlst (lp2ts: labp2atlst): labs2explst

in (* in of [local] *)

implement
aux_p2at (p2t0) = let
(*
val () = println! ("aux_p2at: p2t0 = ", p2t0)
*)
in
//
case+ p2t0.p2at_node of
//
| P2Tann (p2t, s2e_ann) => s2e_ann
//
| P2Tany _ =>
    s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
  // end of [P2Tany]
| P2Tvar _ =>
    s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
  // end of [P2Tvar]
//
| P2Tint _ => s2exp_int_t0ype () // int0
| P2Tintrep (rep) =>
    intrep_syn_type (p2t0.p2at_loc, rep) // intrep
  (* end of [P2Tintrep] *)
//
| P2Tbool _ => s2exp_bool_t0ype () // bool0
| P2Tchar _ => s2exp_char_t0ype () // char0
| P2Tstring _ => s2exp_string_type () // string0
| P2Tfloat _ => s2exp_double_t0ype () // double
//
| P2Ti0nt (x) => i0nt_syn_type (x)
| P2Tf0loat (x) => f0loat_syn_type (x)
//
| P2Tempty () => s2exp_void_t0ype ()
//
| P2Tcon _ =>
    s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
  (* end of [P2Tcon] *)
//
| P2Tlst (lin, p2ts) => s2exp_t0ype_err ()
//
(*
| P2Ttup : tuples have been turned into records
*)
//
| P2Trec (knd, npf, lp2ts) =>
    s2exp_tyrec (knd, npf, aux_labp2atlst (lp2ts))
//
| P2Trefas (d2v, p2t) => p2at_syn_type (p2t)
//
| P2Tvbox (d2v) => let
    val s2e =
      s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_view)
    // end of [val]
  in
    s2exp_vbox_view_prop (s2e)
  end // end of [P2Tvbox]
//
| P2Texist _ => s2exp_t0ype_err ()
//
| P2Tlist (npf, p2ts) => s2exp_t0ype_err ()
//
| P2Terrpat ((*void*)) => s2exp_t0ype_err ()
(*
| _(*yet-to-be-processed*) => exitloc (1)
*)
//
end // end of [aux_p2at]
  
implement
aux_labp2atlst
  (lp2ts) = let
in
//
case+ lp2ts of
| list_cons
    (lp2t, lp2ts) => (
  case+ lp2t of
  | LABP2ATnorm (l0, p2t) => let
      val l = l0.l0ab_lab
      val s2e = p2at_syn_type (p2t)
      val ls2e = SLABELED (l, None(*name*), s2e)
    in
      list_cons (ls2e, aux_labp2atlst (lp2ts))
    end // end of [LABP2ATnorm]
  | LABP2ATomit (loc) => list_nil () // HX: should an error be reported?
  ) // end of [list_cons]
| list_nil ((*void*)) => list_nil ()
//
end // end of [aux_labp2atlst]

(* ****** ****** *)

implement
p2at_syn_type
  (p2t0) = s2e0 where {
  val s2e0 = aux_p2at (p2t0)
  val () = p2at_set_type (p2t0, Some (s2e0))
} // end of [p2at_syn_type]

end // end of [local]

(* ****** ****** *)

implement
p2atlst_syn_type (p2ts) =
  l2l (list_map_fun (p2ts, p2at_syn_type))
// end of [p2atlst_syn_type]

(* ****** ****** *)

implement
p2at_trup_arg
  (p2t0) = let
(*
  val () = begin
    println! ("p2at_trup_arg: p2t0 = ", p2t0)
  end // end of [val]
*)
in
//
case+
p2t0.p2at_node
of (*case+*)
| P2Tann(p2t, s2e) =>
    p2at_trdn_arg(p2t, s2e)
  // end of [P2Tann]
| _ (*non-P2Tann*) => let
    val-Some(s2e) = p2t0.p2at_type
  in
    p2at_trdn(p2t0, s2e)
  end // end of [_]
//
end // end of [p2at_trup_arg]

(* ****** ****** *)

local

fn p2at_proofize
  (p2t: p2at) = let
  val dvs = p2t.p2at_dvs
  val dvs = $UT.lstord2list (dvs)
in
  list_foreach_fun<d2var>
    (dvs, lam d2v =<1> d2var_set_isprf (d2v, true))
end (* end of [p2at_proofize] *)

in (* in-of-local *)

implement
p2atlst_trup_arg
  (npf, p2ts) = res where
{
//
fun
loop
(
  npf: int, p2ts: p2atlst
, res: &p3atlst? >> p3atlst
) : void = (
//
case+ p2ts of
| list_nil() =>
    (res := list_nil)
| list_cons
    (p2t, p2ts) => let
//
    val () =
    if npf > 0
      then p2at_proofize(p2t)
    // end of [if]
//
    val p3t = p2at_trup_arg(p2t)
//
    val () =
    res := list_cons{p3at}{0}(p3t, ?)
//
    val+list_cons(_, !p_res) = res
//
    val () = loop(npf-1, p2ts, !p_res)
//
    prval ((*folded*)) = fold@ (res)
  in
    // nothing
  end // end of [list_cons]
//
) (* end of [loop] *)
//
var res: p3atlst // uninitized
val ((*void*)) = loop(npf, p2ts, res)
//
} (* end of [p2atlst_trup_arg] *)

(* ****** ****** *)

local

fun
p2at_trdn_arg_refarg_var
  (p2t0: p2at, s2e0: s2exp): p3at = let
//
val loc0 = p2t0.p2at_loc
val-S2Erefarg
  (refknd, s2e) = s2e0.s2exp_node
val s2f = s2exp2hnf (s2e)
val s2e = s2hnf2exp (s2f)
val-P2Tvar (d2v) = p2t0.p2at_node
//
in
//
case+ 0 of
| _ when refknd = 0 => let // call-by-value
    val p3t0 = p2at_trdn_var (p2t0, s2f)
    val () = p3at_set_type (p3t0, s2e0)
    val-Some (s2e) = d2var_get_type (d2v)
    val () = d2var_set_finknd (d2v, D2VFINsome (s2e)) // HX: may be overwritten later
  in
    p3t0
  end // end of [refknd = 0]
| _ (*refknd = 1*) => let // call-by-reference
    val loc0 = p2t0.p2at_loc
    val p3t0 = p3at_var (loc0, s2e0, d2v)
    val s2e_opn = s2hnf_opnexi_and_add (loc0, s2f)
    val sym = d2var_get_sym (d2v)
    val s2v_addr = s2var_make_id_srt (sym, s2rt_addr)
    val () = trans3_env_add_svar (s2v_addr) // adding svar
    val s2e_addr = s2exp_var (s2v_addr)
    val () = d2var_set_addr (d2v, Some s2e_addr)
    val s2e_ptr = s2exp_ptr_addr_type (s2e_addr)
    val () = d2var_set_type (d2v, Some (s2e_ptr))
    val () = d2var_set_mastype (d2v, Some (s2e_ptr))
(*
    val () = let
      val s2p = s2exp_agtz (s2e_addr) in trans3_env_hypadd_prop (loc0, s2p)
    end // end of [val]
*)
    val d2vw = d2var_ptr_viewat_make_none (d2v)
    val () = d2var_set_view (d2v, Some d2vw) // [d2v] is mutable
    val s2at = s2exp_at (s2e, s2e_addr)
    val () = d2var_set_mastype (d2vw, Some s2at)
    val s2at_opn = s2exp_at (s2e_opn, s2e_addr)
    val () = d2var_set_type (d2vw, Some (s2at_opn))
    val () = d2var_set_finknd (d2vw, D2VFINsome (s2at_opn)) // HX: may be overwritten later
  in
    p3t0
  end // end of [refknd = 1]
end (* end of [p2at_trdn_arg_refarg_var] *)

fun
p2at_trdn_arg_refarg_err
(
  p2t0: p2at, s2e0: s2exp
) : p3at = let
//
  val
  loc0 = p2t0.p2at_loc
//
  val () =
  prerr_error3_loc(loc0)
//
  val () =
  prerrln! (": the pattern is expected to be a variable.")
//
  val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
//
in
  p3at_errpat(loc0, s2e0)
end // end of [p2at_trdn_arg_refarg_err]

in (* in-of-local *)

implement
p2at_trdn_arg
  (p2t0, s2e0) = let
//
val s2f0 = s2exp2hnf (s2e0)
val s2e0 = s2hnf2exp (s2f0)
//
(*
//
val () =
println!
  ("p2at_trdn_arg: s2e0 = ", s2e0)
//
*)
//
in
//
case+
s2e0.s2exp_node
of // case+
| S2Erefarg _ => (
  case+
  p2t0.p2at_node of
(*
  | P2Tann(p2t1, _) =>
      p2at_trdn_arg(p2t1, s2e0)
    // end of [P2Tann]
*)
  | P2Tvar _ =>
    p2at_trdn_arg_refarg_var(p2t0, s2e0)
  | _ (*non-P2Tvar*) =>
    p2at_trdn_arg_refarg_err(p2t0, s2e0)
  ) (* S2Erefarg *)
//
| _ (*non-S2Erefarg*) => p2at_trdn(p2t0, s2e0)
//
end // end of [p2at_trdn_arg]

end // end of [local]

(* ****** ****** *)

implement
p2atlst_trdn_arg
(
  loc0, npf, p2ts, s2es, serr
) = let
//
fun aux
  {n:nat} .<n>. (
  npf: int
, p2ts: p2atlst, s2es: list (s2exp, n)
, serr: &int
) :<cloref1> list (p3at, n) =
  case+ p2ts of
  | list_cons (p2t, p2ts) => (
    case+ s2es of
    | list_cons (s2e, s2es) => let
        val () =
          if npf > 0 then p2at_proofize (p2t)
        // end of [val]
        val p3t = p2at_trdn_arg (p2t, s2e)
        val p3ts = aux (npf-1, p2ts, s2es, serr)
      in
        list_cons (p3t, p3ts)
      end // end of [list_cons]
    | list_nil () => let
        val () = serr := serr + 1 in list_nil ()
      end // end of [list_nil]
    ) // end of [list_cons]
  | list_nil () => (
    case+ s2es of
    | list_cons (s2e, s2es) => let
        val () = serr := serr - 1
        val p3t = p3at_errpat (loc0, s2e)
        val p3ts = aux (npf-1, p2ts, s2es, serr)
      in
        list_cons (p3t, p3ts)
      end // end of [list_cons]
    | list_nil () => list_nil ()
    ) // end of [list_nil]
// end of [aux]  
in
  aux (npf, p2ts, s2es, serr)
end (* end of [p2atlst_trdn_arg] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

extern
fun p2atlst_trdn_elt
  (p2ts: p2atlst, s2e: s2exp): p3atlst
implement
p2atlst_trdn_elt
  (p2ts, s2e) = case+ p2ts of
  | list_cons (p2t, p2ts) => let
      val p3t = p2at_trdn (p2t, s2e)
    in
      list_cons (p3t, p2atlst_trdn_elt (p2ts, s2e))
    end
  | list_nil () => list_nil ()
// end of [p2atlst_trdn_elt]

(* ****** ****** *)

extern
fun p2at_trdn_int (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_intrep (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_bool (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_char (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_float (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_string (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_i0nt (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_f0loat (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_empty (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_rec (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_lst (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_refas (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_exist (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_vbox (p2t0: p2at, s2f0: s2hnf): p3at
extern
fun p2at_trdn_ann (p2t0: p2at, s2f0: s2hnf): p3at

(* ****** ****** *)

implement
p2at_trdn
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val s2f0 = s2exp2hnf (s2e0)
//
(*
val () =
(
  println! ("p2at_trdn: p2t0 = ", p2t0);
  println! ("p2at_trdn: s2f0 = ", s2f0);
) (* end of [val] *)
*)
//
in
//
case+ p2t0.p2at_node of
//
| P2Tany _ => p2at_trdn_any(p2t0, s2f0)
| P2Tvar _ => p2at_trdn_var(p2t0, s2f0)
//
| P2Tcon _ => p2at_trdn_con(p2t0, s2f0)
//
| P2Tint _ => p2at_trdn_int(p2t0, s2f0)
| P2Tintrep _ => p2at_trdn_intrep(p2t0, s2f0)
//
| P2Tbool _ =>  p2at_trdn_bool(p2t0, s2f0)
| P2Tchar _ =>  p2at_trdn_char(p2t0, s2f0)
| P2Tfloat _ => p2at_trdn_float(p2t0, s2f0)
| P2Tstring _ => p2at_trdn_string(p2t0, s2f0)
//
| P2Ti0nt _ => p2at_trdn_i0nt (p2t0, s2f0)
| P2Tf0loat _ => p2at_trdn_f0loat (p2t0, s2f0)
//
| P2Tempty () => p2at_trdn_empty (p2t0, s2f0)
//
| P2Trec _ => p2at_trdn_rec (p2t0, s2f0)
| P2Tlst _ => p2at_trdn_lst (p2t0, s2f0)
//
| P2Trefas _ => p2at_trdn_refas (p2t0, s2f0)
//
| P2Texist _ => p2at_trdn_exist (p2t0, s2f0)
//
| P2Tvbox _ => let
    val err = the_effenv_check_ref (loc0)
    val () = if err > 0 then
      the_trans3errlst_add (T3E_p2at_trdn_vbox_ref (p2t0))
    // end of [val]
    val () = the_effenv_add_eff ($EFF.effect_ref)
  in
    p2at_trdn_vbox (p2t0, s2f0)
  end // end of [P2Tvbox]
//
| P2Tann _ => p2at_trdn_ann (p2t0, s2f0)
//
| P2Terrpat () => let
    val s2e = s2hnf2exp (s2f0) in p3at_errpat (loc0, s2e)
  end // end of [P2Terr]
//
| _ => let
    val (
    ) = (
      println! ("p2at_trdn: p2t0 = ", p2t0)
    ) // end of [val]
  in
    exitloc (1)
  end // end of [_]
end // end of [p2at_trdn]

(* ****** ****** *)

implement
p2atlst_trdn
  (loc0, p2ts, s2es, serr) = let
(*
val () = (
  fprintln! (stdout_ref, "p2atlst_trdn: p2ts = ", p2ts);
  fprintln! (stdout_ref, "p2atlst_trdn: s2es = ", s2es);
) // end of [val]
*)
in
//
case+ p2ts of
| list_cons (p2t, p2ts) => (
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val p3t = p2at_trdn (p2t, s2e)
      val p3ts = p2atlst_trdn (loc0, p2ts, s2es, serr)
    in
      list_cons (p3t, p3ts)
    end
  | list_nil () => let
      val () = serr := serr + 1 in list_nil ()
    end
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val () = serr := serr - 1
      val p3t = p3at_errpat (loc0, s2e)
      val p3ts = p2atlst_trdn (loc0, p2ts, s2es, serr)
    in
      list_cons (p3t, p3ts)
    end // end of [list_cons]
  | list_nil () => list_nil ()
  )
//
end // end of [p2atlst_trdn]

(* ****** ****** *)

implement
p2at_trdn_any
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val s2e0 = s2hnf2exp(s2f0)
//
val p3t0 = let
  val d2v = d2var_make_any(loc0)
  val s2e = s2hnf_opnexi_and_add(loc0, s2f0)
  val ((*void*)) = d2var_set_type(d2v, None())
  val ((*void*)) = d2var_set_mastype(d2v, Some(s2e0))
in
  p3at_any(loc0, s2e, d2v)
end // end of [val]
//
val islin = s2exp_is_lin(s2e0)
val ((*void*)) =
  if islin then p3at_set_type_left(p3t0, Some(s2e0))
//
in
  p3t0
end // end of [p2at_trdn_any]

(* ****** ****** *)

implement
p2at_trdn_var
  (p2t0, s2f0) = let
  val loc0 = p2t0.p2at_loc
  val-P2Tvar(d2v) = p2t0.p2at_node
//
  val s2e0 = s2hnf2exp (s2f0)
  val s2t0 = s2e0.s2exp_srt
  val islin = s2rt_is_lin (s2t0)
//
  val () = d2var_set_mastype(d2v, Some s2e0)
  val () = if islin then { // linear var
    val () = d2var_set_linval (d2v, 0)
    val () = d2var_set_finknd (d2v, D2VFINnone())
  } // end of [val]
(*
  val () = begin
    println! ("p2at_trdn_var: d2v = ", d2v);
    println! ("p2at_trdn_var: s2e0 = ", s2e0);
    println! ("p2at_trdn_var: s2t0 = ", s2t0);
  end // end of [val]
*)
  val s2e =
    s2hnf_opnexi_and_add (loc0, s2f0)
  val () = d2var_set_type (d2v, Some s2e)
(*
  val () = begin
    println! ("p2at_trdn_var: d2v = ", d2v);
    println! ("p2at_trdn_var: s2e = ", s2e);
  end // end of [val]
*)
in
  p3at_var (loc0, s2e, d2v)
end // end of [p2at_trdn_var]

(* ****** ****** *)

implement
p2at_trdn_int
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tint (i) = p2t0.p2at_node
//
val s2c_knd =
  s2cstref_get_cst (the_int_kind)
val s2e_knd = s2exp_cst (s2c_knd)
val s2e_ind = s2exp_int (i)
val s2f_ind = s2exp2hnf_cast (s2e_ind)
val s2e_pat = s2exp_g1int_kind_index_t0ype (s2e_knd, s2e_ind)
//
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val p3t0 = p3at_int (loc0, s2e, i)
//
var nerr: int = 0
val () = (
case+ s2e.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_g1int_int_t0ype, s2e_fun
  ) => let
    val-list_cons (s2e1_arg, s2es_arg) = s2es_arg
    val-list_cons (s2e2_arg, s2es_arg) = s2es_arg
    val () = $SOL.s2exp_tyleq_solve_err (loc0, s2e_knd, s2e1_arg, nerr)
    val s2f2_arg = s2exp2hnf (s2e2_arg)
  in
    trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f2_arg)
  end (* end of [S2Eapp] *)
| _ => $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat, s2e, nerr)
) (* end of [val] *)
//
val () = if (nerr > 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the integer pattern is ill-typed."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val s2e0 = s2hnf2exp (s2f0)
  val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
} // end of [val]
//
in
  p3t0
end // end of [p2at_trdn_int]

(* ****** ****** *)

implement
p2at_trdn_bool
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tbool (b) = p2t0.p2at_node
val s2e_ind = s2exp_bool (b)
val s2f_ind = s2exp2hnf_cast (s2e_ind)
val s2e_pat = s2exp_bool_index_t0ype (s2e_ind)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val p3t0 = p3at_bool (loc0, s2e, b)
//
in
//
case+ s2e.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_bool_bool_t0ype, s2e_fun
  ) => let
    val-list_cons (s2e_arg, _) = s2es_arg
    val s2f_arg = s2exp2hnf (s2e_arg)
    val () = trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f_arg)
  in
    p3t0
  end (* end of [S2Eapp] *)
| _ => let
    val nerr = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e)
    val () = if (nerr > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the boolean pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val s2e0 = s2hnf2exp (s2f0)
      val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
    } // end of [val]
  in
    p3t0
  end (* end of [_] *)
//
end // end of [p2at_trdn_bool]

(* ****** ****** *)

implement
p2at_trdn_char
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tchar (c) = p2t0.p2at_node
val s2e_ind = s2exp_int_char (c)
val s2f_ind = s2exp2hnf_cast (s2e_ind)
val s2e_pat = s2exp_char_index_t0ype (s2e_ind)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val p3t0 = p3at_char (loc0, s2e, c)
//
in
//
case+
s2e.s2exp_node
of // case+
| S2Eapp
  (
    s2e_fun, s2es_arg
  ) when s2cstref_equ_exp (
    the_char_int_t0ype, s2e_fun
  ) => let
    val-
    list_cons
      (s2e_arg, _) = s2es_arg
    // end of [val]
    val s2f_arg = s2exp2hnf (s2e_arg)
    val () = trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f_arg)
  in
    p3t0
  end (* end of [S2Eapp] *)
| _ (*non-S2Eapp*) => let
    val nerr =
      $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e)
    // end of [val]
    val () =
    if (nerr > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the char pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val s2e0 = s2hnf2exp (s2f0)
      val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
    } (* end of [val] *)
  in
    p3t0
  end (* end of [_] *)
end // end of [p2at_trdn_char]

(* ****** ****** *)

implement
p2at_trdn_float
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tfloat(dbl) = p2t0.p2at_node
//
val
s2e_pat = s2exp_double_t0ype((*void*))
//
val s2e0 = s2hnf2exp (s2f0)
val p3t0 = p3at_float (loc0, s2e0, dbl)
//
in
case+ 0 of
| _ (*non-S2Eapp*) => let
    val nerr =
      $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e0)
    // end of [val]
    val () =
    if (nerr > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the floating-point pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
    } (* end of [val] *)
  in
    p3t0
  end // end of [_(*non-S2Eapp*)]
end // end of [p2at_trdn_float]

(* ****** ****** *)

implement
p2at_trdn_string
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tstring(str) = p2t0.p2at_node
val n = string_length (str)
val n = $INTINF.intinf_make_size (n)
//
val
s2e_ind = s2exp_intinf (n)
val
s2f_ind = s2exp2hnf_cast (s2e_ind)
val
s2e_pat = s2exp_string_index_type (s2e_ind)
//
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
//
val p3t0 = p3at_string (loc0, s2e, str)
//
in
//
case+
s2e.s2exp_node
of // case+
| S2Eapp
  (
    s2e_fun, s2es_arg
  ) when
    s2cstref_equ_exp (
    the_string_int_type, s2e_fun
  ) => let
    val-
    list_cons
      (s2e_arg, _) = s2es_arg
    // end of [val-]
    val s2f_arg = s2exp2hnf (s2e_arg)
    val ((*void*)) =
      trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f_arg)
    // end of [val]
  in
    p3t0
  end (* end of [S2Eapp] *)
//
| _ (*non-S2Eapp*) => let
    val nerr =
      $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e)
    // end of [val]
    val () =
    if (nerr > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the string pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val s2e0 = s2hnf2exp (s2f0)
      val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
    } (* end of [val] *)
  in
    p3t0
  end // end of [_(*non-S2Eapp*)]
//
end // end of [p2at_trdn_string]

(* ****** ****** *)

local

fun auxcheck
(
  loc0: loc_t, s2e: s2exp, s2e_pat: s2exp, nerr: &int
) : void = let
//
val-S2Eapp
  (s2e_pat_fun, s2es_pat_arg) = s2e_pat.s2exp_node
val-list_cons (s2e_pat_knd, s2es_pat_arg) = s2es_pat_arg
val-list_cons (s2e_pat_ind, s2es_pat_arg) = s2es_pat_arg
//
in
//
case+ s2e.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg) => let
    val () = 
      $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat_fun, s2e_fun, nerr)
    // end of [val]
  in
    case+ s2es_arg of
    | list_cons (s2e1_arg, s2es_arg) => let
        val () =
          $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat_knd, s2e1_arg, nerr)
        // end of [val]
      in
        case+ s2es_arg of
        | list_cons (s2e2_arg, _) => let
            val s2f_pat_ind =
              s2exp2hnf (s2e_pat_ind)
            // end of [val]
            val s2f2_arg = s2exp2hnf (s2e2_arg)
          in
            trans3_env_hypadd_eqeq (loc0, s2f_pat_ind, s2f2_arg)
          end // end of [list_cons]
        | list_nil () => ()
      end // end of [list_cons]
    | list_nil () => (nerr := nerr + 1)
  end // end of [S2Eapp]
| _ => $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat, s2e, nerr)
//
end // end of [auxcheck]

in (* in-of-local *)

implement
p2at_trdn_intrep
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tintrep (rep) = p2t0.p2at_node
val s2e_pat = intrep_syn_type_ind (loc0, rep)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val p3t0 = p3at_intrep (loc0, s2e, rep)
//
var nerr: int = 0
val () = auxcheck (loc0, s2e, s2e_pat, nerr)
val () = if (nerr > 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the integer pattern is ill-typed."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val s2e0 = s2hnf2exp (s2f0)
  val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
} (* end of [val] *)
//
in
  p3t0
end // end of [p2at_trdn_intrep]

implement
p2at_trdn_i0nt
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Ti0nt (x) = p2t0.p2at_node
val s2e_pat = i0nt_syn_type_ind (x)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val p3t0 = p3at_i0nt (loc0, s2e, x)
//
var nerr: int = 0
val () = auxcheck (loc0, s2e, s2e_pat, nerr)
//
val () = if (nerr > 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the integer pattern is ill-typed."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val s2e0 = s2hnf2exp (s2f0)
  val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
} (* end of [val] *)
//
in
  p3t0
end // end of [p2at_trdn_i0nt]

end // end of [local]

(* ****** ****** *)

implement
p2at_trdn_f0loat
  (p2t0, s2f0) = let
  val loc0 = p2t0.p2at_loc
  val-P2Tf0loat (x) = p2t0.p2at_node
  val s2e_pat = f0loat_syn_type (x)
  val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
  val nerr = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e)
  val () = if (nerr > 0) then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the pattern of floating point number is ill-typed."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
    val s2e0 = s2hnf2exp (s2f0)
    val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
  } // end of [val]
in
  p3at_f0loat (loc0, s2e, x)
end // end of [p2at_trdn_f0loat]

(* ****** ****** *)

implement
p2at_trdn_empty
  (p2t0, s2f0) = let
  val loc0 = p2t0.p2at_loc
  val-P2Tempty () = p2t0.p2at_node
  val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
  val s2e_pat = s2exp_void_t0ype ()
  val err = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e)
  val () = if (err > 0) then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the void pattern is ill-typed."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
    val s2e0 = s2hnf2exp (s2f0)
    val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
  } // end of [val]
in
  p3at_empty (loc0, s2e)
end // end of [p2at_trdn_empty]

(* ****** ****** *)

extern
fun
labp2atlst_trdn
(
  loc0: loc_t
, lp2ts: labp2atlst, ls2es: labs2explst, nerr: &int
) : labp3atlst // end of [labp2atlst_trdn_labs2explst]

implement
labp2atlst_trdn
  (loc0, lp2ts, ls2es, nerr) = let
//
val isomit =
  aux (lp2ts) where {
  fun aux (xs: labp2atlst): bool =
    case+ xs of
    | list_cons (x, xs) => (case+ x of
      | LABP2ATnorm _ => aux (xs) | LABP2ATomit _ => true
      ) // end of [list_cons]
    | list_nil () => false
  // end of [aux]
} // end of [val]
//
fun auxrest (
  lp2ts: labp2atlst, nerr: &int
) :<cloref1> void = (
  case+ lp2ts of
  | list_cons (lp2t, lp2ts) => (
    case+ lp2t of
    | LABP2ATnorm (l0, _) => let
        val () = prerr_error3_loc (loc0)
        val () = filprerr_ifdebug "labp2atlst_trdn"
        val () = prerr ": there is no component of the label ["
        val () = $LAB.prerr_label (l0.l0ab_lab)
        val () = prerr "] in the type assigned to the tuple/record pattern."
        val () = prerr_newline ()
        val () = nerr := nerr + 1
      in
        auxrest (lp2ts, nerr)
      end // end of [LABP2ATnorm]
    | LABP2ATomit (loc) => auxrest (lp2ts, nerr)
    ) // end of [list_cons]
  | list_nil () => ()
) (* end of [auxrest] *)
//
fun auxfind (
  lp2ts: &labp2atlst, l: label
) :<cloref1> Option_vt (p2at) =
  case+ lp2ts of
  | list_cons (lp2t, lp2ts1) => (
    case+ lp2t of
    | LABP2ATnorm (l0, p2t) =>
        if l = l0.l0ab_lab then let
          val () = lp2ts := lp2ts1 in Some_vt (p2t)
        end else let
          var lp2ts1 = lp2ts1
          val res = auxfind (lp2ts1, l)
          val found = option_vt_is_some (res)
          val () =
            if found then (lp2ts := list_cons (lp2t, lp2ts1))
          // end of [val]
        in
          res
        end // end of [if]
    | LABP2ATomit _ => let
        val () = lp2ts := list_sing (lp2t) in None_vt ()
      end // end of [LABP2ATomit]
    ) (* end of [list_cons] *)
  | list_nil () => None_vt ()
// end of [auxfind]
//
fun auxcheck (
  lp2ts: &labp2atlst, ls2es: labs2explst, err: &int
) :<cloref1> labp3atlst = let
in
//
case+ ls2es of
| list_cons (ls2e, ls2es) => let
    val SLABELED (l, _, s2e) = ls2e
    val opt = auxfind (lp2ts, l)
  in
    case+ opt of
    | ~Some_vt (p2t) => let
        val p3t = p2at_trdn (p2t, s2e)
        val lp3t = LABP3AT (l, p3t)
        val lp3ts = auxcheck (lp2ts, ls2es, err)
      in
        list_cons (lp3t, lp3ts)
      end // end of [Some_vt]
    | ~None_vt () => let
        var p3t: p3at
        val () = if isomit then {
          val d2v = d2var_make_any (loc0)
          val () = p3t := p3at_any (loc0, s2e, d2v)
        } else { // HX: no omission is allowed
          val () = prerr_error3_loc (loc0)
          val () = filprerr_ifdebug "labp2atlst_trdn"
          val () = prerr ": there is no component of the label ["
          val () = $LAB.prerr_label (l)
          val () = prerr "]"
          val () = prerr_newline ()
          val () = err := err + 1
          val () = p3t := p3at_errpat (loc0, s2e)
        } // end of [val]
        val lp3t = LABP3AT (l, p3t)
        val lp3ts = auxcheck (lp2ts, ls2es, err)
      in
        list_cons (lp3t, lp3ts)
      end // end of [None_vt]
  end (* end of [list_cons] *)
| list_nil () => list_nil ()
end // end of [auxcheck]
//
var lp2ts = lp2ts
val lp3ts = auxcheck (lp2ts, ls2es, nerr)
val () = auxrest (lp2ts, nerr)
//
in
  lp3ts
end // end of [labp2atlst_trdn]

(* ****** ****** *)

implement
p2at_trdn_rec
  (p2t0, s2f0) = let
//
val
loc0 = p2t0.p2at_loc
//
val-
P2Trec
(knd, npf, lp2ts) = p2t0.p2at_node
//
val s2e = s2hnf_opnexi_and_add(loc0, s2f0)
//
in
//
case+
s2e.s2exp_node of
//
| S2Etyrec
  (
    knd1, npf1, ls2es
  ) => let
//
    val
    isbox = (knd > 0)
    val
    islin = s2exp_is_lin(s2e)
//
    val
    isbox1 =
    tyreckind_is_boxed(knd1)
    val () =
    if (isbox != isbox1) then
    {
      val () =
      prerr_error3_loc (loc0)
      val () =
      prerr ": the tuple/record pattern is "
      val () =
      if isbox then prerr "boxed but it is assigned a flat/unboxed type."
      val () =
      if ~isbox then prerr "flat/unboxed but it is assigned a boxed type."
      val () = prerr_newline ()
//
      val
      s2e0 = s2hnf2exp (s2f0)
      val ((*void*)) =
      the_trans3errlst_add(T3E_p2at_trdn(p2t0, s2e0))
//
    } (* end of [val] *)
    val
    nerr =
    $SOL.pfarity_equal_solve
      (loc0, npf, npf1)
    // end of [val]
    val () = if (nerr > 0) then
    {
//
      val () =
      prerr_the_staerrlst()
//
      val
      s2e0 = s2hnf2exp(s2f0)
      val ((*void*)) =
      the_trans3errlst_add(T3E_p2at_trdn(p2t0, s2e0))
    } // end of [val]
//
    var
    nerr: int = 0
    val
    lp3ts =
    labp2atlst_trdn(loc0, lp2ts, ls2es, nerr)
    val () = if (nerr > 0) then
    {
      val
      s2e0 = s2hnf2exp(s2f0)
      val ((*void*)) =
      the_trans3errlst_add(T3E_p2at_trdn(p2t0, s2e0))
    } // end of [val]
//
    val pck =
    (
      if (isbox && islin) then PCKfree() else PCKcon()
    ) : pckind // end of [val]
//
  in
    p3at_rec(loc0, s2e, knd, npf, pck, lp3ts)
  end // end of [S2Etyrec]
| _ (* non-S2Etyrec *) =>
    p3at_errpat(loc0, s2e) where
  {
//
    val () =
    prerr_error3_loc(loc0)
    val () =
    prerrln! (": the tuple/record pattern is ill-typed.")
//
    val s2e0 = s2hnf2exp(s2f0)
    val ((*void*)) =
    the_trans3errlst_add(T3E_p2at_trdn(p2t0, s2e0))
//
  } // end of [rest-of-p2at]
//
end // end of [p2at_trdn_rec]

(* ****** ****** *)

local
//
fun
auxerr_lin
  (p2t0: p2at): void = let
  val () = prerr_error3_loc (p2t0.p2at_loc)
  val () = prerrln! (": the list-pattern should be non-linear.")
in
  the_trans3errlst_add (T3E_p2at_trdn_lst (0, p2t0))
end // end of [auxerr_lin]
//
fun
auxerr_nonlin
  (p2t0: p2at): void = let
  val () = prerr_error3_loc (p2t0.p2at_loc)
  val () = prerrln! (": the list-pattern should be linear but it is not.")
in
  the_trans3errlst_add (T3E_p2at_trdn_lst (1, p2t0))
end // end of [auxerr_nonlin]
//
in (* in-of-local *)

implement
p2at_trdn_lst
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tlst (lin, p2ts) = p2t0.p2at_node
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
//
val islin =
(
  if lin >= 0 then test_linkind(lin) else false
) : bool // end of [val]
//
in
//
case+
s2e.s2exp_node of
//
| S2Eapp
  (
    s2e_fun, s2es_arg
  )
    when s2cstref_equ_exp (
    the_list_t0ype_int_type, s2e_fun
  ) => let
    val-list_cons
      (s2e1_arg, s2es_arg) = s2es_arg
    val-list_cons
      (s2e2_arg, s2es_arg) = s2es_arg
    val p3ts = p2atlst_trdn_elt (p2ts, s2e1_arg)
    val n = list_length (p3ts)
    val s2e_ind = s2exp_int (n)
    val s2f_ind =
      s2exp2hnf_cast (s2e_ind)
    // end of [val]
    val s2f2_arg = s2exp2hnf (s2e2_arg)
    val () = trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f2_arg)
//
    val () = if islin then auxerr_lin (p2t0)
//
  in
    p3at_lst (loc0, s2e, 0(*lin*), s2e1_arg, p3ts)
  end // list_t0ype_int_type
//
| S2Eapp
  (
    s2e_fun, s2es_arg
  )
    when s2cstref_equ_exp (
    the_list_vt0ype_int_vtype, s2e_fun
  ) => let
    val-list_cons
      (s2e1_arg, s2es_arg) = s2es_arg
    val-list_cons
      (s2e2_arg, s2es_arg) = s2es_arg
    val p3ts = p2atlst_trdn_elt (p2ts, s2e1_arg)
    val n = list_length (p3ts)
    val s2e_ind = s2exp_int (n)
    val s2f_ind =
      s2exp2hnf_cast (s2e_ind)
    // end of [val]
    val s2f2_arg = s2exp2hnf (s2e2_arg)
    val () = trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f2_arg)
//
    val () = if not(islin) then auxerr_nonlin (p2t0)
//
  in
    p3at_lst (loc0, s2e, 1(*lin*), s2e1_arg, p3ts)
  end // list_vt0ype_int_vtype
//
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the list pattern is ill-typed.";
    val () = prerr_newline ()
    val s2e0 = s2hnf2exp (s2f0)
    val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
  in
    p3at_errpat (loc0, s2e)
  end // end of [_]
//
end // end of [p2at_trdn_lst]

end // end of [local]

(* ****** ****** *)

implement
p2at_trdn_refas
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Trefas (d2v, p2t) = p2t0.p2at_node
val s2e0 = s2hnf2exp (s2f0)
val () = d2var_set_mastype (d2v, Some s2e0)
val s2e1 = s2hnf_opnexi_and_add (loc0, s2f0)
val p3t = p2at_trdn (p2t, s2e1)
val p3t0 = p3at_refas (loc0, s2e0, d2v, p3t)
val () = let
  val opt = p3at_get_type_left (p3t)
in
//
case+ opt of
| Some _ => {
//
// HX-2012-05:
// [d2v] must be linear in this case
//
    val () = d2var_set_type (d2v, opt)
    val () = d2var_set_linval (d2v, 0)
  } // end of [Some]
| None () => (
    d2var_set_type (d2v, Some (s2exp_topize_1 (s2e1)))
  ) // end of [None]
//
end // end of [val]
//
in
  p3t0
end // end of [p2at_trdn_refas]

(* ****** ****** *)

local

fun auxerr1
(
  loc0: loc_t
, s2v1: s2var, s2v2: s2var
) : void = let
  val s2t1 = s2var_get_srt (s2v1)
  val s2t2 = s2var_get_srt (s2v2)
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the static variable [";
  val () = prerr_s2var (s2v1)
  val () = prerr "] is of the sort ["
  val () = prerr_s2rt (s2t1)
  val () = prerr "] but it is bound to a term of the sort ["
  val () = prerr_s2rt (s2t2)
  val () = prerr "]."
  val () = prerr_newline ()
in
  // nothing
end // end of [auxerr1]
//
fun auxerr2
(
  loc0: loc_t, s2v1: s2var
) : void = let
   val () = prerr_error3_loc (loc0)
   val () = prerr ": there is no binding for the static variable [";
   val () = prerr_s2var (s2v1)
   val () = prerr "]"
   val () = prerr_newline ()
in
  // nothing
end // end of [auxerr2]
//
fun auxbind
(
  loc0: loc_t
, sub: &stasub, s2vs1: s2varlst, s2vs2: s2varlst
, err: &int
) : void = let
in
//
case+ s2vs1 of
| list_cons
    (s2v1, s2vs1) => (
  case+ s2vs2 of
  | list_cons
      (s2v2, s2vs2) => let
      val s2t1 = s2var_get_srt (s2v1)
      val s2t2 = s2var_get_srt (s2v2)
      var s2e1 // HX: [s2e1] is for [s2v2]
        : s2exp = s2exp_var_srt (s2t2, s2v1)
      // end of [var]
      val ismat = s2rt_ltmat1 (s2t2, s2t1)
      val () = if
        not(ismat) then {
        val () = err := err + 1
        val () = auxerr1(loc0, s2v1, s2v2)
        val () = s2e1 := s2exp_errexp(s2t2) // for [s2v2]
      } // end of [val]
      val () = stasub_add (sub, s2v2, s2e1)
    in
      auxbind (loc0, sub, s2vs1, s2vs2, err)
    end // end of [list_cons]
  | list_nil () => let
      val () = err := err + 1
      val () = auxerr2 (loc0, s2v1)
    in
      auxbind (loc0, sub, s2vs1, s2vs2, err)
    end // end of [list_nil]
  ) // end of [list_cons]
| list_nil () => (case+ s2vs2 of
  | list_cons _ => auxbind (loc0, sub, s2vs1, s2vs2, err)
  | list_nil () => ()
  ) // end of [list_nil]
//
end // end of [auxbind]

in (* in-of-local *)

implement
p2at_trdn_exist
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Texist (s2vs, p2t) = p2t0.p2at_node
val s2e0 = s2hnf2exp (s2f0)
//
in
//
case+ s2e0.s2exp_node of
| S2Eexi (s2vs2, s2ps2, s2e) => let
    var sub: stasub = stasub_make_nil ()
    var err: int = 0
    val () = auxbind (loc0, sub, s2vs, s2vs2, err)
    val () = if (err > 0) then {
      val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
    } // end of [val]
    val () = trans3_env_add_svarlst (s2vs)
    val s2ps2 = s2explst_subst_vt (sub, s2ps2)
    val () = trans3_env_hypadd_proplst_vt (loc0, s2ps2)
    val s2e = s2exp_subst (sub, s2e)
    val () = stasub_free (sub)
    val p3t = p2at_trdn (p2t, s2e)
  in
    p3at_exist (loc0, s2e0, s2vs, p3t)
  end // end of [S2Eexi]
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the pattern is given the type ["
    val () = prerr_s2exp (s2e0)
    val () = prerr "] but an existentially quantified type is expected."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
  in
    p3at_errpat (loc0, s2e0)
  end (* end of [_] *)
//
end // end of [p2at_trdn_exist]

end // end of [local]

(* ****** ****** *)

implement
p2at_trdn_vbox
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tvbox (d2v) = p2t0.p2at_node
val s2e0 = s2hnf2exp (s2f0)
val opt = un_s2exp_vbox_view_prop (s2f0)
in
//
case+ opt of
//
| ~Some_vt (s2e) => let
    val s2f = s2exp2hnf (s2e)
    val s2e = s2hnf2exp (s2f)
    val islin = s2exp_is_lin (s2e)
    val () = d2var_set_mastype (d2v, Some s2e)
    val () = if islin then {
      val () = d2var_set_linval (d2v, 0)
      val () = d2var_set_finknd (d2v, D2VFINsome_vbox (s2e))
    } // end of [if]
    val s2e = s2hnf_opnexi_and_add (loc0, s2f)
    val () = d2var_set_type (d2v, Some s2e)
  in
    p3at_vbox (loc0, s2e0, d2v)
  end // end of [Some_vt]
//
| ~None_vt ((*void*)) => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the pattern is given the type ["
    val () = prerr_s2exp (s2e0)
    val () = prerr "] but a vbox type is expected instead."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
  in
    p3at_errpat (loc0, s2e0)
  end // end of [None_vt]
//
end // end of [p2at_trdn_vbox]

(* ****** ****** *)

implement
p2at_trdn_ann
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val-P2Tann (p2t, s2e_ann) = p2t0.p2at_node
val s2e0 = s2hnf_opnexi_and_add (loc0, s2f0)
val nerr = $SOL.s2exp_tyleq_solve (loc0, s2e0, s2e_ann)
//
val () =
  if (nerr > 0) then let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "p2at_trdn_ann"
    val () = prerr ": the pattern cannot be given the ascribed type."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
  in
    the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
  end // end of [if] // end of [val]
//
val p3t = p2at_trdn (p2t, s2e0)
//
in
  p3at_ann (loc0, s2e0, p3t, s2e_ann)
end // end of [p2at_trdn_ann]

(* ****** ****** *)

implement
guard_trdn
  (loc0, gval, s2e0) = let
//
val s2f0 = s2exp2hnf (s2e0)
val s2e_ind = s2exp_bool (gval)
val s2f_ind = s2exp2hnf_cast (s2e_ind)
val s2e_gval = s2exp_bool_index_t0ype (s2e_ind)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
in
//
case+
s2e.s2exp_node of
//
| S2Eapp
  (
    s2e_fun, s2es_arg
  ) when
    s2cstref_equ_exp
  (
    the_bool_bool_t0ype, s2e_fun
  ) => let
    val-list_cons
      (s2e_arg, _) = s2es_arg
    // end of [val]
    val s2f_arg = s2exp2hnf (s2e_arg)
  in
    trans3_env_hypadd_eqeq (loc0, s2f_ind, s2f_arg)
  end // end of [S2Eapp]
//
| _ (*non-app*) => let
    val nerr =
      $SOL.s2exp_tyleq_solve (loc0, s2e_gval, s2e)
    val () =
    if (nerr > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the guard is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val s2e0 = s2hnf2exp (s2f0)
      val () = the_trans3errlst_add (T3E_guard_trdn (loc0, gval, s2e0))
    } (* end of [if] *) // end of [val]
  in
    (* nothing *)
  end // end of [_]
//
end // end of [guard_trdn]

(* ****** ****** *)

(*
implement
p3at_mutablize
  (p3t0) = let
  val loc0 = p3t0.p3at_loc
//
fun auxvar
(
  loc0: loc_t, d2v: d2var
) : void = let
  val-Some
    (s2e0) = d2var_get_mastype (d2v)
  val d2vw = d2var_mutablize (loc0, d2v, s2e0)
  val-Some (s2l) = d2var_get_addr (d2v)
  val s2at0 = s2exp_at (s2exp_topize_0 (s2e0), s2l)
  val () = d2var_set_finknd (d2vw, D2VFINsome (s2at0))
in
  // nothing
end // end of [auxvar]
//
in
//
case+ p3t0.p3at_node of
| P3Tvar (d2v) => auxvar (loc0, d2v)
| P3Trefas (d2v, _) => auxvar (loc0, d2v)
| P3Tann (p3t, _) => p3at_mutablize (p3t)
//
| _ => ()
//
end // end of [p3at_mutablize]
*)

(* ****** ****** *)

(* end of [pats_trans3_p2at.dats] *)
