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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_exp_up"

(* ****** ****** *)

staload
INTINF = "pats_intinf.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
overload = with $LAB.eq_label_label

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

local

extern
fun aux_p2at (p2t0: p2at): s2exp
extern
fun aux_labp2atlst (lp2ts: labp2atlst): labs2explst

implement
aux_p2at (p2t0) = let
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
  | P2Tintrep rep =>
      intrep_syn_type (p2t0.p2at_loc, rep) // intrep
  | P2Tbool _ => s2exp_bool_t0ype () // bool0
  | P2Tchar _ => s2exp_char_t0ype () // char0
  | P2Tstring _ => s2exp_string_type () // string0
  | P2Tfloat _ => s2exp_double_t0ype () // double
//
  | P2Ti0nt (x) => i0nt_syn_type (x)
  | P2Tf0loat (x) => f0loat_syn_type (x)
//
  | P2Tempty () => s2exp_void_t0ype ()
  | P2Tcon _ =>
      s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
    // end of [P2Tcon]
//
  | P2Tlst _ => let
      val s2e_elt =
        s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
      // end of [val]
    in
      s2exp_list0_t0ype_type (s2e_elt)
    end // end of [P2Tlst]
//
  | P2Trec (knd, npf, lp2ts) =>
      s2exp_tyrec (knd, npf, aux_labp2atlst (lp2ts))
    // end of [P2Trec]
//
  | P2Tas (knd, d2v, p2t) => p2at_syn_type (p2t)
//
  | P2Tlist _ => s2exp_err (s2rt_t0ype)
  | P2Texist _ => s2exp_err (s2rt_t0ype)
  | P2Terr () => s2exp_err (s2rt_t0ype)
(*
  | _ => let
      val () = assertloc (false) in exit (1)
    end // end of [_]
*)
//
end // end of [aux_p2at]
  
