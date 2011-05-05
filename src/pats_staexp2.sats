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
// Start Time: May, 2011
//
(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location
staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol

(* ****** ****** *)

staload "pats_staexp1.sats"

(* ****** ****** *)

abstype s2rtdat_type // boxed
typedef s2rtdat = s2rtdat_type

abstype s2cst_type // assumed in [pats_staexp2_scst.dats]
typedef s2cst = s2cst_type
typedef s2cstlst = List (s2cst)
typedef s2cstopt = Option (s2cst)

abstype s2var_type // assumed in [pats_staexp2_svVar.dats]
typedef s2var = s2var_type
typedef s2varlst = List (s2var)
typedef s2varopt = Option (s2var)
abstype s2varset_type // assumed in [pats_staexp2_svVar.dats]
typedef s2varset = s2varset_type

abstype s2Var_type // assumed in [pats_staexp2_svVar.dats]
typedef s2Var = s2Var_type
typedef s2Varlst = List (s2Var)
typedef s2Varopt = Option (s2Var)
abstype s2Varset_type // assumed in [pats_staexp2_svVar.dats]
typedef s2Varset = s2Varset_type

abstype d2con_type // assumed in [pats_staexp2_dcon.dats]
typedef d2con = d2con_type
typedef d2conlst = List (d2con)

(* ****** ****** *)

datatype
s2rtbas =
  | S2RTBASpre of symbol // predicative: bool, char, int, ...
  | S2RTBASimp of (symbol, int(*knd*)) // impredicative sorts
  | S2RTBASdef of s2rtdat // user-defined datasorts
// end of [s2rtbas]

datatype s2rt =
  | S2RTbas of s2rtbas (* base sort *)
  | S2RTfun of (s2rtlst, s2rt) // function sort
  | S2RTtup of s2rtlst (* tuple sort *)
  | S2RTerr of (s1rt) // HX: indicating an error
// end of [s2rt]

where
s2rtlst = List (s2rt)
and s2rtopt = Option (s2rt)

fun s2rt_err (x: s1rt): s2rt

(* ****** ****** *)
//
// HX-2011-05-02:
// [filenv] contains the following
// [s2rtenv], [s2expenv] and [d2expenv]
//
abstype filenv_type
typedef filenv = filenv_type

(* ****** ****** *)

datatype
s2itm = // static items
  | S2ITMcst of s2cstlst
  | S2ITMdatconptr of d2con
  | S2ITMdatcontyp of d2con
  | S2ITMe1xp of e1xp
  | S2ITMfil of filenv
  | S2ITMvar of s2var
// end of [s2itm]

typedef s2itmlst = List s2itm
viewtypedef s2itmopt_vt = Option_vt (s2itm)

(* ****** ****** *)

abstype intinf_type
typedef intinf = intinf_type

(* ****** ****** *)

datatype
s2exp_node =
//
  | S2Eint of int // integer
  | S2Eintinf of intinf // integer of flexible precision
  | S2Echar of char // character
//
  | S2Ecst of s2cst // constant
//
  | S2Evar of s2var // variable
  | S2EVar of s2Var // existential variable
//
  | S2Etup of (s2explst) // tuple
  | S2Etylst of (s2explst) // type list
//
  | S2Edatconptr of (* unfolded datatype *)
      (d2con, s2explst) (* constructor and addrs of arguments *)
  | S2Edatcontyp of (* unfolded datatype *)
      (d2con, s2explst) (* constructor and types of arguments *)
//
  | S2Eexi of ( // exist. quantified type
      s2varlst(*vars*), s2explst(*props*), s2exp(*body*)
    ) // end of [S2Euni]
  | S2Euni of ( // universally quantified type
      s2varlst(*vars*), s2explst(*props*), s2exp(*body*)
    ) // end of [S2Euni]
//
  | S2Evararg of s2exp // variadic argument type
//
  | S2Ewth of (s2exp, wths2explst) // the result part of a fun type
// end of [s2exp_node]

and s2rtext = (* extended sort *)
  | S2TEsrt of s2rt
  | S2TEsub of (s2var, s2rt, s2explst)
// end of [s2rtext]

and wths2explst =
  | WTHS2EXPLSTnil of ()
  | WTHS2EXPLSTcons_some of (int(*refval*), s2exp, wths2explst)
  | WTHS2EXPLSTcons_none of wths2explst
// end of [wths2explst]

where
s2exp = '{
  s2exp_srt= s2rt, s2exp_node= s2exp_node
} // end of [s2exp]
and s2explst = List (s2exp)
and s2expopt = Option (s2exp)

and s2rtextopt_vt = Option_vt (s2rtext)

(* ****** ****** *)

(* end of [pats_staexp2.sats] *)
