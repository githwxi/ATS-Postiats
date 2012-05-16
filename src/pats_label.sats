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

abstype symbol_type
typedef symbol = symbol_type

(* ****** ****** *)

staload
SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

abstype label_type
typedef label = label_type

(* ****** ****** *)

fun label_make_int (i: int): label
fun label_make_sym (sym: symbol): label
fun label_make_string (str: string): label

(* ****** ****** *)

fun eq_label_label (l1: label, l2: label):<> bool
overload = with eq_label_label
fun neq_label_label (l1: label, l2: label):<> bool
overload != with neq_label_label

fun compare_label_label (l1: label, l2: label):<> Sgn
overload compare with compare_label_label

(* ****** ****** *)

fun fprint_label
  (out: FILEref, x: label): void
overload fprint with fprint_label

fun print_label (l: label): void
and prerr_label (l: label): void
overload print with print_label
overload prerr with prerr_label

(* ****** ****** *)

datatype labeled (a:t@ype) = LABELED (a) of (label, a)

(* ****** ****** *)

(* end of [pats_label.sats] *)