implement
aux_labp2atlst (lp2ts) =
  case+ lp2ts of
  | list_cons (lp2t, lp2ts) => (
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
  | list_nil () => list_nil ()
// end of [aux_labp2atlst]

in // in of [local]

implement
p2at_syn_type
  (p2t0) = s2e0 where {
  val s2e0 = aux_p2at (p2t0)
  val () = p2at_set_type (p2t0, Some (s2e0))
} // end of [p2at_syn_type]

end // end of [local]

implement
p2atlst_syn_type (p2ts) =
  l2l (list_map_fun (p2ts, p2at_syn_type))
// end of [p2atlst_syn_type]

(* ****** ****** *)

implement
p2at_trup_arg (p2t0) = let
(*
  val () = begin
    print "p2at_trup_arg: p2t0 = "; print p2t0; print_newline ();
  end // end of [val]
*)
in
//
case+ p2t0.p2at_node of
| P2Tann (p2t, s2e) =>
    p2at_trdn_arg (p2t, s2e)
| _ => let
    val- Some (s2e) = p2t0.p2at_type
  in
    p2at_trdn (p2t0, s2e)
  end // end of [_]
//
end // end of [p2at_arg_tr_up]

(* ****** ****** *)

local

fn p2at_proofize
  (p2t: p2at) = let
  val dvs = p2t.p2at_dvs
  val dvs = $UT.lstord_listize (dvs)
in
  list_foreach_fun<d2var>
    (dvs, lam d2v =<1> d2var_set_isprf (d2v, true))
end (* end of [p2at_proofize] *)

in // in of [local]

implement
p2atlst_trup_arg
  (npf, p2ts) = res where {
  fun loop (
    npf: int, p2ts: p2atlst
  , res: &p3atlst? >> p3atlst
  ) : void =
    case+ p2ts of
    | list_cons (p2t, p2ts) => let
        val () =
          if npf > 0 then p2at_proofize (p2t)
        // end of [val]
        val p3t = p2at_trup_arg (p2t)
        val () = res := list_cons {p3at}{0} (p3t, ?)
        val+ list_cons (_, !p_res) = res
        val () = loop (npf-1, p2ts, !p_res)
        prval () = fold@ (res)
      in
        // nothing
      end // end of [list_cons]
    | list_nil () => (res := list_nil)
  // end of [loop]
  var res: p3atlst // uninitialized
  val () = loop (npf, p2ts, res)
} // end of [p2atlst_trup_arg]

(* ****** ****** *)

implement
p2at_trdn_arg
  (p2t, s2e) = p2at_trdn (p2t, s2e)
// end of [p2at_trdn_arg]

(* ****** ****** *)

implement
p2atlst_trdn_arg (
  npf, p2ts, s2es, err
) = let
  fun aux (
    npf: int
  , p2ts: p2atlst, s2es: s2explst
  , err: &int
  ) : p3atlst =
    case+ p2ts of
    | list_cons (p2t, p2ts) => (
      case+ s2es of
      | list_cons (s2e, s2es) => let
          val () =
            if npf > 0 then p2at_proofize (p2t)
          val p3t = p2at_trdn_arg (p2t, s2e)
        in
          list_cons (p3t, aux (npf-1, p2ts, s2es, err))
        end // end of [list_cons]
      | list_nil () => let
          val () = err := err + 1 in list_nil ()
        end
      ) // end of [list_cons]
    | list_nil () => (
      case+ s2es of
      | list_cons _ => let
          val () = err := err - 1 in list_nil ()
        end
      | list_nil () => list_nil ()
      ) // end of [list_nil]
  // end of [aux]  
in
  aux (npf, p2ts, s2es, err)
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
fun p2at_trdn_any (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_var (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_int (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_intrep (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_bool (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_char (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_string (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_i0nt (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_f0loat (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_empty (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_rec (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_lst (p2t0: p2at, s2e0: s2exp): p3at
extern
fun p2at_trdn_exist (p2t0: p2at, s2e0: s2exp): p3at

(* ****** ****** *)

fun p2at_trdn_ann .<>.
  (p2t0: p2at, s2e0: s2exp): p3at = let
  val loc0 = p2t0.p2at_loc
  val- P2Tann (p2t, s2e_ann) = p2t0.p2at_node
  val err = $SOL.s2exp_tyleq_solve (loc0, s2e0, s2e_ann)
  val () = if (err > 0) then let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "p2at_trdn_ann"
    val () = prerr ": the pattern cannot be given the ascribed type."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
  in
    the_trans3errlst_add (T3E_p2at_trdn_ann (p2t0, s2e0))
  end // end of [val]
  val p3t = p2at_trdn (p2t, s2e0)
in
  p3at_ann (loc0, s2e0, p3t, s2e_ann)
end // end of [p2at_trdn_ann]

(* ****** ****** *)

implement
p2at_trdn
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
// (*
  val () = begin
    print "p2at_trdn: p2t0 = "; print_p2at p2t0; print_newline ();
    print "p2at_trdn: s2e0 = "; print_s2exp s2e0; print_newline ();
  end // end of [val]
// *)
in
//
case+ p2t0.p2at_node of
//
| P2Tany _ =>
    p2at_trdn_any (p2t0, s2e0)
| P2Tvar _ =>
    p2at_trdn_var (p2t0, s2e0)
//
| P2Tint _ =>
    p2at_trdn_int (p2t0, s2e0)
| P2Tintrep _ =>
    p2at_trdn_intrep (p2t0, s2e0)
| P2Tbool _ => 
    p2at_trdn_bool (p2t0, s2e0)
| P2Tchar _ => 
    p2at_trdn_char (p2t0, s2e0)
| P2Tstring _ =>
    p2at_trdn_string (p2t0, s2e0)
//
| P2Ti0nt _ =>
    p2at_trdn_i0nt (p2t0, s2e0)
| P2Tf0loat _ =>
    p2at_trdn_f0loat (p2t0, s2e0)
//
| P2Tempty () =>
    p2at_trdn_empty (p2t0, s2e0)
//
| P2Trec _ => p2at_trdn_rec (p2t0, s2e0)
| P2Tlst _ => p2at_trdn_lst (p2t0, s2e0)
//
| P2Texist _ => p2at_trdn_exist (p2t0, s2e0)
//
| P2Tann _ => p2at_trdn_ann (p2t0, s2e0)
//
| P2Terr () => p3at_err (loc0, s2e0)
//
| _ => let
    val () = (
      print "p2at_trdn: p2t0 = "; print_p2at (p2t0); print_newline ()
    ) // end of [val]
    val () = assertloc (false) in exit (1)
  end // end of [_]
end // end of [p2at_trdn]

(* ****** ****** *)

implement
p2at_trdn_any
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
  val d2v = d2var_make_any (loc0)
  val p3t = p3at_any (loc0, s2e0, d2v)
(*
  val () = d2var_set_type (d2v, None ())
  val () = d2var_set_mastype (d2v, Some (s2e))
*)
  val s2e = s2e0
  val s2e = s2exp_opnexi_and_add (loc0, s2e0)
in
  p3t
end // end of [p2at_trdn_any]

(* ****** ****** *)

implement
p2at_trdn_var
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
  val- P2Tvar (knd, d2v) = p2t0.p2at_node
  val s2t0 = s2e0.s2exp_srt
  val islin = s2rt_is_lin (s2t0)
//
  val p3t0 = p3at_var (loc0, s2e0, knd(*refval*), d2v)
//
  val () = d2var_set_mastype (d2v, Some s2e0)
  val () = if islin then { // linear var
    val () = d2var_set_linval (d2v, 0)
    val () = d2var_set_finknd (d2v, D2VFINnone())
  } // end of [val]
(*
  val () = begin
    print "p2at_trdn_var: d2v = "; print d2v; print_newline ();
    print "p2at_trdn_var: s2e0 = "; print_s2exp s2e0; print_newline ();
    print "p2at_trdn_var: s2t0 = "; print_s2rt s2t0; print_newline ();
  end // end of [val]
*)
  val s2e = s2e0
  val s2e = s2exp_opnexi_and_add (loc0, s2e0)
  val () = d2var_set_type (d2v, Some s2e)
(*
  val () = begin
    print "p2at_trdn_var: d2v = "; print d2v; print_newline ();
    print "p2at_trdn_var: s2e = "; print s2e; print_newline ();
  end // end of [val]
*)
in
  p3t0
end // end of [p2at_trdn_var]

(* ****** ****** *)

implement
p2at_trdn_int
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tint (i) = p2t0.p2at_node
//
val s2c_knd =
  s2cstref_get_cst (the_int_kind)
val s2e_knd = s2exp_cst (s2c_knd)
val s2e_ind = s2exp_int (i)
val s2e_pat = s2exp_g1int_kind_index_t0ype (s2e_knd, s2e_ind)
//
val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
val p3t0 = p3at_int (loc0, s2e0, i)
//
var err: int = 0
val () = (
case+ s2e0.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_g1int_int_t0ype, s2e_fun
  ) => let
    val- list_cons (s2e1_arg, s2es_arg) = s2es_arg
    val- list_cons (s2e2_arg, s2es_arg) = s2es_arg
    val () = $SOL.s2exp_tyleq_solve_err (loc0, s2e_knd, s2e1_arg, err)
  in
    trans3_env_hypadd_eqeq (loc0, s2e_ind, s2e2_arg)
  end (* end of [S2Eapp] *)
| _ => $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat, s2e0, err)
) (* end of [val] *)
//
val () = if (err > 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the integer pattern is ill-typed."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val () = the_trans3errlst_add (T3E_p2at_trdn_int (p2t0, s2e0))
} // end of [val]
//
in
  p3t0
end // end of [p2at_trdn_int]

(* ****** ****** *)

implement
p2at_trdn_bool
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tbool (b) = p2t0.p2at_node
val s2e_ind = s2exp_bool (b)
val s2e_pat = s2exp_bool_index_t0ype (s2e_ind)
val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
val p3t0 = p3at_bool (loc0, s2e0, b)
//
in
//
case+ s2e0.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_bool_bool_t0ype, s2e_fun
  ) => let
    val- list_cons (s2e_arg, _) = s2es_arg
    val () = trans3_env_hypadd_eqeq (loc0, s2e_ind, s2e_arg)
  in
    p3t0
  end (* end of [S2Eapp] *)
| _ => let
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e0)
    val () = if (err > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the boolean pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trdn_bool (p2t0, s2e0))
    } // end of [val]
  in
    p3t0
  end (* end of [_] *)
//
end // end of [p2at_trdn_bool]

(* ****** ****** *)

implement
p2at_trdn_char
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tchar (c) = p2t0.p2at_node
val s2e_ind = s2exp_char (c)
val s2e_pat = s2exp_char_index_t0ype (s2e_ind)
val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
val p3t0 = p3at_char (loc0, s2e0, c)
//
in
//
case+ s2e0.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_char_char_t0ype, s2e_fun
  ) => let
    val- list_cons (s2e_arg, _) = s2es_arg
    val () = trans3_env_hypadd_eqeq (loc0, s2e_ind, s2e_arg)
  in
    p3t0
  end (* end of [S2Eapp] *)
| _ => let
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e0)
    val () = if (err > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the char pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trdn_char (p2t0, s2e0))
    } // end of [val]
  in
    p3t0
  end (* end of [_] *)
end // end of [p2at_trdn_char]

(* ****** ****** *)

implement
p2at_trdn_string
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tstring (str) = p2t0.p2at_node
val n = string_length (str)
val n = $INTINF.intinf_make_size (n)
val s2e_ind = s2exp_intinf (n)
val s2e_pat = s2exp_string_index_type (s2e_ind)
val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
val p3t0 = p3at_string (loc0, s2e_pat, str)
//
in
//
case+ s2e0.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_string_int_type, s2e_fun
  ) => let
    val- list_cons (s2e_arg, _) = s2es_arg
    val () = trans3_env_hypadd_eqeq (loc0, s2e_ind, s2e_arg)
  in
    p3t0
  end (* end of [S2Eapp] *)
| _ => let
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e0)
    val () = if (err > 0) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the char pattern is ill-typed."
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trdn_char (p2t0, s2e0))
    } // end of [val]
  in
    p3t0
  end // end of [_]
