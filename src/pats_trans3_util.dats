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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement
prerr_FILENAME<> () = prerr "pats_trans3_util"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"

(* ****** ****** *)

staload SYN = "./pats_syntax.sats"

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

local

fun
fshowtype_d3exp
(
  knd: int, d3e: d3exp
) : void = let
//
val out = stdout_ref
//
val loc = d3e.d3exp_loc
val s2e = d3exp_get_type (d3e)
//
val () =
(
if
knd > 0
then fprint (out, "**SHOWTYPE[UP]**")
else fprint (out, "**SHOWTYPE[DN]**")
) (* end of [val] *)
//
val () = fprint (out, "(")
val () =
  $LOC.fprint_location (out, loc)
val () = fprint (out, ")")
//
val () = fprint (out, ": ")
val () = fpprint_s2exp (out, s2e)
//
val () = fprint (out, ": ")
val () = fprint_s2rt (out, s2e.s2exp_srt)
//
val () = fprint_newline (out)
//
in
  // nothing
end // end of [fshowtype_d3exp]

in (* in-of-local *)

implement
fshowtype_d3exp_up (d3e) = fshowtype_d3exp (1, d3e)
implement
fshowtype_d3exp_dn (d3e) = fshowtype_d3exp (~1, d3e)

end // end of [local]

(* ****** ****** *)

implement
d2exp_funclo_of_d2exp
  (d2e0, fc0) =
  case+ d2e0.d2exp_node of
  | D2Eann_funclo (d2e, fc) => 
      let val () = fc0 := fc in d2e end
    // end of [D2Eann_funclo]
  | _ => d2e0
// end of [d2exp_funclo_of_d2exp]

(* ****** ****** *)

implement
d2exp_s2eff_of_d2exp
  (d2e0, s2fe0) =
  case+ d2e0.d2exp_node of
  | D2Elam_dyn _ =>
      (s2fe0 := s2eff_nil; d2e0)
  | D2Elaminit_dyn _ =>
      (s2fe0 := s2eff_nil; d2e0)
  | D2Elam_sta _ =>
      (s2fe0 := s2eff_nil; d2e0)
  | D2Eann_seff
      (d2e, s2fe) => let
      val () = s2fe0 := s2fe in d2e
    end // end of [D2Eann_seff]
  | _ => let
      val () = s2fe0 := s2eff_all in d2e0
    end // end of [_]
// end of [d2exp_s2eff_of_d2exp]

(* ****** ****** *)
//
extern
fun
d2exp_syn_type_arg_body
(
  loc0: location
, fc0: funclo, lin: int, npf: int
, p2ts_arg: p2atlst, d2e_body: d2exp
) : s2exp // end of [d2exp_syn_type_arg_body]
//
implement
d2exp_syn_type_arg_body
(
  loc0, fc0, lin, npf, p2ts_arg, d2e_body
) = let
  var fc: funclo = fc0
  val s2es = p2atlst_syn_type (p2ts_arg)
  val s2e_res = d2exp_syn_type (d2e_body)
  val d2e_body = d2exp_funclo_of_d2exp (d2e_body, fc)
  val isprf = s2exp_is_prf (s2e_res)
  val islin = (if lin > 0 then true else false): bool
  var s2fe: s2eff
  val d2e_body = d2exp_s2eff_of_d2exp (d2e_body, s2fe)
  val s2t_fun = s2rt_prf_lin_fc (loc0, isprf, islin, fc)
in
  s2exp_fun_srt (s2t_fun, fc, lin, s2fe, npf, s2es, s2e_res)
end // end of [d2exp_syn_type_arg_body]
//
(* ****** ****** *)

