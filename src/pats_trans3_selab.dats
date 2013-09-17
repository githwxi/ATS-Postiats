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
// Start Time: November, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_selab"

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label
macdef prerr_label = $LAB.prerr_label

staload
LOC = "./pats_location.sats"
stadef location = $LOC.location

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

#define l2l list_of_list_vt

(* ****** ****** *)

local

fun aux (
  d2l: d2lab
) : d3lab = let
  val loc = d2l.d2lab_loc
  val opt = d2l.d2lab_over
in
//
case+ d2l.d2lab_node of
| D2LABlab (lab) => d3lab_lab (loc, lab, opt)
| D2LABind (ind) => let
    val ind = d2explst_trup (ind) in d3lab_ind (loc, ind)
  end // end of [D2LABind]
//
end // end of [aux]

in (* in of [local] *)

implement
d2lablst_trup (d2ls) = let
  val d3ls = list_map_fun (d2ls, aux) in (l2l)d3ls
end // end of [d2lablst_trup]

end // end of [local]

(* ****** ****** *)

local

fun arrbndck .<>.
(
  d3e1: d3exp, s2i2: s2exp
) : s2explst_vt = let
//
fun auxerr
  (d3e: d3exp): void = let
  val loc = d3e.d3exp_loc
  val s2e = d3exp_get_type (d3e)
  val () = prerr_error3_loc (loc)
  val () = prerr ": the type of the array index is not "
  val () = prerr "a generic (signed or unsigned) integer type: ["
  val () = prerr_s2exp (s2e)
  val () = prerr "]."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_arrind (d3e))
end (* end of [auxerr] *)
//
val () =
  d3exp_open_and_add (d3e1)
val s2e1 = d3exp_get_type (d3e1)
val s2f1 = s2exp2hnf (s2e1)
val opt = un_s2exp_g1int_index_t0ype (s2f1)
//
in
//
case+ opt of
| ~Some_vt (s2i1) => let
    val s2p1 = s2exp_igtez (s2i1)
    val s2p2 = s2exp_intlt (s2i1, s2i2)
  in
    list_vt_pair (s2p1, s2p2)
  end // end of [Some_vt]
| ~None_vt () => let
    val opt = un_s2exp_g1uint_index_t0ype (s2f1)
  in
    case+ opt of
    | ~Some_vt (s2i1) => let
        val s2p = s2exp_intlt (s2i1, s2i2) in list_vt_sing (s2p)
      end // end of [Some_vt]
    | ~None_vt () => let
        val () = auxerr (d3e1) in list_vt_nil ()
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [arrbndck]

in (* in of [local] *)

fun arrbndlst_check (
  loc0: location, ind: d3explst, dim: s2explst
) : s2explst_vt = let
//
fun auxerr (
  loc0: location
, dim: s2explst, ind: d3explst, sgn: int
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the label is expected to contain "
  val () = if sgn < 0 then prerr "more array indexes."
  val () = if sgn > 0 then prerr "fewer array indexes."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_arrdim (loc0, dim, ind))
end // end of [auxerr] 
//
val nind = list_length (ind)
val ndim = list_length (dim)
//
fun
auxcheck (
  d3es: d3explst
, s2es: s2explst
) : s2explst_vt = (
  case+ d3es of
  | list_cons
      (d3e, d3es) => let
      val-list_cons
        (s2e, s2es) = s2es // match!
      val s2ps1 = arrbndck (d3e, s2e)
      val s2ps2 = auxcheck (d3es, s2es)
    in
      list_vt_append (s2ps1, s2ps2)
    end // end of [list_cons]
  | list_nil () => list_vt_nil ()
) // end of [auxcheck]
//
val sgn = nind - ndim
//
in
//
if sgn < 0 then let
  val () = auxerr (loc0, dim, ind, sgn) in list_vt_nil ()
end else if sgn > 0 then let
  val () = auxerr (loc0, dim, ind, sgn) in list_vt_nil ()
end else auxcheck (ind, dim) // end of [if]
//
end // end of [arrbndlst_check]

end // end of [local]

(* ****** ****** *)

local

fun d3lab_is_overld
  (d3l: d3lab): bool =
(
  case+ d3l.d3lab_overld of Some _ => true | None _ => false
) // end of [d3lab_is_overld]