//
end // end of [p2at_trdn_string]

(* ****** ****** *)

local

fun auxcheck (
  loc0: location
, s2e0: s2exp, s2e_pat: s2exp, err: &int
) : void = let
//
val- S2Eapp
  (s2e_pat_fun, s2es_pat_arg) = s2e_pat.s2exp_node
val- list_cons (s2e_pat_knd, s2es_pat_arg) = s2es_pat_arg
val- list_cons (s2e_pat_ind, s2es_pat_arg) = s2es_pat_arg
//
in
//
case+ s2e0.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg) => let
    val () = 
      $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat_fun, s2e_fun, err)
    // end of [val]
  in
    case+ s2es_arg of
    | list_cons (s2e1_arg, s2es_arg) => let
        val () =
          $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat_knd, s2e1_arg, err)
        // end of [val]
      in
        case+ s2es_arg of
        | list_cons (s2e2_arg, _) =>
            trans3_env_hypadd_eqeq (loc0, s2e_pat_ind, s2e2_arg)
        | list_nil () => ()
      end // end of [list_cons]
    | list_nil () => (err := err + 1)
  end // end of [S2Eapp]
| _ => $SOL.s2exp_tyleq_solve_err (loc0, s2e_pat, s2e0, err)
//
end // end of [auxcheck]

