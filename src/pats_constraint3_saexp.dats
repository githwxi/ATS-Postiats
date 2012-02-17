
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
implement prerr_FILENAME<> () = prerr "pats_constraint3_saexp"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

implement
s3aexp_make_s2cst_s2explst
  (fds, s2c, s2es, s2cs) = let
//
fun auxerr (
  s2c: s2cst
) : void = {
  val () = prerr_interror ()
  val () = prerr ": s3aexp_make_s2cst_s2explst: s2c = "
  val () = prerr_s2cst (s2c)
  val () = prerr_newline ()
} // end of [auxerr]
//
in
//
case+ 0 of
| _ when
    s2cstref_equ_cst (
    the_add_addr_int, s2c
  ) => let
    val- list_cons (s2e1, s2es) = s2es
    val- list_cons (s2e2, s2es) = s2es
    val ans1 = s3aexp_make_s2exp (fds, s2e1, s2cs)
  in
    case+ ans1 of
    | ~Some_vt (s3ae1) => let
        val ans2 = s3iexp_make_s2exp (fds, s2e2, s2cs)
      in
        case+ ans2 of
        | ~Some_vt (s3ie2) => Some_vt (s3aexp_padd (s3ae1, s3ie2))
        | ~None_vt () => None_vt ()
      end // end of [Some_vt]
    | ~None_vt () => None_vt ()
  end // end of [padd]
| _ when
    s2cstref_equ_cst (
    the_sub_addr_int, s2c
  ) => let
    val- list_cons (s2e1, s2es) = s2es
    val- list_cons (s2e2, s2es) = s2es
    val ans1 = s3aexp_make_s2exp (fds, s2e1, s2cs)
  in
    case+ ans1 of
    | ~Some_vt (s3ae1) => let
        val ans2 = s3iexp_make_s2exp (fds, s2e2, s2cs)
      in
        case+ ans2 of
        | ~Some_vt (s3ie2) => Some_vt (s3aexp_psub (s3ae1, s3ie2))
        | ~None_vt () => None_vt ()
      end // end of [Some_vt]
    | ~None_vt () => None_vt ()
  end // end of [padd]
| _ => let
    val s2v = s2cfdefmap_replace_none (fds, s2rt_addr, s2c, s2es, s2cs)
  in
    Some_vt (s3aexp_var s2v)
  end // end of [_]
(*
//
// a function cannot be handled
//
| _ => let
    val () = begin
      print "s3aexp_make_s2cst_s2explst: s2c = "; print s2c; print_newline ();
      print "s3aexp_make_s2cst_s2explst: s2es = "; print s2es; print_newline ();
    end // end of [val]
  in
    None_vt ()
  end // end of [_]
*)
//
end // end of [s3aexp_make_s2cst_s2explst]

(* ****** ****** *)

implement
s3aexp_make_s2exp
  (fds, s2e0, s2cs) = let
//
  val s2f0 = s2exp2hnf (s2e0)
  val s2e0 = s2hnf2exp (s2f0)
//
(*
  val () = begin
    print "s3aexp_make_s2exp: s2e0 = "; print_s2exp (s2e0); print_newline ()
  end // end of [val]
*)
in
//
case+ s2e0.s2exp_node of
| S2Evar s2v => Some_vt (s3aexp_var s2v)
| S2Ecst s2c => (case+ s2c of
  | _ when s2cstref_equ_cst (the_null_addr, s2c) => Some_vt (s3aexp_null)
  | _ => let
      val () = s2cs := s2cstset_vt_add (s2cs, s2c) in Some_vt (s3aexp_cst s2c)
    end // end of [_]
  ) // end of [S2Ecst]
| S2Eapp (s2e1, s2es2) => (
  case+ s2e1.s2exp_node of
  | S2Ecst s2c1 => s3aexp_make_s2cst_s2explst (fds, s2c1, s2es2, s2cs)
  | _ => None_vt ()
  ) // end of [S2Eapp]
| _ => let // an expression that cannot be handled
    val () = begin
      prerr "warning(3): s3aexp_make_s2exp: s2e0 = "; prerr_s2exp (s2e0); prerr_newline ();
    end // end of [val]
  in
    None_vt ()
  end // end of [S2Evar]
//
end // end of [s3aexp_make_s2exp]

(* ****** ****** *)

(* end of [pats_constraint3_saexp.dats] *)