fun lincheck
(
  ls2es: labs2explst, linrest: &int
) : void = let
in
//
if linrest = 0 then
(
case+ ls2es of
| list_nil () => ()
| list_cons
    (ls2e, ls2es) => let
    val+SLABELED (_, _, s2e) = ls2e
    val () = if s2exp_is_lin (s2e) then linrest := linrest + 1
  in
    lincheck (ls2es, linrest)
  end // end of [list_cons]
) else () // end of [if]
//
end // end of [lincheck]

fun
labfind_lincheck
(
  l0: label, ls2es: labs2explst, linrest: &int, err: &int
) : s2exp = let
in
//
case+ ls2es of
| list_cons
    (ls2e, ls2es) => let
    val SLABELED (l, _, s2e) = ls2e
  in
    if l0 = l then let
      val () = lincheck (ls2es, linrest) in s2e
    end else let
      val () = if linrest = 0 then
      (
        if s2exp_is_lin (s2e) then linrest := linrest + 1
      ) // end of [val]
    in
      labfind_lincheck (l0, ls2es, linrest, err)
    end // end of [if]
  end // end of [list_cons]
| list_nil () => let
    val () = err := err + 1 in s2exp_t0ype_err ()
  end // end of [list_nil]
//
end // end of [labfind_lincheck]

fun
auxlab_sexp
(
  loc0: location, s2e: s2exp
, d3l: d3lab, l0: label, linrest: &int, sharing: &int
) : s2exp = let
  val s2f = s2exp2hnf (s2e)
in
  auxlab_shnf (loc0, s2f, d3l, l0, linrest, sharing)
end // and [auxlab_sexp]

and auxlab_shnf (
  loc0: location, s2f: s2hnf
, d3l: d3lab, l0: label, linrest: &int, sharing: &int
) : s2exp = let
  val s2e = s2hnf2exp (s2f)
in
//
case+
  s2e.s2exp_node of
//
| S2Etyrec
    (knd, npf, ls2es) => let
    var err: int = 0
    val s2e1 =
      labfind_lincheck (l0, ls2es, linrest, err)
    val () =
      if tyreckind_is_box (knd) then sharing := sharing + 1
    val () = if (err > 0) then let
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the record-type ["
      val () = prerr_s2exp (s2e)
      val () = prerr "] is expected to contain the label ["
      val () = prerr_label (l0)
      val () = prerr "] but it does not."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_s2exp_selab_labnot (loc0, s2e, l0))
    end // end of [val]
  in
    s2e1
  end // end of [S2Etyrec]
//
| S2Eexi _ => let
    val s2f = s2exp2hnf (s2e)
    val s2e = s2hnf_opn1exi_and_add (loc0, s2f)
  in
    auxlab_sexp (loc0, s2e, d3l, l0, linrest, sharing)
  end // end of [S2Eexi]
//
| _ when
    d3lab_is_overld (d3l) => let
    val-Some (d2s) = d3l.d3lab_overld
    val _fun = d2exp_top (loc0)
    val d2e = d2exp_top2 (loc0, s2e)
    val d2a = D2EXPARGdyn (~1(*npf*), loc0, list_sing (d2e))
    val _arg = list_sing (d2a)
    val d3e_sel = d2exp_trup_applst_sym (_fun, d2s, _arg)
// (*
    val () =
    println! (
      "s2exp_get_dlablst_linrest_sharing: auxlab_shnf: d3e_sel = ", d3e_sel
    ) (* end of [val] *)
// *)
  in
    d3exp_get_type (d3e_sel)
  end // end of [_ when ...]
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = prerrln! (": the type [", s2e, "] is expected to be a tyrec (record-type).")
    val () = the_trans3errlst_add (T3E_s2exp_selab_tyrec (loc0, s2e))
  in
    s2exp_t0ype_err ()
  end // end of [_]
//
end // end of [auxlab_shnf]

fun auxind
(
  loc0: location, s2e: s2exp, ind: d3explst
) : (
  s2exp(*elt*), s2explst_vt(*array-bounds-checking*)
) = let
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf2exp (s2f)
in
//
case+
  s2e.s2exp_node of