in // in of [local]

implement
p2at_trdn_intrep
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tintrep (rep) = p2t0.p2at_node
val s2e_pat = intrep_syn_type_ind (loc0, rep)
val s2e0 =
  s2exp_opnexi_and_add (loc0, s2e0)
val p3t0 = p3at_intrep (loc0, s2e0, rep)
//
var err: int = 0
val () = auxcheck (loc0, s2e0, s2e_pat, err)
//
val () = if (err > 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the integer pattern is ill-typed."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val () = the_trans3errlst_add (T3E_p2at_trdn_intrep (p2t0, s2e0))
} (* end of [val] *)
//
in
  p3t0
end // end of [p2at_trdn_intrep]

implement
p2at_trdn_i0nt
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Ti0nt (x) = p2t0.p2at_node
val s2e_pat = i0nt_syn_type_ind (x)
val s2e0 =
  s2exp_opnexi_and_add (loc0, s2e0)
val p3t0 = p3at_i0nt (loc0, s2e0, x)
//
var err: int = 0
val () = auxcheck (loc0, s2e0, s2e_pat, err)
//
val () = if (err > 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the integer pattern is ill-typed."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val () = the_trans3errlst_add (T3E_p2at_trdn_i0nt (p2t0, s2e0))
} (* end of [val] *)
//
in
  p3t0
