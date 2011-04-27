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
staload FIL = "pats_filename.sats"
staload PAR = "pats_parsing.sats"

(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_lexing.sats"
staload "pats_fixity.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

staload "pats_trans1.sats"
staload "pats_trans1_env.sats"
staload "pats_e1xpval.sats"

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
s0tacon_tr (d) = let
  val arg = a0msrtlst_tr (d.s0tacon_arg)
  val def = s0expopt_tr (d.s0tacon_def)
in
  s1tacon_make (d.s0tacon_loc, d.s0tacon_sym, arg, def)
end // end of [s0tacon_tr]

(* ****** ****** *)

implement
s0tavar_tr (d) = let
  val srt = s0rt_tr (d.s0tavar_srt)
in
  s1tavar_make (d.s0tavar_loc, d.s0tavar_sym, srt)
end // end of [s0tavar_tr]

(* ****** ****** *)

implement
s0rtdef_tr (d) = let
  val s1te = s0rtext_tr d.s0rtdef_def
(*
  val () = print "s0rtdef_tr: s1te = "
  val () = fprint_s1rtext (stdout_ref, s1te)
  val () = print_newline ()
*)
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
d0atdec_tr (d) = let
  val arg = a0msrtlst_tr (d.d0atdec_arg)
  val con = l2l (list_map_fun (d.d0atdec_con, d0atcon_tr))
in
  d1atdec_make (
    d.d0atdec_loc, d.d0atdec_fil, d.d0atdec_sym, arg, con
  ) // end of [d1atdec_make]
end // end of [d0atdec_tr]

(* ****** ****** *)

implement
e0xndec_tr (d) = let
  val qua = d.e0xndec_qua
  val qua = q0marglst_tr (qua)
  var npf0: int = 0
  val arg = (case+ d.e0xndec_arg of
    | Some s0e => let
        val s1e = s0exp_tr s0e in
        case+ s1e.s1exp_node of
        | S1Elist (npf, s1es) => (npf0 := npf; s1es)
        | _ => cons (s1e, nil ())
      end // end of [Some]
    | None () => nil ()
  ) : s1explst // end of [val]
in
  e1xndec_make (
    d.e0xndec_loc, d.e0xndec_fil, d.e0xndec_sym, qua, npf0, arg
  ) // end of [e1xndec_make]
end // end of [e0xndec_tr]

(* ****** ****** *)

fun token_get_dcstkind
  (tok: token): dcstkind = (
  case+ tok.token_node of
  | T_FUN (fk) => (
      case+ fk of
      | FK_fun () => DCKfun ()
      | FK_prfun () => DCKprfun ()
      | FK_praxi () => DCKpraxi ()
      | FK_castfn () => DCKcastfn ()
      | FK_fn () => DCKfun ()
      | FK_fnstar () => DCKfun ()
      | FK_prfn () => DCKprfun ()
    ) // end of [T_FUN]
  | T_VAL (vk) => (
      case+ vk of
      | VK_val () => DCKval ()
      | VK_prval () => DCKprval ()
      | VK_val_pos () => DCKval ()
      | VK_val_neg () => DCKval ()
    ) // end of [T_VAL]
  | _ => let
      val () = assertloc (false) in DCKfun ()
    end // end of [_]
) // end of [token_get_dcstkind]

(* ****** ****** *)

fn m0acdef_tr
  (d: m0acdef): m1acdef = let
  val def = d0exp_tr d.m0acdef_def
in
  m1acdef_make (
    d.m0acdef_loc, d.m0acdef_sym, d.m0acdef_arg, def
  ) // end of [m1acdef_make]
end // end of [m0acdef_tr]

(* ****** ****** *)

fn v0aldec_tr
  (d: v0aldec): v1aldec = let
  val p1t = p0at_tr d.v0aldec_pat
  val d1e = d0exp_tr d.v0aldec_def
(*
  val () = begin
    print "v0aldec_tr: d1e = "; print d1e; print_newline ()
  end // end of [val]
*)
  val ann = witht0ype_tr (d.v0aldec_ann)
in
  v1aldec_make (d.v0aldec_loc, p1t, d1e, ann)
end // end of [v0aldec_tr]

(* ****** ****** *)

fn f0undec_tr (
  isprf: bool, isrec: bool, d: f0undec
 ) : f1undec = let
  val loc = d.f0undec_loc
  val effopt = d.f0undec_eff
  val (fcopt, efcopt) = (
    case+ effopt of
    | Some eff => (fcopt, Some efc) where {
        val (fcopt, lin, prf, efc) = e0fftaglst_tr (eff)
      } // end of [Some]
    | None () => (None(*fcopt*), Some efc) where {
        val efc = (
          if isprf then EFFCSTnil () else EFFCSTall ()
        ) : effcst // end of [val]
      } // end of [None]
  ) : @(funcloopt, effcstopt)
//
  val d1e_def =
    d0exp_lams_dyn_tr (
      LAMKINDifix
    , None (*locopt*)
    , fcopt, 0 (*lin*)
    , d.f0undec_arg, d.f0undec_res, efcopt
    , d.f0undec_def
    ) // end of [d0exp_lams_dyn_tr]
  // end of [val]
//
  val () = if isrec then
    termination_metric_check (loc, d1exp_is_metric d1e_def, efcopt)
  // end of [if] // end of [val]
//
  val ann = witht0ype_tr (d.f0undec_ann)
//
in
  f1undec_make (loc, d.f0undec_sym, d.f0undec_sym_loc, d1e_def, ann)
end // end of [f0undec_tr]

fun f0undeclst_tr (
  fk: funkind, ds: f0undeclst
) : f1undeclst = let
  val isprf = funkind_is_proof fk
  and isrec = funkind_is_recursive fk
in
  case+ ds of
  | d :: ds => begin
      f0undec_tr (isprf, isrec, d) :: f0undeclst_tr (fk, ds)
    end (* end of [::] *)
  | nil () => nil ()
end // end of [f0undeclst_tr]

(* ****** ****** *)

fn v0ardec_tr
  (d: v0ardec): v1ardec = let
  val loc = d.v0ardec_loc
  val knd = d.v0ardec_knd
  val os1e = s0expopt_tr d.v0ardec_typ
  val wth = d.v0ardec_wth // i0deopt
  val od1e = d0expopt_tr d.v0ardec_ini
in
  v1ardec_make (
    loc, knd, d.v0ardec_sym, d.v0ardec_sym_loc, os1e, wth, od1e
  ) // end of [v1ardec_make]
end // end of [v0ardec_tr]

(* ****** ****** *)

fn i0mpdec_tr
  (d: i0mpdec): i1mpdec = let
  val loc = d.i0mpdec_loc
  val qid = d.i0mpdec_qid
  val tmparg = l2l (list_map_fun (qid.impqi0de_arg, t0mpmarg_tr))
  val def =
    d0exp_lams_dyn_tr (
      LAMKINDifix
    , None(*locopt*), None(*fcopt*), 0(*lin*)
    , d.i0mpdec_arg, d.i0mpdec_res, None(*efcopt*)
    , d.i0mpdec_def
    ) // end of [d0exp_lams_dyn_tr]
  // end of [val]
in
  i1mpdec_make (d.i0mpdec_loc, qid, tmparg, def)
end // end of [i0mpdec_tr]

(* ****** ****** *)

fn i0nclude_tr (
  loc0: location, stadyn: int, path: string
) : d1eclist = d1cs where {
//
  val filopt = $FIL.filenameopt_make_relative (path)
//
  val fil = (case+ filopt of
    | ~Some_vt filename => filename
    | ~None_vt () => let
        val () = prerr_loc_error1 (loc0)
        val () = prerr ": the file ["
        val () = prerr path;
        val () = prerr "] is not available for inclusion"
        val () = prerr_newline ()
      in
        $ERR.abort {filename} ()
      end // end of [None_vt]
  ) : filename // end of [val]
//
  val (pfpush | isexi) = $FIL.the_filenamelst_push_check (fil)
//
  val () = if isexi then {
    val () = $LOC.prerr_location (loc0)
    val () = prerr (": error(0)")
    val () = prerr (": including the file [");
    val () = $FIL.prerr_filename (fil)
    val () = prerr ("] generates the following looping trace:\n")
    val () = $FIL.fprint_the_filenamelst (stderr_ref)
    val () = $ERR.abort {void} ()
  } // end of [val]
//  
(*
  val () = begin
    print "Including ["; print fullname; print "] starts."; print_newline ()
  end // end of [val]
*)
  val d0cs = $PAR.parse_from_filename_toplevel (stadyn, fil)
  val d1cs = d0eclist_tr (d0cs)
(*
  val () = begin
    print "Including ["; print fullname; print "] finishes."; print_newline ()
  end // end of [val]
*)
  val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
} // end of [i0nclude_tr]

(* ****** ****** *)

%{^
//
static
ats_bool_type
atsopt_string_suffix_is_dats
  (ats_ptr_type s0) {
  char *s = strrchr (s0, '.') ;
  if (!s) return ats_false_bool ;
  if (strcmp (s, ".dats") != 0) return ats_false_bool ;
  return ats_true_bool ;
} // end of [atsopt_string_suffix_is_dats]
//
%} // end of [%{^]

extern fun string_suffix_is_dats
  (s: string): bool = "atsopt_string_suffix_is_dats"
// end of [string_suffix_is_dats]

fn s0taload_tr_load (
  fil: filename, loadflag: &int >> int
) : d1eclist = let
  val path = $FIL.filename_get_base (fil)
  val flag = (
    if string_suffix_is_dats path then 1(*dyn*) else 0(*sta*)
  ) : int // end of [val]
  val d0cs = $PAR.parse_from_filename_toplevel (flag, fil)
//
  val (pfsave | ()) = trans1_env_save ()
  val d1cs = d0eclist_tr (d0cs)
  val () = (case+
    the_e1xpenv_find ($SYM.symbol_ATS_STALOADFLAG) of
    | ~Some_vt e1xp => let
        val v1al = e1xp_valize (e1xp) in if v1al_is_false v1al then loadflag := 0
      end // end of [Some_vt]
    | ~None_vt () => () // the default value
  ) : void // end of [val]
  val () = trans1_env_restore (pfsave | (*none*))
  val () = staload_file_insert (fil, loadflag, d1cs)
in
  d1cs
end // end of [s0taload_tr_load]

fn s0taload_tr (
  loc0: location
, idopt: symbolopt, path: string
, loadflag: &int? >> int
, filref: &filename? >> filename
) : d1eclist = let
  val () = loadflag := 1 // HX: this is for ATS_STALOADFLAG
//
  val filopt = $FIL.filenameopt_make_relative (path)
  val fil = (case+ filopt of
    | ~Some_vt filename => filename
    | ~None_vt () => let
        val () = prerr_loc_error1 (loc0)
        val () = prerr ": the file ["
        val () = prerr path;
        val () = prerr "] is not available for static loading"
        val () = prerr_newline ()
      in
        $ERR.abort {filename} ()
      end // end of [None_vt]
  ) : filename // end of [val]
  val () = filref := fil
//
  val flagd1csopt = staload_file_search (fil)
in
//
case+ flagd1csopt of
| ~Some_vt (flagd1cs) => let
(*
    val () = {
      val () = print "The file ["
      val () = print_filename (fil)
      val () = print " is already loaded."
      val () = print_newlint ()
    ) // end of [val]
*)
    val () = loadflag := flagd1cs.0
  in
    flagd1cs.1
  end // end of [Some_vt]
| ~None_vt () => s0taload_tr_load (fil, loadflag)
//
end // end of [s0taload_tr]

(* ****** ****** *)

fn d0ynload_tr (
  loc0: location, path: string
) : filename = fil where {
  val filopt = $FIL.filenameopt_make_relative (path)
  val fil = (case+ filopt of
    | ~Some_vt filename => filename
    | ~None_vt () => let
        val () = prerr_loc_error1 (loc0)
        val () = prerr ": the file ["
        val () = prerr path;
        val () = prerr "] is not available for dynamic loading"
        val () = prerr_newline ()
      in
        $ERR.abort {filename} ()
      end // end of [None_vt]
  ) : filename // end of [val]
} // end of [d0ynload_tr]

(* ****** ****** *)

fn guad0ecl_tr (
  knd: srpifkind, gd: guad0ecl
) : d1eclist = let
  fun loop (
    knd: srpifkind, gdn: guad0ecl_node
  ) : d1eclist =
    case+ gdn of
    | GD0Cone (e0xp, d0cs) => let
        val v1al = e1xp_valize_if (knd, e0xp_tr e0xp) in
        if v1al_is_true (v1al) then d0eclist_tr d0cs else list_nil ()
      end // end of [GD0Cone]
    | GD0Ctwo (
        e0xp, d0cs_then, d0cs_else
      ) => let
        val v1al = e1xp_valize_if (knd, e0xp_tr e0xp)
      in
        if v1al_is_true v1al then
          d0eclist_tr d0cs_then else d0eclist_tr d0cs_else
        // end of [if]
      end // end of [GD0Ctwo]
    | GD0Ccons (
        e0xp, d0cs_then, knd_elif, gdn_else
      ) => let
        val v1al = e1xp_valize_if (knd, e0xp_tr e0xp)
      in
        if v1al_is_true v1al then
          d0eclist_tr d0cs_then else loop (knd_elif, gdn_else)
        // end of [if]
      end // end of [GD0Ccons]
  // end of [loop]
in
  loop (knd, gd.guad0ecl_node)
end // end of [guad0ec_tr]

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
| D0Csymintr (ids) => d1ecl_symintr (loc0, ids)
| D0Csymelim (ids) => d1ecl_symelim (loc0, ids)
| D0Coverload (id, qid) => d1ecl_overload (loc0, id, qid)
//
| D0Ce0xpdef (id, def) => let
    val def = (case+ def of
      | Some e0xp => e0xp_tr e0xp | None () => e1xp_none (loc0)
    ) : e1xp // end of [val]
    val () = the_e1xpenv_add (id, def)
  in
//
// HX-2011-04-27: [def] should not be normalized
    d1ecl_e1xpdef (loc0, id, def) // as dynamic-binding is assumed.
  end // end of [D0Ce0xpdef]
| D0Ce0xpundef (id) => let
    val def = e1xp_undef (loc0)
    val () = the_e1xpenv_add (id, def)
  in
    d1ecl_e1xpundef (loc0, id)
  end // end of [D0Ce0xpundef]
//
| D0Ce0xpact (knd, e0xp) => let
    val e1xp = e0xp_tr (e0xp)
(*
    val () = begin
      print "d0ec_tr: D0Ce0xpact: e1xp = "; print e1xp; print_newline ()
    end // end of [val]
*)
    val v1al = e1xp_valize (e1xp)
    val () = (case+ knd of
      | E0XPACTassert () =>
          do_e0xpact_assert (e0xp.e0xp_loc, v1al)
      | E0XPACTerror () => do_e0xpact_error (e0xp.e0xp_loc, v1al)
      | E0XPACTprint () => do_e0xpact_prerr v1al
    ) : void // end of [val]
  in
    d1ecl_none (loc0)
  end // end of [D0Ce0xpact]
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
| D0Cstacons (knd, d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, s0tacon_tr))
  in
    d1ecl_stacons (loc0, knd, d1cs)
  end // end of [D0Cstacons]