//
| S2Etyarr
  (
    s2e_elt, s2es_dim
  ) => let
    val s2ps =
      arrbndlst_check (loc0, ind, s2es_dim)
    // end of [val]
  in
    (s2e_elt, s2ps)
  end // end of [S2Etyarr]
//
| S2Eexi _ => let
    val s2f = s2exp2hnf (s2e)
    val s2e = s2hnf_opn1exi_and_add (loc0, s2f)
  in
    auxind (loc0, s2e, ind)
  end // end of [S2Eexi]
//
| _ => let
    val () =
      prerr_error3_loc (loc0)
    // end of [val]
    val () = prerr ": the type ["
    val () = prerr_s2exp (s2e)
    val () = prerr "] is expected to be a tyarr (array-type)."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_s2exp_selab_tyarr (loc0, s2e))
    val s2e_elt = s2exp_t0ype_err ()
    val s2ps = list_vt_nil ()
  in
    (s2e_elt, s2ps)
  end // end of [_]
//
end // end of [auxind]

fun auxsel
(
  s2e: s2exp, d3l: d3lab, linrest: &int, sharing: &int
) : (
  s2exp, s2explst_vt
) = let
  val loc0 = d3l.d3lab_loc
in
//
case+
  d3l.d3lab_node of
| D3LABlab (l0) => let
    val s2f = s2exp2hnf (s2e)
    val s2e = auxlab_shnf (loc0, s2f, d3l, l0, linrest, sharing)
  in
    (s2e, list_vt_nil)
  end // end of [S3LABlab]
| D3LABind (ind) => let
    val s2es2ps = auxind (loc0, s2e, ind)
    val () = if s2exp_is_lin (s2es2ps.0) then linrest := linrest + 1
  in
    s2es2ps
  end // end of [D3LABind]
//
end // end of [auxsel]

and auxselist
(
  s2e: s2exp, d3ls: d3lablst, linrest: &int, sharing: &int
) : (s2exp, s2explst_vt) = let
in
//
case+ d3ls of
| list_cons
    (d3l, d3ls) => let
    val (s2e, s2ps1) = auxsel (s2e, d3l, linrest, sharing)
    val (s2e, s2ps2) = auxselist (s2e, d3ls, linrest, sharing)
  in
    (s2e, list_vt_append (s2ps1, s2ps2))
  end // end of [list_cons]
| list_nil () => (s2e, list_vt_nil ())
//
end // end of [auxselist]

in (* in of [local] *)

implement
s2exp_get_dlablst_linrest_sharing
(
  loc0, s2e, d3ls, linrest, sharing
) =
  auxselist (s2e, d3ls, linrest, sharing)
// end of [s2exp_get_dlablst_linrest_sharing]

end // end of [local]

(* ****** ****** *)

local

fun labfind_context (
  l0: label
, ls2es: labs2explst
, context: &Option_vt @(labs2explst, s2hole)
, err: &int
) : s2exp = let
in
//
case+ ls2es of
| list_cons (ls2e, ls2es) => let
    val SLABELED (l, name, s2e) = ls2e
  in
    if l0 = l then let
      val s2t = s2e.s2exp_srt
      val s2h = s2hole_make_srt (s2t)
      val s2e_ctx = s2exp_hole (s2h)
      val ls2e_ctx = SLABELED (l, name, s2e_ctx)
      val ls2es_ctx = list_cons (ls2e_ctx, ls2es)
      val-None_vt () = context
      val () = context := Some_vt @(ls2es_ctx, s2h)
    in
      s2e
    end else let
      val s2e = labfind_context (l0, ls2es, context, err)
      val () = (
        case+ context of
        | Some_vt (!p) => let
            val () = !p.0 := list_cons (ls2e, !p.0) in fold@ (context)
          end // end of [Some_vt]
        | None_vt () => fold@ (context)
      ) : void // end of [val]
    in
      s2e
    end // end of [if]
  end // end of [list_cons]
| list_nil () => let
    val () = err := err + 1 in s2exp_t0ype_err ()
  end // end of [list_nil]
//
end // end of [labfind_context]

viewtypedef
ctxtopt_vt = Option_vt @(s2exp, s2hole)

fun auxlab (
  loc0: location
, s2f: s2hnf, l0: label
, context: &ctxtopt_vt
) : s2exp = let
//
  val s2e = s2hnf2exp (s2f)