end // end of [p2at_trdn_i0nt]

end // end of [local]

(* ****** ****** *)

implement
p2at_trdn_f0loat
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
  val- P2Tf0loat (x) = p2t0.p2at_node
  val s2e_pat = f0loat_syn_type (x)
  val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
  val err = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e0)
  val () = if (err > 0) then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the pattern of floating point number is ill-typed."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
    val () = the_trans3errlst_add (T3E_p2at_trdn_f0loat (p2t0, s2e0))
  } // end of [val]
in
  p3at_f0loat (loc0, s2e_pat, x)
end // end of [p2at_trdn_f0loat]

(* ****** ****** *)

implement
p2at_trdn_empty
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
  val- P2Tempty () = p2t0.p2at_node
  val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
  val s2e_pat = s2exp_void_t0ype ()
  val err = $SOL.s2exp_tyleq_solve (loc0, s2e_pat, s2e0)
  val () = if (err > 0) then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the void pattern is ill-typed."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
    val () = the_trans3errlst_add (T3E_p2at_trdn_empty (p2t0, s2e0))
  } // end of [val]
in
//
p3at_empty (loc0, s2e0)
//
end // end of [p2at_trdn_empty]

(* ****** ****** *)

extern
fun labp2atlst_trdn (
  loc0: location, lp2ts: labp2atlst, ls2es: labs2explst, err: &int
) : labp3atlst // end of [labp2atlst_trdn_labs2explst]

implement
labp2atlst_trdn
  (loc0, lp2ts, ls2es, err) = let
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
  lp2ts: labp2atlst, err: &int
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
        val () = err := err + 1
      in
        auxrest (lp2ts, err)
      end // end of [LABP2ATnorm]
    | LABP2ATomit (loc) => auxrest (lp2ts, err)
    )
  | list_nil () => ()
) // end of [auxrest]
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
          val () = p3t := p3at_err (loc0, s2e)
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
val lp3ts = auxcheck (lp2ts, ls2es, err)
val () = auxrest (lp2ts, err)
//
in
//
lp3ts
//
end // end of [labp2atlst_trdn]

(* ****** ****** *)

implement
p2at_trdn_rec
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
  val- P2Trec (knd, npf, lp2ts) = p2t0.p2at_node
  val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