| D0Cstavars (d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, s0tavar_tr))
  in
    d1ecl_stavars (loc0, d1cs)
  end // end of [D0Cstavars]
//
| D0Csexpdefs (knd, d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, s0expdef_tr))
  in
    d1ecl_sexpdefs (loc0, knd, d1cs)
  end // end of [D0Csexpdefs]
| D0Csaspdec (d0c) => d1ecl_saspdec (loc0, s0aspdec_tr d0c)
//
| D0Cdatdecs (knd, d0cs1, d0cs2) => let
    val d1cs1 = l2l (list_map_fun (d0cs1, d0atdec_tr))
    val d1cs2 = l2l (list_map_fun (d0cs2, s0expdef_tr))
  in
    d1ecl_datdecs (loc0, knd, d1cs1, d1cs2)
  end // end of [D0Cdatdecs]
| D0Cexndecs (d0cs) =>
    d1ecl_exndecs (loc0, l2l (list_map_fun (d0cs, e0xndec_tr)))
  (* end of [D0Cexndecs] *)
//
| D0Cclassdec (id, sup) => let
    val sup = s0expopt_tr (sup) in d1ecl_classdec (loc0, id, sup)
  end // end of [D0Cclassdec]
//
| D0Cdcstdecs (
    tok, qarg, d0cs
  ) => let
    val dck = token_get_dcstkind (tok)
    val isfun = dcstkind_is_fun (dck)
    and isprf = dcstkind_is_proof (dck)
    val qarg = q0marglst_tr (qarg)
    val d1cs = d0cstdeclst_tr (isfun, isprf, d0cs)
  in
    d1ecl_dcstdecs (loc0, dck, qarg, d1cs)
  end // end of [D0Cdcstdecs]