//
in
//
case+
  s2e.s2exp_node of
//
| S2Etyrec (
    knd, npf, ls2es
  ) => let
    viewtypedef res2 =
      Option_vt @(labs2explst, s2hole)
    var context2 : res2 = None_vt ()
    var err: int = 0
    val s2e1 = labfind_context (l0, ls2es, context2, err)
    val () = (
      case+ context2 of
      | ~Some_vt @(ls2es_ctx, s2h) => let
          val s2t = s2e.s2exp_srt
          val s2e_ctx = s2exp_tyrec_srt (s2t, knd, npf, ls2es_ctx)
          val-None_vt () = context
        in
          context := Some_vt @(s2e_ctx, s2h)
        end // end of [val]
      | ~None_vt () => ()
    ) : void // end of [val]
    val () = if (err > 0) then let
      val () = prerr_error3_loc (loc0)
      val () = prerr ": the record-type ["
      val () = prerr_s2exp (s2e)
      val () = prerr "] is expected to contain the label ["
      val () = prerr_label (l0)
      val () = prerr "] but it does not."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_s2exp_selab_labnot (loc0, s2e, l0))
    end // end of [val]
  in
    s2e1
  end // end of [S2Etyrec]
//
| _ => let
    val () = prerr ": the type ["
    val () = prerr_s2exp (s2e)
    val () = prerr "] is expected to be a tyrec (record-type)."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_s2exp_selab_tyrec (loc0, s2e))
  in
    s2exp_t0ype_err ()
  end // end of [_]
//
end // end of [auxlab]

fun auxind (
  loc0: location
, s2f: s2hnf, ind: d3explst
, context: &ctxtopt_vt
, ischeck: bool
) : (s2exp, s2explst_vt) = let
//
  val s2e = s2hnf2exp (s2f)
//
in
//
case+
  s2e.s2exp_node of
| S2Etyarr (
    s2e_elt, s2es_dim
  ) => let
    val s2ps = (
      if ischeck then
        arrbndlst_check (loc0, ind, s2es_dim) else list_vt_nil
      // end of [if]
    ) : s2explst_vt // end of [val]
  in
    (s2e_elt, s2ps)
  end // end of [S2Etyarr]
| _ => let
    val s2e_elt = s2exp_t0ype_err () in (s2e_elt, list_vt_nil(*s2ps*))
  end // end of [_]
//
end // end of [auxind]

fun auxsel (
  s2e: s2exp
, d3l: d3lab
, context: &ctxtopt_vt
, ischeck: bool
) : (s2exp, s2explst_vt) = let
  val loc = d3l.d3lab_loc
  val s2f = s2exp2hnf (s2e)
in
//
case+ d3l.d3lab_node of
| D3LABlab (lab) => let
    val s2e_elt =
      auxlab (loc, s2f, lab, context)
    // end of [val]
  in
    (s2e_elt, list_vt_nil(*s2ps*))
  end // end of [D3LABlab]
| D3LABind (ind) =>
    auxind (loc, s2f, ind, context, ischeck)
  // end of [D3LABind]
//
end // end of [auxsel]

and auxselist (
  s2e: s2exp
, d3ls: d3lablst
, context: &ctxtopt_vt
, ischeck: bool
) : (s2exp, s2explst_vt) = let
in
//
case+ d3ls of
| list_cons (
    d3l, list_nil ()
  ) =>
    auxsel (s2e, d3l, context, ischeck)
  // end of [list_sing]
| list_cons (d3l, d3ls) => let
    val s2es2ps =
      auxsel (s2e, d3l, context, ischeck)
    val s2e = s2es2ps.0
    val s2ps = s2es2ps.1
  in
    case+ context of
    | ~Some_vt @(
        s2e1_ctx, s2h1
      ) => let
        val () = context := None_vt ()
        val s2es2ps =
          auxselist (s2e, d3ls, context, ischeck)
        val s2e = s2es2ps.0
        val s2ps = list_vt_append (s2ps, s2es2ps.1)
      in
        case+ context of
        | Some_vt (!p) => let
            val () = !p.0 :=
              s2exp_hrepl (s2e1_ctx, !p.0)
            prval () = fold@ (context)
          in
            @(s2e, s2ps)
          end // end of [Some_vt]
        | None_vt () => let
            prval () = fold@ (context) in @(s2e, s2ps)
          end // end of [None_vt]
      end // end of [Some_vt]
    | ~None_vt () => let
        val () = context := None_vt ()
        val s2es2ps =
          auxselist (s2e, d3ls, context, ischeck)
        val s2e = s2es2ps.0
        val s2ps = list_vt_append (s2ps, s2es2ps.1)
        val () = option_vt_free (context)
        val () = context := None_vt ()
      in
        @(s2e, s2ps)
      end // end of [None_vt]
  end (* end of [list_cons] *)
