(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: April, 2011
//
(* ****** ****** *)

staload ERR = "pats_error.sats"
staload SYM = "pats_symbol.sats"
overload print with $SYM.print_symbol
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_fixity.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

staload "pats_trans1.sats"
staload "pats_trans1_env.sats"

(* ****** ****** *)

#define nil list_nil
#define cons list_cons
#define :: list_cons

#define l2l list_of_list_vt

(* ****** ****** *)

fn prerr_loc_error1
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(1)"
) // end of [prerr_loc_error1]
fn prerr_interror (): void = prerr "INTERROR(pats_trans1_staexp)"

(* ****** ****** *)

local

fn prec_tr_errmsg_fxty
  (opr: i0de): prec = let
  val () = prerr_loc_error1 (opr.i0de_loc)
  val () = prerr ": the operator ["
  val () = $SYM.prerr_symbol (opr.i0de_sym)
  val () = prerr "] is given no fixity";
  val () = prerr_newline ()
in
  $ERR.abort ()
end // end of [prec_tr_errmsg]

fn prec_tr_errmsg_adj
  (opr: i0de): prec = let
  val () = prerr_loc_error1 (opr.i0de_loc)
  val () = prerr ": the operator for adjusting precedence can only be [+] or [-]."
  val () = prerr_newline ()
in
  $ERR.abort ()
end // end of [prec_tr_errmsg]

fn p0rec_tr
  (p0: p0rec): prec = let
//
  fun precfnd .<>.
    (id: i0de): prec = let
    val fxtyopt = the_fxtyenv_find id.i0de_sym
  in
    case+ fxtyopt of
    | ~Some_vt fxty => let
(*
        val () = begin
          print "p0rec_tr: Some: id = ";
          $Sym.print_symbol_code id.i0de_sym; print_newline ()
        end // end of [val]
*)
        val precopt = fxty_get_prec (fxty)
      in
        case+ precopt of
        | ~Some_vt prec => prec | ~None_vt () => prec_tr_errmsg_fxty (id)
      end // end of [Some_vt]
    | ~None_vt () => prec_tr_errmsg_fxty (id)
  end // end of [precfnd]
//
(*
  val () = print ("p0rec_tr: p0 = ")
  val () = fprint_p0rec (stdout_ref, p0)
  val () = print_newline ()
*)
//
in
  case+ p0 of
  | P0RECint int => prec_make_int (int)
  | P0RECi0de id => precfnd id
  | P0RECi0de_adj (id, opr, int) => let
      val sym = opr.i0de_sym
    in
      case+ opr of
      | _ when sym = $SYM.symbol_ADD => precedence_inc (precfnd id, int)
      | _ when sym = $SYM.symbol_SUB => precedence_dec (precfnd id, int)
      | _ => prec_tr_errmsg_adj (opr)
    end // end of [P0RECi0de_adj]
end // end of [p0rec_tr]

fn f0xty_tr
  (f0xty: f0xty): fxty = case+ f0xty of
  | F0XTYinf (p0, a) =>
      let val p = p0rec_tr p0 in fxty_inf (p, a) end
  | F0XTYpre p0 => let val p = p0rec_tr p0 in fxty_pre p end
  | F0XTYpos p0 => let val p = p0rec_tr p0 in fxty_pos p end
// end of [f0xty_tr]

in

implement
d0ecl_fixity_tr (f0xty, ids) = let
  fun loop (fxty: fxty, ids: i0delst): void =
    case+ ids of
    | list_cons (id, ids) => let
(*
        val sym =  id.i0de_sym
        val stamp = $SYM.symbol_get_stamp (sym)
        val () = (
          println! ("d0ecl_fixity_tr: loop: id = ", sym);
          println! ("d0ecl_fixity_tr: loop: id = ", stamp)
        ) // end of [val]
*)
(*
        val () = (
          print "the_fxtyenv_add(bef): \n"; fprint_the_fxtyenv (stdout_ref)
        ) // end of [val]
*)
        val () = the_fxtyenv_add (id.i0de_sym, fxty)
(*
        val () = begin
          print "the_fxtyenv_add(aft): \n"; fprint_the_fxtyenv (stdout_ref)
        end // end of [val]
*)
      in
        loop (fxty, ids)
      end
    | list_nil () => ()
in
  loop (f0xty_tr f0xty, ids)
end // end of [d0ecl_fixity_tr]