//
| D0Cextype (knd, name, def) => let
    val def = s0exp_tr (def) in d1ecl_extype (loc0, knd, name, def)
  end
| D0Cextcode (knd, pos, code) => d1ecl_extcode (loc0, knd, pos, code)
//
| D0Cmacdefs (knd, isrec, d0cs) => let
    // knd: 0/1 => short/long
    val d1cs = l2l (list_map_fun (d0cs, m0acdef_tr))
  in
    d1ecl_macdefs (loc0, knd, isrec, d1cs)
  end // end of [D0Cmacdefs]
//
| D0Cvaldecs (knd, isrec, d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, v0aldec_tr))
  in
    d1ecl_valdecs (loc0, knd, isrec, d1cs)
  end // end of [D0Cvaldecs]
| D0Cfundecs (knd, qarg, d0cs) => let
    val qarg = q0marglst_tr (qarg)
    val d1cs = f0undeclst_tr (knd, d0cs)
  in
    d1ecl_fundecs (loc0, knd, qarg, d1cs)
  end // end of [D0Cfundecs]
| D0Cvardecs (d0cs) => let
    val d1cs = l2l (list_map_fun (d0cs, v0ardec_tr))
  in
    d1ecl_vardecs (loc0, d1cs)
  end // end of [D0Cvardecs]
