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

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

extern
fun v2aldeclst_tr
  (knd: valkind, d2cs: v2aldeclst): v3aldeclst
// end of [v2aldeclst_tr]

(* ****** ****** *)

extern
fun f2undec_tr (d2c: f2undec): d3exp
extern
fun f2undeclst_tr (
  knd: funkind, decarg: s2qualst, d2cs: f2undeclst
) : f3undeclst // end of [f2undeclst_tr]

(* ****** ****** *)

implement
d2ecl_tr (d2c0) = let
//
val loc0 = d2c0.d2ecl_loc
//
val d3c0 = (
case+ d2c0.d2ecl_node of
//
| D2Cnone () => d3ecl_none (loc0)
| D2Clist (d2cs) => let
    val d3cs = d2eclist_tr (d2cs) in d3ecl_list (loc0, d3cs)
  end // end of [D2Clist]
//
| D2Csymintr _ => d3ecl_none (loc0)
| D2Csymelim _ => d3ecl_none (loc0)
| D2Coverload (id, _) => d3ecl_none (loc0)
//
| D2Cdatdec (knd, s2cs) => let
  in
    d3ecl_datdec (loc0, knd, s2cs)
  end // end of [D2Cdatdec]
//
| D2Cdcstdec (knd, d2cs) => let
  in
    d3ecl_dcstdec (loc0, knd, d2cs)
  end // end of [D2Cdcstdec]
//
| D2Cfundecs (knd, s2qs, d2cs) => let
  val d3cs = f2undeclst_tr (knd, s2qs, d2cs)
in
  d3ecl_fundecs (loc0, knd, s2qs, d3cs)
end // end of [D2Cfundecs]
(*
| D2Cvaldecs (knd, d2cs) => let
    val d3cs = v2aldeclst_tr (knd, d2cs) in d3ecl_valdecs (loc0, knd, d3cs)
  end // end of [D2Cvaldecs]
*)
//
| _ => let
    val () = (
      print_location loc0; print_newline ()
    )
    val () = (
      print "d2ecl_tr: d2c0 = "; print_d2ecl (d2c0); print_newline ()
    ) // end of [val]
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
  (d2cs) = l2l (list_map_fun (d2cs, d2ecl_tr))
// end of [d2eclist_tr]

(* ****** ****** *)

implement
f2undec_tr (d2c0) = let
  val d2v_loc = d2c0.f2undec_loc
  val d2v_fun = d2c0.f2undec_var
  val d2v_decarg = d2var_get_decarg (d2v_fun)
  val d2e_def = d2c0.f2undec_def
//
  val opt = d2c0.f2undec_ann
  val d3e_def = (
    case+ opt of
    | Some s2e_ann => let
// (*
        val () = (
          print "f2undec_tr: s2e_ann = "; print_s2exp (s2e_ann); print_newline ();
          print "f2undec_tr: d2e_def = "; print_d2exp (d2e_def); print_newline ();
        ) // end of [val]
// *)
      in
        d2exp_trdn (d2e_def, s2e_ann)
      end // end of [Some]
    | None () => d2exp_trup (d2e_def)
  ) : d3exp // end of [val]
//
in
  d3e_def
end // end of [f2undec_tr]

implement
f2undeclst_tr
  (knd, decarg, d2cs) = let
//
val isrec = funkind_is_recursive (knd)
//
fun aux_ini (
  d2cs: f2undeclst, d2vs_fun: d2varlst
) : void = let
in
//
case+ d2cs of
| list_cons
    (d2c, d2cs) => let
    val d2v_fun = d2c.f2undec_var
    val d2e_def = d2c.f2undec_def
(*
    val () = d2exp_metfn_load (d2e_def, d2vs_fun)
*)
    val s2e_fun = (case+ d2c.f2undec_ann of
      | Some s2e_ann => s2e_ann | None () => d2exp_syn_type (d2e_def)
    ) : s2exp // end of [val]
// (*
    val () = (
      print "f2undeclst_tr: aux_ini: d2v_fun = "; print_d2var (d2v_fun); print_newline ();
      print "f2undeclst_tr: aux_ini: s2e_fun = "; print_s2exp (s2e_fun); print_newline ();
    ) // end of [val]
// *)
    val opt = Some (s2e_fun)
    val () = d2var_set_type (d2v_fun, opt)
    val () = d2var_set_mastype (d2v_fun, opt)
  in
    aux_ini (d2cs, d2vs_fun)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [aux_ini]
//
fn aux_fin {n:nat} (
  d2cs: list (f2undec, n), d3es: list (d3exp, n)
) : f3undeclst = let
  fn f (
    d2c: f2undec, d3e: d3exp
  ) : f3undec = let
    val d2v_fun = d2c.f2undec_var
    val s2e_fun = d3e.d3exp_type // s2hnf
//
// HX-2012-01-22: it is unnecessary if recursive
//
    val () = {
      val opt = Some (s2e_fun)
      val () = d2var_set_type (d2v_fun, opt)
      val () = d2var_set_mastype (d2v_fun, opt)
    } // end of [val]
  in
    f3undec_make (d2c.f2undec_loc, d2v_fun, d3e)
  end // end of [f]
  val d3cs = list_map2_fun (d2cs, d3es, f)
in
  (l2l)d3cs
end // end of [aux_fin]
//
val () = if isrec then let
  typedef a = f2undec and b = d2var
  val d2vs_fun =
    list_map_fun<a><b> (d2cs, lam (d2c) =<1> d2c.f2undec_var)
  // end of [val]
  val () = aux_ini (d2cs, $UN.castvwtp1 {d2varlst} (d2vs_fun))
  val () = list_vt_free (d2vs_fun)
in
  // nothing
end // end of [val]
//
val d3es = list_map_fun (d2cs, f2undec_tr)
val d3cs = aux_fin (d2cs, $UN.castvwtp1 (d3es))
val () = list_vt_free (d3es)
//
in
  d3cs
end // end of [f2undeclst_tr]

(* ****** ****** *)

implement
d2eclist_tr_errck
  (d2cs) = d3cs where {
  val d3cs = d2eclist_tr (d2cs)
  val () = the_trans3errlst_finalize ()
} // end of [d2eclist_tr_errck]

(* ****** ****** *)

(* end of [pats_trans3_decl.dats] *)
