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
// Start Time: November, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_selab"

(* ****** ****** *)

staload LAB = "pats_label.sats"
overload = with $LAB.eq_label_label
macdef prerr_label = $LAB.prerr_label

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fun
d2lab_trup (
  d2l: d2lab
) : d3lab = let
  val loc = d2l.d2lab_loc
in
  case+ d2l.d2lab_node of
  | D2LABlab (lab) => d3lab_lab (loc, lab)
  | D2LABind ind => let
      val ind = d2explstlst_trup (ind) in d3lab_ind (loc, ind)
    end // end of [D2LABind]
end // end of [d2lab_trup]

implement
d2lablst_trup (d2ls) = let
  val d3ls = list_map_fun (d2ls, d2lab_trup) in (l2l)d3ls
end // end of [d2lablst_trup]

(* ****** ****** *)

local

fun lincheck (
  ls2es: labs2explst, linrest: &int
) : void = let
in
//
if linrest = 0 then (
  case+ ls2es of
  | list_cons (ls2e, ls2es) => let
      val SLABELED (_, _, s2e) = ls2e
      val () = if s2exp_is_lin (s2e) then linrest := linrest + 1
    in
      lincheck (ls2es, linrest)
    end // end of [list_cons]
  | list_nil () => ()
) else () // end of [if]
//
end // end of [lincheck]

fun
labfind_lincheck (
  l0: label, ls2es: labs2explst, linrest: &int, err: &int
) : s2exp = let
in
//
case+ ls2es of
| list_cons (ls2e, ls2es) => let
    val SLABELED (l, _, s2e) = ls2e
  in
    if l0 = l then let
      val () = lincheck (ls2es, linrest) in s2e
    end else let
      val () = if linrest = 0 then (
        if s2exp_is_lin (s2e) then linrest := linrest + 1
      ) // end of [val]
    in
      labfind_lincheck (l0, ls2es, linrest, err)
    end // end of [if]
  end // end of [list_cons]
| list_nil () => let
    val () = err := err + 1 in s2exp_err (s2rt_t0ype)
  end // end of [list_nil]
//
end // end of [labfind_lincheck]

fun auxlab .<>. (
  d3l: d3lab, s2e: s2exp, l0: label, linrest: &int
) : s2exp = let
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2e.s2exp_node of
| S2Etyrec (knd, npf, ls2es) => let
    var err: int = 0
    val s2e1 =
      labfind_lincheck (l0, ls2es, linrest, err)
    // end of [val]
    val () = if (err > 0) then let
      val loc = d3l.d3lab_loc
      val () = prerr_error3_loc (loc)
      val () = prerr ": the record-type ["
      val () = prerr_s2exp (s2e)
      val () = prerr "] is expected to contain the label ["
      val () = prerr_label (l0)
      val () = prerr "]."
      val () = prerr_newline ()
    in
      the_trans3errlst_add (T3E_d3exp_trup_selab_labnot (d3l))
    end // end of [val]
  in
    s2e1
  end // end of [S2Etyrec]
| _ => let
    val loc = d3l.d3lab_loc
    val () =
      prerr_error3_loc (loc)
    // end of [val]
    val () = prerr ": the type ["
    val () = prerr_s2exp (s2e)
    val () = prerr "] is expected to be a tyrec (record-type)."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_d3exp_trup_selab_tyrec (s2e))
  in
    s2exp_err (s2rt_t0ype)
  end // end of [_]
//
end // end of [auxlab]

fun bndck .<>. (
  d3e1: d3exp, s2i2: s2exp
) : s2explst_vt = let
//
fun auxerr (
  d3e: d3exp
) : void = let
  val loc = d3e.d3exp_loc
  val s2e = d3exp_get_type (d3e)
  val () = prerr_error3_loc (loc)
  val () = prerr ": the type of the array index is not "
  val () = prerr "a generic (signed or unsigned) integer type: ["
  val () = prerr_s2exp (s2e)
  val () = prerr "]."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_trup_selab_arrind (d3e))
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
        val s2p = s2exp_igtez (s2i1) in list_vt_sing (s2p)
      end // end of [Some_vt]
    | ~None_vt () => let
        val () = auxerr (d3e1) in list_vt_nil ()
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [bndck]

fun
arrbnd_check .<>. (
  d3l: d3lab, ind: d3explstlst, dim: s2explst
) : s2explst_vt = let
//
fun auxerr (
  d3l: d3lab, dim: s2explst, sgn: int
) : void = let
  val loc = d3l.d3lab_loc
  val () = prerr_error3_loc (loc)
  val () = prerr ": the label is expected to contain "
  val () = if sgn < 0 then prerr "more array indexes."
  val () = if sgn > 0 then prerr "fewer array indexes."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_trup_selab_arrdim (d3l, dim))
end // end of [auxerr] 
//
val nind =
  loop (ind, 0) where {
  fun loop (xss: d3explstlst, n: int): int =
    case+ xss of
    | list_cons (xs, xss) => loop (xss, n + list_length (xs))
    | list_nil () => n
  // end of [loop]
} // end of [val]
val ndim = list_length (dim)
//
fun check1 (
  xss: d3explstlst, s2es: s2explst
) : s2explst_vt =
  case+ xss of
  | list_cons (xs, xss) => check2 (xs, xss, s2es)
  | list_nil () => list_vt_nil ()
