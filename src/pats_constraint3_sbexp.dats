
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
// Start Time: February, 2012
//
(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_constraint3_sbexp"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

local

fun synlt_s2hnf_s2hnf (
  s2f1: s2hnf, s2f2: s2hnf
) : bool = let
  val s2e2 = s2hnf2exp s2f2
// (*
  val () = begin
    print "synlt_s2hnf_s2hnf: s2f1 = "; print_s2hnf (s2f1); print_newline ();
    print "synlt_synlt_s2hnf: s2f2 = "; print_s2hnf (s2f2); print_newline ();
  end // end of [val]
// *)
in
  case+ s2e2.s2exp_node of
  | S2Eapp (_, s2es2) => synlte_s2hnf_s2explst (s2f1, s2es2)
  | _ => false
end // end pf [s2exp_synlt]

and synlte_s2hnf_s2hnf
  (s2f1: s2hnf, s2f2: s2hnf): bool =
  s2hnf_syneq (s2f1, s2f2) orelse synlt_s2hnf_s2hnf (s2f1, s2f2)
(* end of [synlte_s2hnf_s2hnf] *)

//
// HX-2012-02:
// [s2f1] <= at least one of [s2es2]
//
and synlte_s2hnf_s2explst
  (s2f1: s2hnf, s2es2: s2explst): bool =
  case+ s2es2 of
  | list_cons
      (s2e2, s2es2) => let
      val s2f2 = s2exp2hnf (s2e2)
    in
      if synlte_s2hnf_s2hnf (s2f1, s2f2)
        then true else synlte_s2hnf_s2explst (s2f1, s2es2)
      // end of [if]
    end // end of [list_cons]
  | list_nil () => false
// end of [synlte_s2hnf_s2explst]

in // in of [local]

fun s2exp_synlt (
  s2e1: s2exp, s2e2: s2exp
) : bool = let
  val s2f1 = s2exp2hnf (s2e1) and s2f2 = s2exp2hnf (s2e2)
in
  synlt_s2hnf_s2hnf (s2f1, s2f2)
end // end of [s2exp_synlt]

fun s2exp_synlte (
  s2e1: s2exp, s2e2: s2exp
) : bool = let
  val s2f1 = s2exp2hnf (s2e1) and s2f2 = s2exp2hnf (s2e2)
in
  synlte_s2hnf_s2hnf (s2f1, s2f2)
end // end of [s2exp_synlt]

end // end of [local]

(* ****** ****** *)

fun s2exp_metlt_reduce (
  met: s2explst, met_bound: s2explst
) : s2exp = let
//
fun auxlt (
  isint: bool
, s2e1: s2exp, s2e2: s2exp
, lt: &int(0) >> int
) : s2exp =
  if isint then
    s2exp_intlt (s2e1, s2e2)
  else let
    val islt = s2exp_synlt (s2e1, s2e2)
    val () = (if islt then lt := 1 else lt := ~1): void
  in
    s2exp_bool (islt)
  end // end of [if]
// end of [auxlt]
//
fun auxlte (
  isint: bool
, s2e1: s2exp, s2e2: s2exp
, lte: &int(0) >> int
) : s2exp =
  if isint then
    s2exp_intlte (s2e1, s2e2)
  else let
    val islte = s2exp_synlte (s2e1, s2e2)
    val () = (if islte then lte := 1 else lte := ~1): void
  in
    s2exp_bool (islte)
  end // end of [if]
//
fun auxlst (
  s2es1: s2explst, s2es2: s2explst
) : s2exp = let
in
//
case+ s2es1 of
| list_cons
    (s2e1, s2es1) => let
    var lt: int = 0 and lte: int = 0
  in
    case+ s2es2 of
    | list_cons
        (s2e2, s2es2) => let
        val isint = s2rt_is_int (s2e1.s2exp_srt)
        val s2p_lt = auxlt (isint, s2e1, s2e2, lt)
      in
        case+ lt of
        | _ when lt > 0 => s2p_lt (*true*)
        | _ (* lt <= 0 *) => let
            val s2p_lte = auxlte (isint, s2e1, s2e2, lte)
          in
            if lt = 0 then let
              val s2p_rest = auxlst (s2es1, s2es2)
            in
              s2exp_badd (s2p_lt, s2exp_bmul (s2p_lte, s2p_rest))
            end else ( // lt < 0 // HX: lte != 0
              if lte >= 0 then auxlst (s2es1, s2es2) else s2p_lte (*false*)
            ) // end of [if]
          end // end of [lt <= 0]
        // end of [case]
      end // end of [list_cons]
    | list_nil () => s2exp_bool (true)
  end (* end of [list_cons] *)
| list_nil () => s2exp_bool (false)
end // end of [auxlst]
//
in
  auxlst (met, met_bound)
end // end of [s2exp_metlt_reduce]

(* ****** ****** *)

local

fun auxeq (
  fds: &s2cfdefmap
, s2e1: s2exp, s2e2: s2exp
, s2cs: &s2cstset_vt
) : s3bexpopt_vt = let
  val s2t1 = s2e1.s2exp_srt
in
//
case+ 0 of
| _ => (
    if s2exp_syneq (s2e1, s2e2)
      then Some_vt (s3bexp_true) else None_vt ()
    // end of [if]
  ) // end of [_]
//
end // end of [auxeq]

fun auxbind (
  loc0: location
, fds: &s2cfdefmap
, s2v1: s2var, s2e2: s2exp
, s2cs: &s2cstset_vt
) : s3bexpopt_vt = let
(*
  val () = begin
    print "auxbind: s2v1 = "; print_s2var (s2v1); print_newline ();
    print "auxbind: s2e2 = "; print_s2exp (s2e2); print_newline ();
  end // end of [val]
*)
  val s2e1 = s2exp_var (s2v1)
  val os3be = auxeq (fds, s2e1, s2e2, s2cs)
  val () = trans3_env_hypadd_bind (loc0, s2v1, s2e2)
in
  os3be
end // end of [aux_bind]

in // in of [local]

implement
s3bexp_make_s2exp
  (fds, s2e0, s2cs) = let
  val s2f0 = s2exp2hnf (s2e0)
  val s2e0 = s2hnf2exp (s2f0)
(*
  val () = begin
    print "s3bexp_make_s2exp: s2e0 = "; print_s2exp (s2e0); print_newline ()
  end // end of [val]
*)
in
//
case+ s2e0.s2exp_node of
| S2Evar s2v => let
    val s3be = s3bexp_var (s2v) in Some_vt (s3be)
  end // end of [S2Evar]
| S2Ecst s2c => (
  case+ s2c of
  | _ when
      s2cstref_equ_cst (
      the_true_bool, s2c
    ) => Some_vt (s3bexp_true)
  | _ when
      s2cstref_equ_cst (
      the_false_bool, s2c
    ) => Some_vt (s3bexp_false)
  | _ => let
      val () = s2cs := s2cstset_vt_add (s2cs, s2c)
    in
      Some_vt (s3bexp_cst s2c)
    end (* end of [_] *)
  ) // end of [S2Ecst]
| S2Eapp
    (s2e1, s2es2) => (
  case+ s2e1.s2exp_node of
  | S2Ecst s2c1 =>
      s3bexp_make_s2cst_s2explst (fds, s2c1, s2es2, s2cs)
    // end of [S2Ecst]
  | _ => None_vt ()
  ) // end of [S2Eapp]
| S2Eeqeq (s2e1, s2e2) => auxeq (fds, s2e1, s2e2, s2cs)
| S2Emetlt
    (met, met_bound) => let
    val s2e_met =
      s2exp_metlt_reduce (met, met_bound)
    // end of [val]
  in
    s3bexp_make_s2exp (fds, s2e_met, s2cs)
  end // end of [S3Emetlt]
| _ => let // an expression that cannot be handled
    val () = begin
      prerr "warning(3): s3bexp_make_s2exp: s2e0 = "; prerr_s2exp (s2e0); prerr_newline ();
    end // end of [val]
  in
    None_vt ()
  end // end of [_]
//
end // end of [s3bexp_make_s2exp]

implement
s3bexp_make_h3ypo
  (fds, h3p, s2cs) = (
  case+ h3p.h3ypo_node of
  | H3YPOprop s2p => s3bexp_make_s2exp (fds, s2p, s2cs)
  | H3YPObind (s2v1, s2e2) => auxbind (h3p.h3ypo_loc, fds, s2v1, s2e2, s2cs)
  | H3YPOeqeq (s2e1, s2e2) => auxeq (fds, s2e1, s2e2, s2cs)
) // end of [s3bexp_make_h3ypo]

end // end of [local]

(* ****** ****** *)

(* end of [pats_constraint3_sbexp.dats] *)
