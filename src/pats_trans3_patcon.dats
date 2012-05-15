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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: February, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_patcon"

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

dataviewtype patcontrup =
  PATCONTRUP of (p2atlst, s2explst(*arg*), s2exp(*res*))
(* end of [patcontrup] *)

(* ****** ****** *)
//
// HX-2012-05:
// [freeknd]: nonlin/free/preserve: ~1/1/0
//
extern
fun p2at_trup_con (p2t0: p2at): patcontrup
implement
p2at_trup_con
  (p2t0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tcon (
  freeknd, d2c, s2qs, s2e_con, npf, p2ts_arg
) = p2t0.p2at_node
//
val () = let
  fun loop (s2qs: s2qualst): void =
    case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val () = trans3_env_add_svarlst (s2q.s2qua_svs)
      in
        loop (s2qs)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [loop]
in
  loop (s2qs)
end // end of [val]
//
val () = let
  fun loop (
    loc0: location, s2qs: s2qualst
  ) : void = case+ s2qs of
    | list_cons (s2q, s2qs) => let
        val () = trans3_env_hypadd_proplst (loc0, s2q.s2qua_sps)
      in
        loop (loc0, s2qs)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [loop]
in
  loop (loc0, s2qs)
end // end of [val]
//
in
//
case+ s2e_con.s2exp_node of
| S2Efun (
    fc, lin, s2fe, npf_con, s2es_arg, s2e_res
  ) => let
    val err = $SOL.pfarity_equal_solve (loc0, npf, npf_con)
    val () = if err > 0 then {
      val () = prerr_error3_loc (loc0)
      val () = filprerr_ifdebug "p2at_trup_con"
      val () = prerr ": proof arity mismatch: the constructor ["
      val () = prerr_d2con (d2c)
      val () = prerrf ("] requires [%i] arguments.", @(npf_con))
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
      val () = the_trans3errlst_add (T3E_p2at_trup_con (p2t0))
    } // end of [val]
  in
    PATCONTRUP (p2ts_arg, s2es_arg, s2e_res)
  end // end of [S2Efun]
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "p2at_trup_con"
    val () = prerr ": the constructor pattern is ill-typed."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_p2at_trup_con (p2t0))
    val s2es_arg =
      aux (p2ts_arg) where {
      fun aux (
        p2ts: p2atlst
      ) : s2explst =
        case+ p2ts of
        | list_cons (_, p2ts) => let
            val s2e = s2exp_t0ype_err () in list_cons (s2e, aux p2ts)
          end // end of [list_cons]
        | list_nil () => list_nil ()
      // end of [aux]
    } // end of [val]
    val s2e_res = s2exp_t0ype_err ()
  in
    PATCONTRUP (p2ts_arg, s2es_arg, s2e_res)
  end // end of [_]
//
end // end of [p2at_trup_con]

(* ****** ****** *)

fun p3at_is_varpat
  (p3t: p3at): bool = (
  case+ p3t.p3at_node of
  | P3Tvar (refknd, _) => refknd > 0
  | P3Tas (refknd, _, _) => refknd > 0
  | _ => false
) // end of [p3at_is_varpat]

extern
fun p3at_con_check (
  p3t0: p3at, d2c: d2con, p3ts_arg: p3atlst
) : void // end of [p3at_con_check]

local

fun auxerr
  (p3t: p3at): void = let
  val loc = p3t.p3at_loc
  val () = prerr_error3_loc (loc)
  val () = prerr ": the var-pattern is not allowed."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_p2at_con_varpat (p3t))
end // end of [auxerr]

fun auxmain (
  p3ts: p3atlst
) : int = (
  case+ p3ts of
  | list_cons
      (p3t, p3ts) => let
      val isvar = p3at_is_varpat (p3t)
    in
      if isvar then let
        val () = auxerr (p3t) in auxmain (p3ts) + 1
      end else auxmain (p3ts)
    end // end of [list_cons]
  | list_nil () => 0
) // end of [auxmain]

in // in of [local]

implement
p3at_con_check (
  p3t0, d2c, p3ts_arg
) = let
  val nerr = auxmain (p3ts_arg)
in
  // nothing
end // end of [p3at_con_check]

end // end of [local]

(* ****** ****** *)
//
// HX-2012-05:
// [freeknd]: nonlin/free/preserve: ~1/1/0
//
extern
fun p3at_lincon_update (
  p3t0: p3at, freeknd: int, d2c: d2con, p3ts_arg: p3atlst
) : void // end of [p3at_lincon_update]