implement
d2exp_syn_type
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
//
val s2e0 =(
case+ d2e0.d2exp_node of
//
| D2Eint _ => s2exp_int_t0ype ()
| D2Ebool _ => s2exp_bool_t0ype ()
| D2Echar _ => s2exp_char_t0ype ()
| D2Estring _ => s2exp_string_type ()
| D2Efloat _ => s2exp_double_t0ype ()
//
| D2Ei0nt (x) => i0nt_syn_type (x)
| D2Ec0har _ => s2exp_char_t0ype ()
| D2Es0tring _ => s2exp_string_type ()
| D2Ef0loat (x) => f0loat_syn_type (x)
//
| D2Ecstsp (x) => cstsp_syn_type (d2e0, x)
//
| D2Eempty () => s2exp_void_t0ype ()
//
| D2Eextval (s2e, _(*name*)) => s2e
//
| D2Eassgn _ => s2exp_void_t0ype ()
//
| D2Elst (lin, opt, d2es) => let
    val s2e = (
      case+ opt of
      | Some s2e => s2e
      | None () => let
          val s2t = (
            if lin = 0 then s2rt_t0ype else s2rt_vt0ype
          ) : s2rt // end of [val]
        in
          s2exp_Var_make_srt (loc0, s2t)
        end // end of [None]
    ) : s2exp // end of [val]
    val n = list_length (d2es)
    val isnonlin = s2exp_is_nonlin (s2e)
  in
    if isnonlin then
      s2exp_list_t0ype_int_type (s2e, n)
    else
      s2exp_list_vt0ype_int_vtype (s2e, n)
    // end of [if]
  end // end of [D2Elst]
| D2Etup (knd, npf, d2es) => let
    val s2es = d2explst_syn_type (d2es)
  in
    s2exp_tytup (knd, npf, s2es)
  end // end of [D2Etup]
| D2Erec (knd, npf, ld2es) => let
    val ls2es = labd2explst_syn_type (ld2es)
  in
    s2exp_tyrec (knd, npf, ls2es)
  end // end of [D2Erec]
| D2Eseq (d2es) => (case+ d2es of
  | list_cons _ => let
      val d2e = list_last (d2es) in d2exp_syn_type (d2e)
    end
  | list_nil () => s2exp_void_t0ype ()
  ) // end of [D2Eseq]
//
| D2Earrpsz (opt, d2es) => let
    val s2e = (
      case+ opt of
      | Some s2e => s2e
      | None () => s2exp_Var_make_srt (loc0, s2rt_t0ype)
    ) : s2exp // end of [val]
    val n = list_length (d2es)
  in
    s2exp_arrpsz_vt0ype_int_vt0ype (s2e, n)
  end // end of [D2Earrpsz]
//
| D2Elam_dyn
  (
    lin, npf, p2ts_arg, d2e_body
  ) => let
    val fc0 = FUNCLOfun // HX: default
  in
    d2exp_syn_type_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
  end // end of [D2Elam_dyn]
//
| D2Elaminit_dyn
  (
    lin, npf, p2ts_arg, d2e_body
  ) => let
    val fc0 = FUNCLOclo(0) // HX: default
  in
    d2exp_syn_type_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
  end // end of [D2Elaminit_dyn]
//
| D2Elam_sta (s2vs, s2ps, d2e) => let
    val s2e = d2exp_syn_type (d2e) in s2exp_uni (s2vs, s2ps, s2e)
  end // end of [D2Elam_sta]
| D2Elam_met (_ref, met, d2e) => let
    val s2e = d2exp_syn_type (d2e) in s2exp_metfun (None(*stamp*), met, s2e)
  end // end of [D2Elam_met]
//
| D2Efix (knd, d2v, d2e) => d2exp_syn_type (d2e)
//
| D2Eann_type (_, s2e) => s2e
| D2Eann_seff (d2e, _) => d2exp_syn_type (d2e)
| D2Eann_funclo (d2e, _) => d2exp_syn_type (d2e)
//
| D2Eerrexp ((*void*)) => s2exp_t0ype_err ()
//
| _ => let
    val s2e =
      s2exp_Var_make_srt (loc0, s2rt_t0ype)
    // end of [val]
  in
    s2e
  end // end of [_]
) : s2exp // end of [val]
in
  s2e0
end // end of [d2exp_syn_type]