in
//
case+ s2e0.s2exp_node of
| S2Etyrec (knd1, npf1, ls2es) => let
    val isbox = (knd > 0)
    val isbox1 = tyreckind_is_box (knd1)
    val () = if (isbox != isbox1) then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the tuple/record pattern is "
      val () = if isbox then prerr "boxed but it is assigned a flat/unboxed type."
      val () = if ~isbox then prerr "flat/unboxed but it is assigned a boxed type."
      val () = prerr_newline ()
      val () = the_trans3errlst_add (T3E_p2at_trdn_rec (p2t0, s2e0))
    } // end of [val]
    val err =
      $SOL.pfarity_equal_solve (loc0, npf, npf1)
    // end of [val]
    val () = if (err > 0) then {
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trdn_rec (p2t0, s2e0))
    } // end of [val]
    var err: int = 0
    val lp3ts = labp2atlst_trdn (loc0, lp2ts, ls2es, err)
    val () = if (err > 0) then {
      val () = the_trans3errlst_add (T3E_p2at_trdn_rec (p2t0, s2e0))
    } // end of [val]
  in
    p3at_rec (loc0, s2e0, knd, npf, lp3ts)
  end // end of [S2Etyrec]
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the tuple/record pattern is ill-typed.";
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_p2at_trdn_rec (p2t0, s2e0))
  in
    p3at_err (loc0, s2e0)
  end // end of [_]
//
end // end of [p2at_trdn_rec]

(* ****** ****** *)

implement
p2at_trdn_lst
  (p2t0, s2e0) = let
  val loc0 = p2t0.p2at_loc
  val- P2Tlst (lin, p2ts) = p2t0.p2at_node
  val s2e0 = s2exp_opnexi_and_add (loc0, s2e0)
in
//
case+ s2e0.s2exp_node of
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_list0_t0ype_type, s2e_fun
  ) => let
    val- list_cons (s2e_arg, _) = s2es_arg
    val p3ts = p2atlst_trdn_elt (p2ts, s2e_arg)
  in
    p3at_lst (loc0, s2e0, lin, p3ts)
  end
| S2Eapp (s2e_fun, s2es_arg)
    when s2cstref_equ_exp (
    the_list_t0ype_int_type, s2e_fun
  ) => let
    val- list_cons (s2e1_arg, s2es_arg) = s2es_arg
    val- list_cons (s2e2_arg, s2es_arg) = s2es_arg
    val p3ts = p2atlst_trdn_elt (p2ts, s2e1_arg)
    val n = list_length (p3ts)
    val s2e_ind = s2exp_int (n)
    val () = trans3_env_hypadd_eqeq (loc0, s2e_ind, s2e2_arg)
  in
    p3at_lst (loc0, s2e0, lin, p3ts)
  end
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the list pattern is ill-typed.";
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_p2at_trdn_lst (p2t0, s2e0))
  in
    p3at_err (loc0, s2e0)
  end // end of [_]
//
end // end of [p2at_trdn_lst]

(* ****** ****** *)

implement
p2at_trdn_exist
  (p2t0, s2e0) = let
//
val loc0 = p2t0.p2at_loc
//
fun auxbind (
  sub: &stasub
, s2vs1: s2varlst, s2vs2: s2varlst
, err: &int
) :<cloref1> void = let
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
      var s2e2: s2exp = s2exp_var (s2v2)
      val ismat = s2rt_ltmat1 (s2t2, s2t1)
      val () = if ~ismat then {
        val () = prerr_error3_loc (loc0)
        val () = prerr ": the static variable [";
        val () = prerr_s2var (s2v1)
        val () = prerr "] is given the sort ["
        val () = prerr_s2rt (s2t1)
        val () = prerr "] but it is bound to a term of the sort ["
        val () = prerr_s2rt (s2t2)
        val () = prerr "]."
        val () = prerr_newline ()
        val () = err := err + 1
        val () = s2e2 := s2exp_err (s2t1)
      } // end of [val]
      val () = stasub_add (sub, s2v1, s2e2)
    in
      auxbind (sub, s2vs1, s2vs2, err)
    end
  | list_nil () => let
      val s2t1 = s2var_get_srt (s2v1)
      val () = prerr_error3_loc (loc0)
      val () = prerr ": there is no binding for the static variable [";
      val () = prerr_s2var (s2v1)
      val () = prerr "]"
      val () = prerr_newline ()
      val () = err := err + 1
      val s2e2 = s2exp_err (s2t1)
      val () = stasub_add (sub, s2v1, s2e2)
    in
      auxbind (sub, s2vs1, s2vs2, err)
    end
  ) // end of [list_cons]