// end of [check1]
and check2 (
  xs: d3explst, xss: d3explstlst, s2es: s2explst
) : s2explst_vt =
  case+ xs of
  | list_cons (x, xs) => let
      val- list_cons (s2e, s2es) = s2es
      val s2ps1 = bndck (x, s2e)
      val s2ps2 = check2 (xs, xss, s2es)
    in
      list_vt_append (s2ps1, s2ps2)
    end // end of [list_cons]
  | list_nil () => check1 (xss, s2es)
// end of [check2]
//
val sgn = nind - ndim
//
in
//
if sgn < 0 then let
  val () = auxerr (d3l, dim, sgn) in list_vt_nil ()
end else if sgn > 0 then let
  val () = auxerr (d3l, dim, sgn) in list_vt_nil ()
end else check1 (ind, dim) // end of [if]
//
end // end of [arrbnd_check]

fun auxind .<>. (
  d3l: d3lab, s2e: s2exp, ind: d3explstlst
) : (
  s2exp(*elt*), s2explst_vt(*array bounds checking*)
) = let
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2e.s2exp_node of
| S2Etyarr
    (s2e_elt, s2es_dim) => let
    val s2ps = arrbnd_check (d3l, ind, s2es_dim)
  in
    (s2e_elt, s2ps)
  end // end of [S2Etyarr]
| _ => let
    val loc = d3l.d3lab_loc
    val () =
      prerr_error3_loc (loc)
    // end of [val]
    val () = prerr ": the type ["
    val () = prerr_s2exp (s2e)
    val () = prerr "] is expected to be a tyarr (array-type)."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_d3exp_trup_selab_tyarr (s2e))
    val s2e_elt =
      s2exp_err (s2rt_t0ype)
    val s2ps = list_vt_nil ()
  in
    (s2e_elt, s2ps)
  end // end of [_]
//
end // end of [auxind]

fun auxsel (
  s2e: s2exp, d3l: d3lab, linrest: &int
) : (
  s2exp, s2explst_vt
) = let
  val s2f = s2exp2hnf (s2e)
  val s2e = s2hnf2exp (s2f)
in
//
case+ d3l.d3lab_node of
| D3LABlab (lab) => let
    val s2e = auxlab (d3l, s2e, lab, linrest)
  in
    (s2e, list_vt_nil)
  end // end of [S3LABlab]
| D3LABind (ind) => let
    val s2es2ps = auxind (d3l, s2e, ind)
    val () = if s2exp_is_lin (s2es2ps.0) then linrest := linrest + 1
  in
    s2es2ps
  end // end of [D3LABind]
//
end // end of [auxsel]

and auxselist (
  s2e: s2exp, d3ls: d3lablst, linrest: &int
) : (s2exp, s2explst_vt) = let
in
//
case+ d3ls of
| list_cons (d3l, d3ls) => let
    val (s2e, s2ps1) = auxsel (s2e, d3l, linrest)
    val (s2e, s2ps2) = auxselist (s2e, d3ls, linrest)
  in
    (s2e, list_vt_append (s2ps1, s2ps2))
  end // end of [list_cons]
| list_nil () => (s2e, list_vt_nil ())
//
end // end of [auxselist]

in // in of [local]

implement
s2exp_get_dlablst_linrest
  (loc0, s2e, d3ls, linrest) = auxselist (s2e, d3ls, linrest)
// end of [s2exp_get_dlablst_linrest]

end // end of [local]

(* ****** ****** *)

extern
fun d3exp_trup_selab
  (loc0: location, d3e: d3exp, d3ls: d3lablst): d3exp
// end of [d3exp_trup_selab]

implement
d3exp_trup_selab
  (loc0, d3e, d3ls) = let
//
fun auxerr (
  loc0: location, d3e: d3exp, d3ls: d3lablst
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": a linear component is abandoned by field selection."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_trup_selab_linrest (loc0, d3e, d3ls))
end // end of [auxerr]
//
in
//
case+ d3ls of
| list_cons _ => let
    val () =
      d3exp_open_and_add (d3e)
    // end of [val]
    val s2e = d3exp_get_type (d3e)
//
    var linrest: int = 0
    val (s2e_sel, s2ps) =
      s2exp_get_dlablst_linrest (loc0, s2e, d3ls, linrest)
    // end of [val]
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val () = if (linrest > 0) then auxerr (loc0, d3e, d3ls)
//
  in
    d3exp_selab (loc0, s2e_sel, d3e, d3ls)
  end // end of [list_cons]
| list_nil () => d3e
end (* end of [d3exp_trup_selab] *)

(* ****** ****** *)

implement
d2exp_trup_selab
  (d2e0, d2e, d2ls) = let
(*
val () = (
  print "d2exp_trup_selab: d2e0 = "; print_d2exp (d2e0); print_newline ()
) // end of [val]
*)
//
val loc0 = d2e0.d2exp_loc
//
in
//
case+ d2e.d2exp_node of
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
