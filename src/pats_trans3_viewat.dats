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
// Start Time: May, 2012
//
(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_selab"

(* ****** ****** *)

staload LAB = "pats_label.sats"
overload = with $LAB.eq_label_label 

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

fun s2addr_get_root (
  s2l: s2exp
, s2ls: &s2lablst? >> s2lablst
) : s2exp =
  case+ s2l.s2exp_node of
  | S2Eproj (
      s2l1, _(*type*), s2ls1
    ) => (s2ls := s2ls1; s2l1)
  | _ => (s2ls := list_nil; s2l)
// end of [s2addr_get_root]

fun eq_dlablst_slablst (
  d3ls: d3lablst, s2ls: s2lablst
) : bool =
  case+ d3ls of
  | list_cons (d3l, d3ls) => (
    case+ s2ls of
    | list_cons (s2l, s2ls) => (
      case+ (
        d3l.d3lab_node, s2l
      ) of // case+
      | (D3LABlab l1, S2LABlab l2) =>
          if l1 = l2 then eq_dlablst_slablst (d3ls, s2ls) else false
      | (_, _) => false
      )
    | list_nil () => false
    ) // end of [list_cons]
  | list_nil () => (
    case+ s2ls of
    | list_cons _ => false | list_nil _ => true
    ) // end of [list_nil]
// end of [eq_dlablst_slablst]

(* ****** ****** *)

local

fun auxerr_nonatview (
  loc0: location, s2at_new: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": viewat-restoration cannot be performed"  
  val () = prerr ": proof of some atview is needed but one of the following type is given: "
  val () = (prerr "["; prerr_s2exp (s2at_new); prerr "]")
in
  the_trans3errlst_add (T3E_s2exp_set_viewat_atview (loc0, s2at_new))
end // end of [auxerr_nonatview]

fun auxerr_nonwithout (
  loc0: location, s2e_old: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": viewat-restoration cannot be performed"  
  val () = prerr ": the following type is expected to be a without-type but it is not: "
  val () = (prerr "["; prerr_s2exp (s2e_old); prerr "]")
in
  the_trans3errlst_add (T3E_s2exp_set_viewat_without (loc0, s2e_old))
end // end of [auxerr_nonwithout]

fun auxck_addreq (
  loc0: location, s2e1, d3ls, s2e2
) : void = let
  val s2e2 = s2exp_hnfize (s2e2)
  var s2ls: s2lablst // uninitialized
  val s2e2_rt = s2addr_get_root (s2e2, s2ls)
  val rooteq = s2exp_syneq (s2e1, s2e2_rt)
  val addreq = (
    if rooteq then eq_dlablst_slablst (d3ls, s2ls) else false
  ) : bool // end of [val]
in
//
if ~addreq then let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": viewat-restoration cannot be performed"  
  val () = prerr ": mismatch of bef/aft locations of atviews:\n"
  val () = (prerr "bef: ["; prerr_s2exp (s2e1); prerr "]")
  val () = prerr_newline ()
  val () = (prerr "aft: ["; prerr_s2exp (s2e2); prerr "]")
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_s2addr_viewat_addreq (loc0, s2e1, d3ls, s2e2))
end // end of [if]
//
end // end of [auxck_addreq]

in // in of [local]

implement
s2addr_set_viewat (
  loc0, s2l, d3ls, s2at_new
) = let
  val s2at_new = s2exp_hnfize (s2at_new)
in
//
case+
  s2at_new.s2exp_node of
| S2Eat (s2e1, s2e2) => let
    val s2e_old =
      s2addr_exch_type (loc0, s2l, d3ls, s2e1)
    val () =
      s2addr_set_viewat_check (loc0, s2l, d3ls, s2at_new, s2e_old, s2e1, s2e2)
    // end of [val]
  in
    // nothing
  end // end of [S2Eat]
| _ => auxerr_nonatview (loc0, s2at_new)
//
end // end of [s2addr_set_viewat]

implement
s2addr_set_viewat_check (
  loc0, s2l, d3ls, s2at_new, s2e_old, s2e_new, s2l_new
) = let
//
val () = (
  print "s2addr_set_viewat_check: s2l = "; print_s2exp (s2l); print_newline ();
  print "s2addr_set_viewat_check: s2e_old = "; print_s2exp (s2e_old); print_newline ();
  print "s2addr_set_viewat_check: s2e_new = "; print_s2exp (s2e_new); print_newline ();
) (* end of [val] *)
//
  val s2e_old = let
    val s2e_old =
      s2exp_hnfize (s2e_old) in
    case+
      s2e_old.s2exp_node of
    | S2Ewithout (s2e) => s2e
    | _ => let
        val () = auxerr_nonwithout (loc0, s2e_old)
      in
        s2exp_t0ype_err ()
      end // end of [_]
  end : s2exp // end of [val]
(*
//
// HX-2012-05-10:
// skipping the check to keep a benign loophole
//
  val () = auxck_tszeq (loc0, s2e_old, s2e_new)
*)
  val () = auxck_addreq (loc0, s2l, d3ls, s2l_new)
in
  // exitloc (1)
end // end of [s2addr_set_viewat_check]

end // end of [local]

(* ****** ****** *)

local

fun auxerr1 (
  loc0: location, d2v: d2var
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is not mutable and thus [view@] cannot be applied."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2var_nonmut (loc0, d2v))
end // end of [auxerr1]

in // in of [local]

implement
d2exp_trup_viewat
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
in
//
case+
  d2e0.d2exp_node of
| D2Evar (d2v) => let
    val opt = d2var_get_addr (d2v)
  in
    case+ opt of
    | Some (s2l) => let
        val s2e_ptr =
          d2var_get_type_some (loc0, d2v)
        val d3e_ptr =
          d3exp_ptrof_var (loc0, s2e_ptr, d2v)
        val opt = pfobj_search_atview (s2l)
      in
        case+ opt of
        | ~Some_vt (pfobj) => let
            val+ ~PFOBJ (
              d2vw, s2e_ctx, s2e_elt, s2l
            ) = pfobj // end of [val]
            val s2e_out = s2exp_without (s2e_elt)
            val s2e = s2exp_hrepl (s2e_ctx, s2e_out)
            val () = d2var_set_type (d2vw, Some (s2e))
            val s2e_at = s2exp_at (s2e_elt, s2l)
          in
            d3exp_viewat (loc0, s2e_at, d3e_ptr, list_nil(*d3ls*))
          end // end of [Some_vt]
        | ~None_vt () => let
            val s2e_at = s2exp_t0ype_err () in
            d3exp_viewat (loc0, s2e_at, d3e_ptr, list_nil(*d3ls*))
          end // end of [None]
      end // end of [Some]
    | None () => let
        val () = auxerr1 (loc0, d2v) in d3exp_err (loc0)
      end // end of [None]
  end (* end of [D2Evar] *)
//
| _ => exitloc (1)
//
end // end of [d2exp_trup_viewat]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_view.dats] *)