| list_nil () => (
  case+ s2vs2 of
  | list_cons _ => auxbind (sub, s2vs1, s2vs2, err) | list_nil () => ()
  ) // end of [list_nil]
//
end // end of [auxbind]
//
val- P2Texist (s2vs, p2t) = p2t0.p2at_node
//
in
//
case+ s2e0.s2exp_node of
| S2Eexi (s2vs2, s2ps2, s2e) => let
    var sub: stasub = stasub_make_nil ()
    var err: int = 0
    val () = auxbind (sub, s2vs, s2vs2, err)
    val () = if (err > 0) then {
      val () = the_trans3errlst_add (T3E_p2at_trdn_exist (p2t0, s2e0))
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
    val () = the_trans3errlst_add (T3E_p2at_trdn_exist (p2t0, s2e0))
  in
    p3at_err (loc0, s2e0)
  end (* end of [_] *)
//
end // end of [p2at_trdn_exist]

(* ****** ****** *)
////
fn p2at_exist_tr_dn
  (p2t0: p2at, s2vs0: s2varlst, p2t: p2at, s2e0: s2exp): p3at = let
  val loc0 = p2t0.p2at_loc
  val s2e0 = s2exp_whnf s2e0
in
  case+ s2e0.s2exp_node of
  | S2Eexi (s2vs, s2ps, s2e) => let
      val sub = aux (s2vs, s2vs0) where {
        fun aux (s2vs: s2varlst, s2vs0: s2varlst):<cloref1> stasub_t =
          case+ (s2vs, s2vs0) of
          | (list_cons (s2v, s2vs), list_cons (s2v0, s2vs0)) => let
              val s2t = s2var_get_srt s2v and s2t0 = s2var_get_srt s2v0
            in
              if s2t0 <= s2t then
                stasub_add (aux (s2vs, s2vs0), s2v, s2exp_var s2v0)
              else begin
                prerr loc0; prerr "error(3)";
                prerr ": the bound variable [";
                prerr s2v;
                prerr "] is given the sort [";
                prerr s2t;
                prerr "] but it is expected to be of the sort [";
                prerr s2t0;
                prerr "].";
                prerr_newline ();
                $Err.abort {stasub_t} ()
              end // end of [if]
            end (* end of [list_cons, list_cons] *)
          | (list_nil (), list_nil ()) => stasub_nil
          | (list_cons _, list_nil _) => begin
              prerr loc0; prerr "error(3)";
              prerr ": the existentially quantified pattern needs less bound variables.";
              prerr_newline ();
              $Err.abort {stasub_t} ()
            end (* end of [list_cons, list_nil] *)
          | (list_nil _, list_cons _) => begin
              prerr loc0; prerr "error(3)";
              prerr ": the existentially quantified pattern needs more bound variables.";
              prerr_newline ();
              $Err.abort {stasub_t} ()
            end (* end of [list_nil, list_cons] *)
      } // end of [where]
      val () = trans3_env_add_svarlst s2vs0
      val () = trans3_env_hypo_add_proplst (loc0, s2explst_subst (sub, s2ps))
      val p3t = p2at_tr_dn (p2t, s2exp_subst (sub, s2e))
    in
      p3at_exist (loc0, s2e0, s2vs0, p3t)
    end (* end of [S2Eexist] *)
  | _ => begin
      prerr loc0; prerr ": error(3)";
      prerr ": the pattern is given the type ["; prerr s2e0;
      prerr "] but an existentially quantified type is expected.";
      prerr_newline ();
      $Err.abort {p3at} ()
    end (* end of [_] *)
end // end of [p2at_exist_tr_dn]


(* ****** ****** *)

(* end of [pats_trans3_pat.dats] *)
