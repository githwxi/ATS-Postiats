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
// Start Time: February, 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"
typedef intinf = $INTINF.intinf
typedef intinfset = $INTINF.intinfset
macdef fprint_intinf = $INTINF.fprint_intinf
macdef fprint_intinfset = $INTINF.fprint_intinfset

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
stadef label = $LAB.label

(* ****** ****** *)

staload
SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload
STAEXP2 = "./pats_staexp2.sats"
typedef d2con = $STAEXP2.d2con
staload
DYNEXP2 = "./pats_dynexp2.sats"
typedef p2at = $DYNEXP2.p2at
typedef p2atlst = $DYNEXP2.p2atlst
typedef c2lau = $DYNEXP2.c2lau

(* ****** ****** *)

fun intinf_of_i0nt (x: $SYN.i0nt): intinf

(* ****** ****** *)

datatype
p2atcst =
  | P2TCany of ()
  | P2TCcon of (d2con, p2atcstlst)
  | P2TCempty of ()
  | P2TCint of intinf
  | P2TCbool of bool
  | P2TCchar of char
  | P2TCstring of string
  | P2TCfloat of string(*rep*)
  | P2TCrec of (int(*reckind*), labp2atcstlst)
  | P2TCintc of intinfset
// end of [p2atcst]

and labp2atcst = LABP2ATCST of (label, p2atcst)

where
p2atcstlst
  (n:int) = list (p2atcst, n)
and p2atcstlst = List (p2atcst)
and labp2atcstlst = List (labp2atcst)

viewtypedef
p2atcstlst_vt = List_vt (p2atcst)
viewtypedef
labp2atcstlst_vt = List_vt (labp2atcst)

typedef
p2atcstlstlst = List (p2atcstlst)
typedef
labp2atcstlstlst = List (labp2atcstlst)

(* ****** ****** *)

viewtypedef
p2atcstlstlst_vt = List_vt (p2atcstlst_vt)
viewtypedef
labp2atcstlstlst_vt = List_vt (labp2atcstlst_vt)

(* ****** ****** *)

fun p2atcstlstlst_vt_free (xss: p2atcstlstlst_vt): void
fun p2atcstlstlst_vt_copy (xss: !p2atcstlstlst_vt): p2atcstlstlst_vt

(* ****** ****** *)

fun print_p2atcst (x: p2atcst): void
and prerr_p2atcst (x: p2atcst): void
fun fprint_p2atcst : fprint_type (p2atcst)

fun print_p2atcstlst (xs: p2atcstlst): void
and prerr_p2atcstlst (xs: p2atcstlst): void
fun print_p2atcstlst_vt (xs: !p2atcstlst_vt): void
and prerr_p2atcstlst_vt (xs: !p2atcstlst_vt): void
fun fprint_p2atcstlst : fprint_type (p2atcstlst)

fun print_labp2atcstlst (xs: labp2atcstlst): void
and prerr_labp2atcstlst (xs: labp2atcstlst): void
fun fprint_labp2atcstlst : fprint_type (labp2atcstlst)

fun print_p2atcstlstlst (xss: p2atcstlstlst): void
and prerr_p2atcstlstlst (xss: p2atcstlstlst): void
fun print_p2atcstlstlst_vt (xss: !p2atcstlstlst_vt): void
fun prerr_p2atcstlstlst_vt (xss: !p2atcstlstlst_vt): void
fun fprint_p2atcstlstlst : fprint_type (p2atcstlstlst)

(* ****** ****** *)

fun p2at2cst (p2t: p2at): p2atcst
fun p2at2cstlst (p2ts: p2atlst): p2atcstlst

(* ****** ****** *)

fun p2atcst_comp (x: p2atcst): p2atcstlst_vt
fun p2atcstlst_comp (xs: p2atcstlst): p2atcstlstlst_vt

fun labp2atcstlst_comp (xs: labp2atcstlst): labp2atcstlstlst_vt

(* ****** ****** *)

fun c2lau_pat_comp (c2l: c2lau): p2atcstlstlst_vt

(* ****** ****** *)

fun p2atcst_inter_test (x1: p2atcst, x2: p2atcst): bool
fun p2atcstlst_inter_test (xs1: p2atcstlst, xs2: p2atcstlst): bool

fun labp2atcstlst_inter_test (xs1: labp2atcstlst, xs2: labp2atcstlst): bool

(* ****** ****** *)

fun p2atcst_diff
  (x1: p2atcst, x2: p2atcst): p2atcstlst_vt
fun p2atcstlst_diff
  (xs1: p2atcstlst, xs2: p2atcstlst): p2atcstlstlst_vt
// end of [p2atcstlst_diff]

fun labp2atcstlst_diff
  (xs1: labp2atcstlst, xs2: labp2atcstlst): labp2atcstlstlst_vt
// end of [labp2atcstlst_diff]

(* ****** ****** *)

(* end of [pats_patcst2.sats] *)