local

fun auxvar (
  loc0: location, d2v: d2var, s2f: s2hnf
) : d2var = let
(*
  val () = (
    print ": auxvar: d2v = "; print_d2var (d2v); print_newline ()
  ) // end of [val]
*)
  val s2e = s2hnf2exp (s2f)
//
  val sym = d2var_get_sym (d2v)
  val s2v_addr = s2var_make_id_srt (sym, s2rt_addr)
  val () = trans3_env_add_svar (s2v_addr) // adding svar
  val s2e_addr = s2exp_var (s2v_addr)
  val () = d2var_set_addr (d2v, Some s2e_addr)
  val s2e_ptr = s2exp_ptr_addr_type (s2e_addr)
  val () = d2var_set_type (d2v, Some (s2e_ptr))
(*
  val () = let
    val s2p = s2exp_agtz (s2e_addr) in trans3_env_hypadd_prop (loc0, s2p)
  end // end of [val]
*)
  val d2vw = d2var_ptr_viewat_make_none (d2v)
  val () = d2var_set_view (d2v, Some d2vw) // [d2v] is mutable
//
  val s2at = s2exp_at (s2e, s2e_addr)
  val () = d2var_set_mastype (d2vw, Some (s2at))
  val s2e_opn = s2hnf_opnexi_and_add (loc0, s2f)
  val s2at_opn = s2exp_at (s2e_opn, s2e_addr)
  val () = d2var_set_type (d2vw, Some (s2at_opn))
in
  d2vw
end // end of [auxvar]

fun auxpat1
  (p3t: p3at): d2var = let
in
//
case+ p3t.p3at_node of
| P3Tany (d2v) => let
    val opt = p3at_get_type_left (p3t)
    val opt = (
      case+ opt of
      | Some _ => opt
      | None () => Some (s2exp_topize_1 (p3t.p3at_type))
    ) : s2expopt // end of [val]
    val () = d2var_set_type (d2v, opt)
  in
    d2v
  end (* end of [P3Tany] *)
| P3Tvar (
    refknd, d2v
  ) when refknd > 0 => d2v
| P3Tas (
    refknd, d2v, p3t_as
  ) when refknd > 0 => d2v
| _ => let
    val d2v =
      d2var_make_any (p3t.p3at_loc)
    val () = p3at_set_dvaropt (p3t, Some (d2v))
    val opt = p3at_get_type_left (p3t)
    val opt = (
      case+ opt of
      | Some _ => opt
      | None () => Some (s2exp_topize_1 (p3t.p3at_type))
    ) : s2expopt // end of [val]
    val () = d2var_set_type (d2v, opt)
  in
    d2v
  end (* end of [_] *)
//
end // end of [auxpat1]

fun auxpat2 (
  p3t: p3at
) : s2exp(*addr*) = let
  val loc = p3t.p3at_loc
  val d2v = auxpat1 (p3t)
  val- Some (s2e) = d2var_get_type (d2v)
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf2exp (s2f)
  val d2vw = auxvar (loc, d2v, s2f) // turning [d2v] into a mutable d2var
  val- Some (s2l) = d2var_get_addr (d2v)
in
  s2l
end (* end of [auxpat2] *)

fun auxpat3 (
  p3t: p3at
) : void = let
  val loc = p3t.p3at_loc
  val opt = p3at_get_type_left (p3t)
in
//
case+ opt of
| Some (s2e) => let
    val () = prerr_error3_loc (loc)
    val () = prerr ": a value matching this pattern may not be freed";
    val () = prerr ": it contains a linear component of the following type [";
    val () = prerr_s2exp (s2e)
    val () = prerr "]."
    val () = prerr_newline ()
  in
    the_trans3errlst_add (T3E_p2at_lincon_update (p3t))
  end (* end of [if] *)
| None () => ()
end // end of [auxpat3]

in // in of [local]

implement
p3at_lincon_update
  (p3t0, freeknd, d2c, p3ts_arg) = let
(*
val () = begin
(*
  print "p3at_lincon_update: p3t0 = "; print_p3at p3t0; print_newline ();
*)
  print "p3at_lincon_update: freeknd = "; print_int freeknd; print_newline ();
  print "p3at_lincon_update: d2c = "; print_d2con d2c; print_newline ();
end // end of [val]
*)
in
//
if freeknd = 0 then let
//
val s2es =
  list_map_fun<p3at> (p3ts_arg, auxpat2)
