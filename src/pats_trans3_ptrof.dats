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
// Start Time: May, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_ptrof"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

extern
fun
s2addr_ptrof
(
  loc0: loc_t
, s2l: s2exp, d3ls: d3lablst, s2rt: &s2exp? >> s2exp
) : s2exp // end of [s2addr_ptrof]

local

fun
auxerr_pfobj
(
  loc0: loc_t, s2l: s2exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": [addr@] operation cannot be performed"
  val () = prerr ": the proof search for view located at ["
  val () = prerr_s2exp (s2l)
  val () = prerr "] failed to turn up a result."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_pfobj_search_none (loc0, s2l))
end // end of [auxerr_pfobj]

fun auxlabs
(
  d3ls: d3lablst
) : s2lablst = (
  case+ d3ls of
  | list_cons (d3l, d3ls) => (
    case+ d3l.d3lab_node of
    | D3LABlab (lab) => let
        val s2l = S2LABlab (lab)
      in
        list_cons (s2l, auxlabs d3ls)
      end // end of [D3LABlab]
    | D3LABind (ind) => let
        val ind = d3explst_get_type (ind)
        val s2l = S2LABind (ind)
      in
        list_cons (s2l, auxlabs d3ls)      
      end // end of [D3LABind]
    ) // end of [list_ons]
  | list_nil () => list_nil ()
) // end of [auxlabs]

fun auxmain
(
  loc0: loc_t
, pfobj: pfobj
, d3ls: d3lablst
, s2rt: &s2exp? >> s2exp
) : s2exp = let
//
val+~PFOBJ
(
  d2vw, s2e_ctx, s2e_elt, s2l
) = pfobj // end of [val]
//
val () = s2rt := s2e_elt
var linrest: int = 0 and sharing: int = 0
//
val
(
  s2e_sel, s2ps
) =
s2exp_get_dlablst_linrest_sharing
(
  loc0, s2e_elt, d3ls, linrest, sharing
) // endfcall // end of [val]
//
val s2e_sel =
  s2exp_hnfize (s2e_sel)
val () =
  list_vt_free (s2ps) (*probing*)
val s2ls = auxlabs (d3ls)
//
val s2e_prj = s2exp_proj (s2l, s2e_elt, s2ls)
//
in
  s2exp_ptr_addr_type (s2e_prj)
end // end of [auxmain]

in (* in of [local] *)

implement
s2addr_ptrof
(
  loc0, s2l, d3ls, s2rt
) = let
  val opt = pfobj_search_atview (s2l)
in
//
case+ opt of
| ~Some_vt (pfobj) =>
    auxmain (loc0, pfobj, d3ls, s2rt)
| ~None_vt () => let
    val s2e_sel =
      s2exp_t0ype_err ()
    // end of [val]
    val () = s2rt := s2e_sel
    val () = auxerr_pfobj (loc0, s2l)
  in
    s2e_sel
  end // end of [None]
//
end // end of [s2addr_ptrof]

end // end of [local]

(* ****** ****** *)

local