| D0Cimpdec (i0mparg, d0c) => let
    val i1mparg = l2l (list_map_fun (i0mparg, s0arglst_tr))
  in
    d1ecl_impdec (loc0, i1mparg, i0mpdec_tr d0c)
  end // end of [D0Cimpdec]
//
| D0Cinclude (stadyn, path) => let
    val d1cs = i0nclude_tr (loc0, stadyn, path) in d1ecl_include (loc0, d1cs)
  end // end of [D0Cinclude]
| D0Cstaload (idopt, path) => let
    var loadflag: int // unitialized
    var fil: filename // unitialized
    val d1cs = s0taload_tr (loc0, idopt, path, loadflag, fil)
  in
    d1ecl_staload (loc0, idopt, fil, loadflag, d1cs)
  end // end of [D0Cstaload]
| D0Cdynload (path) => let
    val fil = d0ynload_tr (loc0, path) in d1ecl_dynload (loc0, fil)
  end // end of [D0Cdynload]
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
//
| D0Cguadecl (knd, gd0c) => let
    val d1cs = guad0ecl_tr (knd, gd0c) in d1ecl_list (loc0, d1cs)
  end (* end of [D0Cguadecl] *)
//
(*
| _ => let
    val () = $LOC.prerr_location (loc0)
    val () = prerr ": d0ecl_tr: not implemented: d0c0 = "
    val () = fprint_d0ecl (stderr_ref, d0c0)
    val () = prerr_newline ()
    val () =  $ERR.abort ()
  in
    d1ecl_none (loc0)
  end // end of [_]
*)
//
end // end of [d0ecl_tr]