val s2dcp = s2exp_datconptr (d2c, (l2l)s2es)
//
in
  p3at_set_type_left (p3t0, Some (s2dcp))
end else (
  list_app_fun<p3at> (p3ts_arg, auxpat3)
) (* end of [if] *)
//
end // end of [p3at_lincon_update]

end // end of [local]

(* ****** ****** *)

local

fun auxerr_arity (
  p2t0: p2at, serr: int
) : void = let
  val loc0 = p2t0.p2at_loc
  val () = prerr_error3_loc (loc0)
  val () = prerr ": arity mismatch"
  val () = if serr < 0 then prerr ": more arguments are expected."
  val () = if serr > 0 then prerr ": fewer arguments are expected."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_p2at_trdn_con_arity (p2t0, serr))
end // end of [val]

in // in of [local]

implement
p2at_trdn_con
  (p2t0, s2f0) = let
//
val loc0 = p2t0.p2at_loc
val- P2Tcon (
  freeknd, d2c, s2qs, s2e_con, npf, p2ts_arg
) = p2t0.p2at_node
//
val s2c = d2con_get_scst (d2c)
val s2e = s2hnf_opnexi_and_add (loc0, s2f0)
val s2f = s2exp2hnf (s2e)
val s2e = s2hnf2exp (s2f)
val s2f_head = s2hnf_get_head (s2f)
val s2e_head = s2hnf2exp (s2f_head)
//
var flag: int = ~1 (*error*)
var s2es_arg_alt: s2explst = list_nil ()
val () = (
case+ s2e_head.s2exp_node of
| S2Ecst (s2c1) =>
    if eq_s2cst_s2cst (s2c, s2c1) then flag := 0
| S2Edatcontyp (d2c1, s2es) =>
    if eq_d2con_d2con (d2c, d2c1) then (flag := 1; s2es_arg_alt := s2es)
| _ => ()
) // end of [val]
val () = if (flag < 0) then {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the constructor pattern cannot be assigned the type ["
  val () = prerr_s2exp (s2e)
  val () = prerr "]."
  val () = prerr_newline ()
  val s2e0 = s2hnf2exp (s2f0)
  val () = the_trans3errlst_add (T3E_p2at_trdn (p2t0, s2e0))
} (* end of [if] // end of [val] *)
//
val flag_vwtp = (
  if flag > 0 then 1 else d2con_get_vwtp (d2c)
) : int // end of [val]
var freeknd: int = freeknd
val () = if freeknd = 0 then
  (if flag_vwtp > 0 then () else freeknd := ~1)
// end of [if] // end of [val]
//
val p3t0 = (case+ 0 of
| _ when flag = 0 => let
    val ~PATCONTRUP
      (p2ts, s2es_arg, s2e_res) = p2at_trup_con (p2t0)
    val () = $SOL.s2exp_hypequal_solve (loc0, s2e_res, s2e)
    var serr: int = 0
    val p3ts_arg = p2atlst_trdn (loc0, p2ts_arg, s2es_arg, serr)
    val () = if serr != 0 then auxerr_arity (p2t0, serr)
    val p3t0 = p3at_con (loc0, s2e, freeknd, d2c, npf, p3ts_arg)
    val () = if freeknd != 0 then
      p3at_con_check (p3t0, d2c, p3ts_arg)
    val () = if freeknd >= 0 then
      p3at_lincon_update (p3t0, freeknd, d2c, p3ts_arg)
  in
    p3t0
  end // end of [flag=0]
| _ when flag > 0 => let
    var serr: int = 0
    val p3ts_arg =
      p2atlst_trdn (loc0, p2ts_arg, s2es_arg_alt, serr)
    val () = if serr != 0 then auxerr_arity (p2t0, serr)
    val p3t0 = p3at_con (loc0, s2e, freeknd, d2c, npf, p3ts_arg)
    val () = p3at_lincon_update (p3t0, freeknd, d2c, p3ts_arg)
  in
    p3t0
  end // end of [flag>0]
| _ => let
    val () = assertloc (false) in p3at_err (loc0, s2e)
  end // end of [val]
) : p3at // end of [val]
//
in
  p3t0
end // end of [p2at_trdn_con]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_patcon.dats] *)