fun
auxerr_nonptr
(
  loc0: loc_t, d3e: d3exp
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the dynamic expression is expected to be a pointer."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_nonderef (d3e))
end // end of [auxerr_nonptr]

fun
auxerr_nonmut
(
  loc0: loc_t, d2v: d2var
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is not mutable and thus [addr@] cannot be applied."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2var_nonmut (loc0, d2v))
end // end of [auxerr_nonmut]

fun
auxerr_nonlval (
  d2e0: d2exp
) : void = let
  val loc0 = d2e0.d2exp_loc
  val () = prerr_error3_loc (loc0)
  val () = prerr ": [addr@] operation cannot be performed"
  val () = prerr ": a left-value is required but a non-left-value is given."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2exp_nonlval (d2e0))
end // end of [auxerr_nonlval]

in // in of [local]

extern
fun
d2exp_trup_ptrof_varsel
  (loc0: loc_t, d2v: d2var, d2ls: d2lablst): d3exp
extern
fun
d2exp_trup_ptrof_ptrsel
  (loc0: loc_t, d2e: d2exp, d2ls: d2lablst): d3exp

implement
d2exp_trup_ptrof
  (d2e0) = let
//
fun
aux
(
  d2e0: d2exp, d2e: d2exp
) : d3exp = let
//
val loc0 = d2e0.d2exp_loc
//
in
//
case+
d2e.d2exp_node
of // case+
//
| D2Evar(d2v) => let
    val opt = d2var_get_addr (d2v)
  in
    case+ opt of
    | Some _ => let
        val s2e =
          d2var_get_type_some (loc0, d2v)
        // end of [val]
      in
        d3exp_ptrofvar (loc0, s2e, d2v)
      end // end of [Some]
    | None ((*void*)) => let
        val () =
        auxerr_nonmut (loc0, d2v) in d3exp_errexp (loc0)
      end // end of [None]
  end (* end of [D2Evar] *)
//
| D2Ederef(_(*!*), d2e) =>
    d2exp_trup_ptrof_ptrsel(loc0, d2e, list_nil)
  // end of [D2Ederef]
//
| D2Eselab(d2e, d2ls) =>
  (
  case+
  d2e.d2exp_node
  of (* case+ *)
  | D2Evar (d2v) =>
      d2exp_trup_ptrof_varsel (loc0, d2v, d2ls)
    // end of [D2Evar]
  | D2Ederef(_(*!*), d2e) =>
      d2exp_trup_ptrof_ptrsel (loc0, d2e, d2ls)
    // end of [D2Ederef]
  | _ => let
      val () = auxerr_nonlval (d2e0) in d3exp_errexp (loc0)
    end // end of [_]
  ) (* end of [D2Esel] *)
//
(*
| D2Esing (d2e) => aux (d2e0, d2e)
*)
//
| _ (*rest-of-d2exp*) => let
    val () = auxerr_nonlval (d2e0) in d3exp_errexp (loc0)
  end // end of [_]
//
end // end of [aux]
//
val-D2Eptrof (d2e) = d2e0.d2exp_node
//
in
  aux (d2e0, d2e)
end // end of [d2exp_trup_ptrof]

(* ****** ****** *)

implement
d2exp_trup_ptrof_varsel
  (loc0, d2v, d2ls) = let
  val ismut = d2var_is_mutabl (d2v)
in
//
if ismut then let
  val d3ls = d2lablst_trup (d2ls)
  val-Some (s2e_ptr) = d2var_get_type (d2v)
  val d3e_ptr = d3exp_ptrofvar (loc0, s2e_ptr, d2v)
in
//
case+ d3ls of
| list_cons _ => let
    val-Some (s2l) = d2var_get_addr (d2v)
    var s2rt: s2exp
    val s2e_prj = s2addr_ptrof (loc0, s2l, d3ls, s2rt)
  in
    d3exp_ptrofsel (loc0, s2e_prj, d3e_ptr, s2rt, d3ls)
  end // end of [list_cons]
| list_nil () => d3e_ptr // end of [list_nil]
//
end else let
  val () =
    auxerr_nonmut (loc0, d2v) in d3exp_errexp (loc0)
  // end of [val]
end // end of [if]
//
end // end of [d2exp_trup_ptrof_varsel]

(* ****** ****** *)

implement
d2exp_trup_ptrof_ptrsel
  (loc0, d2e, d2ls) = let
  val d3e = d2exp_trup (d2e)
  val () = d3exp_open_and_add (d3e)
  val d3ls = d2lablst_trup (d2ls)
  val s2e = d3exp_get_type (d3e)
  val s2f = s2exp2hnf (s2e)
  val opt = un_s2exp_ptr_addr_type (s2f)
in
//
case+ opt of
| ~Some_vt (s2l) => let
    var s2rt: s2exp
    val s2e_prj = (
      case+ d3ls of
      | list_cons _ =>
          s2addr_ptrof (loc0, s2l, d3ls, s2rt)
      | list_nil () => let
          val () =
            s2rt := s2exp_void_t0ype () in s2exp_ptr_addr_type (s2l)
          // end of [val]
        end // end of [list_nil]
    ) : s2exp // end of [val]
  in
    d3exp_ptrofsel (loc0, s2e_prj, d3e, s2rt, d3ls)
  end // end of [Some_vt]
| ~None_vt () => let
    val () = auxerr_nonptr (loc0, d3e) in d3exp_errexp (loc0)
  end // end of [None_vt]
//
end // end of [d2exp_trup_ptrof_ptrset]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_ptrof.dats] *)