| list_nil () => let
    val s2t = s2e.s2exp_srt
    val s2h = s2hole_make_srt (s2t)
    val s2e_ctx = s2exp_hole (s2h)
    val-None_vt () = context
    val () = context := Some_vt @(s2e_ctx, s2h)
  in
    (s2e, list_vt_nil(*s2ps*))
  end // end of [list_nil]
//
end // end of [auxselist]

in (* in of [local] *)

implement
s2exp_get_dlablst_context
  (loc0, s2e, d3ls, context) = let
  var context2: ctxtopt_vt = None_vt ()
  val s2es2ps =
    auxselist (s2e, d3ls, context2, false(*ischeck*))
  val () = list_vt_free (s2es2ps.1)
  val () = (
    case+ context2 of
    | ~Some_vt @(s2e_ctx, s2h) =>
        context := Some (s2ctxt_make (s2e_ctx, s2h))
    | ~None_vt () => ()
  ) : void // end of [val]
in
  s2es2ps.0(*selected*)
end // end of [s2exp_get_dlablst_context]

implement
s2exp_get_dlablst_context_check
  (loc0, s2e, d3ls, context) = let
  var context2: ctxtopt_vt = None_vt ()
  val s2es2ps = auxselist (s2e, d3ls, context2, true(*ischeck*))
  val () = (
    case+ context2 of
    | ~Some_vt @(s2e_ctx, s2h) =>
        context := Some (s2ctxt_make (s2e_ctx, s2h))
    | ~None_vt () => ()
  ) : void // end of [val]
in
  s2es2ps
end // end of [s2exp_get_dlablst_context_check]

end // end of [local]

(* ****** ****** *)

extern
fun d2var_trup_selab
(
  loc0: location, locvar: location, d2v: d2var, d2ls: d2lablst
) : d3exp // end of [d2var_trup_selab]

extern
fun d2var_trup_selab_lin
(
  loc0: location, locvar: location, d2v: d2var, d2ls: d2lablst
) : d3exp // end of [d2var_trup_selab_lin]
extern
fun d2var_trup_selab_mut
(
  loc0: location, locvar: location, d2v: d2var, d2ls: d2lablst
) : d3exp // end of [d2var_trup_selab_mut]

extern
fun d3exp_trup_selab
  (loc0: location, d3e: d3exp, d3ls: d3lablst): d3exp
// end of [d3exp_trup_selab]

(* ****** ****** *)

implement
d2var_trup_selab_lin
  (loc0, loc, d2v, d2ls) = let
(*
val () =
  println! ("d2exp_trup_selab: D2Evar(lin): d2v = ", d2v)
// end of [val]
*)
val s2e =
  d2var_get_type_some (loc, d2v)
val s2rt = s2e // HX: root type for selection
val d3ls = d2lablst_trup (d2ls)
var linrest: int = 0 and sharing: int = 0
val s2es2ps =
  s2exp_get_dlablst_linrest_sharing (loc0, s2e, d3ls, linrest, sharing)
// end of [val]
val s2e_sel = s2exp_hnfize (s2es2ps.0)
val () = trans3_env_add_proplst_vt (loc0, s2es2ps.1)
val islin = s2exp_is_lin (s2e_sel)
//
in
//
if islin then let
  val s2t = s2e.s2exp_srt
  var ctxtopt: s2expopt = None ()
  val s2e_sel =
    s2exp_get_dlablst_context (loc0, s2e, d3ls, ctxtopt)
//
  val isctx = (
    case+ ctxtopt of Some _ => true | None _ => false
  ) : bool // end of [val]
  val () = if ~isctx then {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the linear component cannot be taken out."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_d2var_selab_context (loc0, d2v, d3ls))
  } // end of [if] // end of [val]