implement
d0eclist_tr (d0cs) = l2l (list_map_fun<d0ecl> (d0cs, d0ecl_tr))

(* ****** ****** *)

%{$

extern
char *atspre_string_make_substring (char*, int, int) ;

ats_bool_type
atsopt_extnam_ismac (
  ats_ptr_type ext, ats_ptr_type ext_new
) {
  int sgn ;
  char* p ; int len ; 
/*
  sgn = strncmp ((char*)ext, "#", 1) ;
  if (sgn) sgn = strncmp ((char*)ext, "mac#", 4) ;
*/
  sgn = strncmp ((char*)ext, "mac#", 4) ;
//
  if (sgn == 0) {
    p = strchr ((char*)ext, '#') ;
    len = strlen (p) ;
    *(char**)ext_new = (char*)atspre_string_make_substring(p, 1, len-1) ;
    return ats_true_bool ;
  } // end of [if]
  return ats_false_bool ;
} // end of [atsopt_extnam_ismac]

ats_bool_type
atsopt_extnam_issta (
  ats_ptr_type ext, ats_ptr_type ext_new
) {
  int sgn ;
  char* p ; int len ; 
  sgn = strncmp ((char*)ext, "sta#", 4) ;
  if (sgn == 0) {
    p = strchr ((char*)ext, '#') ;
    len = strlen (p) ;
    *(char**)ext_new = (char*)atspre_string_make_substring(p, 1, len-1) ;
    return ats_true_bool ;
  } // end of [if]
  return ats_false_bool ;
} // end of [atsopt_extnam_issta]

ats_bool_type
atsopt_extnam_isext (
  ats_ptr_type ext, ats_ptr_type ext_new
) {
  int sgn ;
  char* p ; int len ; 
  sgn = strncmp ((char*)ext, "ext#", 4) ;
  if (sgn == 0) {
    p = strchr ((char*)ext, '#') ;
    len = strlen (p) ;
    *(char**)ext_new = (char*)atspre_string_make_substring(p, 1, len-1) ;
    return ats_true_bool ;
  } // end of [if]
  return ats_false_bool ;
} // end of [atsopt_extnam_isext]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_trans1_decl.dats] *)