implement
d0ecl_nonfix_tr (ids) = let
  fun loop (ids: i0delst): void = case+ ids of
    | list_cons (id, ids) => begin
        the_fxtyenv_add (id.i0de_sym, fxty_non); loop ids
      end // end of [cons]
    | list_nil () => () // end of [list_nil]
  // end of [loop]
in
  loop (ids)
end // end of [d0ecl_nonfix_tr]

end // end of [local]

(* ****** ****** *)

implement
s0tacst_tr (d) = let
  val arg = a0msrtlst_tr (d.s0tacst_arg)
  val res: s1rt = s0rt_tr (d.s0tacst_res)
in
  s1tacst_make (d.s0tacst_loc, d.s0tacst_sym, arg, res)
end // end of [s0tacst_tr]

(* ****** ****** *)

implement
s0rtdef_tr (d) = let
  val s1te = s0rtext_tr d.s0rtdef_def
// (*
  val () = print "s0rtdef_tr: s1te = "
  val () = fprint_s1rtext (stdout_ref, s1te)
  val () = print_newline ()
// *)
in
  s1rtdef_make (d.s0rtdef_loc, d.s0rtdef_sym, s1te)
end // end of [s0rtdef_tr]

(* ****** ****** *)

implement
s0expdef_tr (d) = let
  val loc = d.s0expdef_loc
  val arg = s0marglst_tr (d.s0expdef_arg)
  val id = d.s0expdef_sym
  val res = s0rtopt_tr (d.s0expdef_res)
  val def = s0exp_tr (d.s0expdef_def)
(*
  val () = begin
    print "s0expdef_tr: def = "; print def; print_newline ()
  end // end of [val]
*)
in
  s1expdef_make (loc, id, arg, res, def)
end // end of [s0expdef_tr]

(* ****** ****** *)

implement
s0aspdec_tr (d) = let
  val arg =
    s0marglst_tr (d.s0aspdec_arg)
  // end of [val]
  val res = s0rtopt_tr (d.s0aspdec_res)
  val def = s0exp_tr d.s0aspdec_def
in
  s1aspdec_make (d.s0aspdec_loc, d.s0aspdec_qid, arg, res, def)
end // end of [s0aspdec_tr]

(* ****** ****** *)

implement
d0ecl_tr (d0c0) = let
  val loc0 = d0c0.d0ecl_loc
in
//
case+ d0c0.d0ecl_node of
| D0Cfixity (f0xty, ids) => (
    d0ecl_fixity_tr (f0xty, ids); d1ecl_none (loc0)
  ) // end of [D0Cfixity]
| D0Cnonfix ids => let
    val () = d0ecl_nonfix_tr (ids) in d1ecl_none (loc0)
  end // end of [D0Cnonfix]
//
| D0Cdatsrts (d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, d0atsrtdec_tr))
  in
    d1ecl_datsrts (loc0, d1cs)
  end // end of [D0Cdatsrts]
| D0Csrtdefs (d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, s0rtdef_tr))
  in
    d1ecl_srtdefs (loc0, d1cs)
  end
//
| D0Cstacsts (d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, s0tacst_tr))
  in
    d1ecl_stacsts (loc0, d1cs)
  end // end of [D0Cstacsts]
//
| D0Csexpdefs (knd, d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, s0expdef_tr))
  in
    d1ecl_sexpdefs (loc0, knd, d1cs)
  end // end of [D0Csexpdefs]
| D0Csaspdec (d0c) => d1ecl_saspdec (loc0, s0aspdec_tr d0c)
//
| D0Clocal (
    d0cs_head, d0cs_body
  ) => let
    val (pflev | ()) = trans1_level_inc ()
    val (pfenv1 | ()) = trans1_env_push ()
    val d1cs_head = d0eclist_tr (d0cs_head)
    val () = trans1_level_dec (pflev | (*none*))
    val (pfenv2 | ()) = trans1_env_push ((*none*))
    val d1cs_body = d0eclist_tr (d0cs_body)
    val () = trans1_env_localjoin (pfenv1, pfenv2 | (*none*))
  in
    d1ecl_local (d0c0.d0ecl_loc, d1cs_head, d1cs_body)
  end // end of [D0Clocal]
| _ => d1ecl_none (loc0)
//
end // end of [d0ecl_tr]

implement
d0eclist_tr (d0cs) = l2l (list_map_fun<d0ecl> (d0cs, d0ecl_tr))

(* ****** ****** *)

(* end of [pats_trans1_decl.dats] *)