implement
d2explst_syn_type
  (xs) = l2l (list_map_fun (xs, d2exp_syn_type))
// end of [d2explst_syn_type]

implement
labd2explst_syn_type (xs) = let
  fn f (
    x: labd2exp
  ) : labs2exp = let
    val $SYN.DL0ABELED (l0, d2e) = x
  in
    SLABELED (l0.l0ab_lab, None(*none*), d2exp_syn_type d2e)
  end // end of [f]
in
  l2l (list_map_fun (xs, f))
end // end of labd2explst_syn_type]

(* ****** ****** *)

implement
d23exp_free (x) = (
//
case+ x of
| ~D23Ed2exp (d2e) => () | ~D23Ed3exp (d3e) => ()
//
) (* end of [d23exp_free] *)

implement
d23explst_free (xs) = (
//
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => (d23exp_free (x); d23explst_free (xs))
//
) (* end of [d23explst_free] *)

(* ****** ****** *)

implement
d3lablst_is_overld
  (d3ls) = (
//
case+ d3ls of
| list_nil () => false
| list_cons (d3l, d3ls) =>
  (
    case+ d3l.d3lab_overld of
    | Some _ => true | None () => d3lablst_is_overld (d3ls)
  ) (* end of [list_cons] *)
//
) (* end of [d3lablst_is_overld] *)
//
(* ****** ****** *)

local

fun
aux .<>. (
  d3e1: d3exp, s2f2: s2hnf
) : d3exp = let
//
val loc = d3e1.d3exp_loc
val s2e1 = d3e1.d3exp_type
val s2f1 = s2exp2hnf (s2e1)
val s2e1 = s2hnf2exp (s2f1)
val s2e2 = s2hnf2exp (s2f2)
//
(*
val () =
println!
  ("d3exp_trdn: aux: s2e1 = ", s2e1)
// end of [val]
val () =
println!
  ("d3exp_trdn: aux: s2e2 = ", s2e2)
// end of [val]
*)
//
val err =
  $SOL.s2hnf_tyleq_solve(loc, s2f1, s2f2)
// end of [val]
val () =
if (err != 0) then let
  val () = prerr_error3_loc (loc)
  val () = filprerr_ifdebug "d3exp_trdn"
  val () = prerr ": the dynamic expression cannot be assigned the type ["
  val () = prerr_s2exp (s2e2)
  val () = prerr "]."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
//
in
  the_trans3errlst_add(T3E_d3exp_trdn (d3e1, s2e2))
end // end of [if] // end of [val]
//
(*
val () = d3exp_set_type(d3e1, s2e2)
*)
//
in
  d3e1
end // end of [_]

in (* in of [local] *)

implement
d3exp_trdn
  (d3e1, s2e2) = let
//
val s2f2 = s2exp2hnf (s2e2)
//
in
//
case+ s2e2.s2exp_node of
| S2Erefarg
    (_, s2e2) => d3exp_trdn (d3e1, s2e2)
| _ => aux (d3e1, s2f2)
//
end (* end of [d3exp_trdn] *)

end // end of [local]

(* ****** ****** *)

implement
d3explst_trdn_arg
  (d3es, s2es) =
  case+ d3es of
  | list_cons (d3e, d3es) => (
    case+ s2es of
    | list_cons (s2e, s2es) => let
        val d3e = d3exp_trdn (d3e, s2e)
      in
        list_cons (d3e, d3explst_trdn_arg (d3es, s2es))
      end // end of [list_cons]
    | list_nil () => list_nil ()
    ) // end of [list_cons]
  | list_nil () => list_nil ()
// end of [d3explst_trdn_arg]

(* ****** ****** *)

implement
d3explst_get_ind (xs) = let
//
fun f (x: d3exp): s2exp = let
  val () = d3exp_open_and_add (x) in d3exp_get_type (x)
end // end of [d3exp_get_ind]
//
in
  l2l (list_map_fun (xs, f))
end // end of [d3explst_get_ind]

(* ****** ****** *)

(* end of [pats_trans3_util.dats] *)
