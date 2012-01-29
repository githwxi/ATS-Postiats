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

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
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
  | P2Tbool _ => s2exp_bool_t0ype () // bool0
  | P2Tint _ => s2exp_int_t0ype () // int0
  | P2Tchar _ => s2exp_char_t0ype () // char0
  | P2Tstring _ => s2exp_string_type () // string0
  | P2Tfloat _ => s2exp_double_t0ype () // double
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
    | LP2Tnorm (l, p2t) => let
        val s2e = p2at_syn_type (p2t)
        val ls2e = SLABELED (l, None(*name*), s2e)
      in
        list_cons (ls2e, aux_labp2atlst (lp2ts))
      end // end of [LP2Tnorm]
    | LP2Tomit () => list_nil () // HX: should an error be reported?
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
end (* end of [p2atlst_arg_tr_dn] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

fun p2at_trdn_var .<>.
  (p2t0: p2at, s2e0: s2exp): p3at = let
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

fun p2at_trdn_ann .<>.
  (p2t0: p2at, s2e0: s2exp): p3at = let
  val loc0 = p2t0.p2at_loc
  val- P2Tann (p2t, s2e_ann) = p2t0.p2at_node
  val err = $SOL.s2exp_tyleq_solve (loc0, s2e0, s2e_ann)
  val () = if (err != 0) then let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "p2at_trdn_ann"
    val () = prerr ": the pattern cannot be given the ascribed type."
    val () = prerr_newline ()
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
  case+ p2t0.p2at_node of
  | P2Tvar (knd, d2v) =>
      p2at_trdn_var (p2t0, s2e0)
  | P2Tann _ => p2at_trdn_ann (p2t0, s2e0)
  | _ => let
      val () = assertloc (false) in exit (1)
    end // end of [_]
end // end of [p2at_trdn]

(* ****** ****** *)

(* end of [pats_trans3_pat.dats] *)