//
  val () = d2var_inc_linval (d2v)
  val () = let
    val s2e_sel = s2exp_topize (1, s2e_sel)
    val s2e = (
      case+ ctxtopt of
      | Some (ctxt) => s2ctxt_hrepl (ctxt, s2e_sel) | None () => s2e
    ) : s2exp // end of [val]
    val () = d2var_set_type (d2v, Some (s2e))
  in
    // nothing
  end // end of [val]
in
  d3exp_sel_var (loc0, s2e_sel, d2v, s2rt, d3ls)
end else
  d3exp_sel_var (loc0, s2e_sel, d2v, s2rt, d3ls) // there is no type-change
// end of [if]
//
end // end of [d2var_trup_selab_lin]

(* ****** ****** *)

(*
** HX-2012-05:
** [s2addr] is implemented in [pats_trans3_deref]
*)
implement
d2var_trup_selab_mut
  (loc0, loc, d2v, d2ls) = let
  val-Some (s2l) = d2var_get_addr (d2v)
  val d3ls = d2lablst_trup (d2ls)
  var s2rt: s2exp
  val s2e_sel = s2addr_deref (loc0, s2l, d3ls, s2rt)
in
  d3exp_sel_var (loc0, s2e_sel, d2v, s2rt, d3ls)
end // end of [d2var_trup_selab_mut]

implement
d2var_trup_selab
  (loc0, loc, d2v, d2ls) =
(
  if d2var_is_linear (d2v) then
    d2var_trup_selab_lin (loc0, loc, d2v, d2ls)
  else if d2var_is_mutabl (d2v) then
    d2var_trup_selab_mut (loc0, loc, d2v, d2ls)
  else let
    val d3e =
      d2exp_trup_var_nonmut (loc, d2v)
    val d3ls = d2lablst_trup (d2ls)
  in
    d3exp_trup_selab (loc0, d3e, d3ls)
  end // end of [if]
) (* end of [d2var_trup_selab] *)

(* ****** ****** *)

local

fun auxerr_linrest
(
  loc0: location, d3e: d3exp, d3ls: d3lablst
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": a linear component is abandoned by field selection."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_selab_linrest (loc0, d3e, d3ls))
end // end of [auxerr_linrest]

in (* in of [local] *)

implement
d3exp_trup_selab
  (loc0, d3e, d3ls) = let
// (*
val () = println! ("d3exp_trup_selab: d3e = ", d3e)
// *)
in
//
case+ d3ls of
| list_cons _ => let
//
    val s2e = d3exp_get_type (d3e)
// (*
    val () = println! ("d3exp_trup_selab: s2e = ", s2e)
// *)
    var linrest: int = 0 and sharing: int = 0
    val (s2e_sel, s2ps) =
      s2exp_get_dlablst_linrest_sharing (loc0, s2e, d3ls, linrest, sharing)
    val s2e_sel = s2exp_hnfize (s2e_sel)
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val () = if (linrest > 0) then auxerr_linrest (loc0, d3e, d3ls)
//
  in
    d3exp_selab (loc0, s2e_sel, d3e, d3ls)
  end // end of [list_cons]
| list_nil () => d3e // HX: there is no need to open the type
//
end (* end of [d3exp_trup_selab] *)

end // end of [local]

(* ****** ****** *)

implement
d2exp_trup_selab
  (d2e0, d2e, d2ls) = let
// (*
val (
) = println!
  ("d2exp_trup_selab: d2e0 = ", d2e0)
// *)
//
val loc0 = d2e0.d2exp_loc
//
in
//
case+
  d2e.d2exp_node of
| D2Evar (d2v) => let
    val loc = d2e.d2exp_loc
  in
    d2var_trup_selab (loc0, loc, d2v, d2ls)
  end // end of [D2Evar]
| D2Ederef d2e =>
    d2exp_trup_deref (loc0, d2e, d2ls)
  // end of [D2Ederef]
| _ => let
    val d3e = d2exp_trup (d2e)
    val d3ls = d2lablst_trup (d2ls)
  in
    d3exp_trup_selab (loc0, d3e, d3ls)
  end (* end of [_] *)
//
end // end of [d2exp_trup_selab]

(* ****** ****** *)

(* end of [pats_trans3_selab.dats] *)
