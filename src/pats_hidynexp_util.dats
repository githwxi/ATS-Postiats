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
// Start Time: September, 2012
//
(* ****** ****** *)

staload
UN = "./prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_hidynexp_util"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload D2E = "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)
//
implement
d2cst_get2_hisexp (d2c) =
  $UN.cast{hisexpopt}($D2E.d2cst_get_hisexp(d2c))
implement
d2cst_set2_hisexp (d2c, opt) =
  $D2E.d2cst_set_hisexp (d2c, $UN.cast{$D2E.hisexpopt}(opt))
//
(* ****** ****** *)

implement
$D2E.d2cst_is_fun
  (d2c) = let
//
val-Some (hse) = d2cst_get2_hisexp (d2c)
//
in
//
case+
  hse.hisexp_node of
| HSEfun (fc, _arg, _res) =>
  (
    case+ fc of FUNCLOfun () => true | _ => false
  ) // end of [HSEfun]
| _ => false // end of [_]
//
end // end of [$D2E.d2cst_is_fun]

(* ****** ****** *)

implement
d2cst_get2_type_arg
  (d2c) = let
//
val-Some(hse) = d2cst_get2_hisexp (d2c)
//
in
//
case+ hse.hisexp_node of
| HSEfun (
    _(*fc*), _arg, _(*res*)
  ) => _arg
| _ => let
    val () = prerr_interror ()
    val (
    ) = (
      prerrln! (": d2cst_get_type_arg: hse = ", hse)
    ) // end of [val]
    val () = assertloc (false)
  in
    exit (1) // HX: this is deadcode
  end (* end of [_] *)
//
end // end of [d2cst_get2_type_arg]

implement
d2cst_get2_type_res
  (d2c) = let
//
val-Some(hse) = d2cst_get2_hisexp (d2c)
//
in
//
case+
  hse.hisexp_node of
| HSEfun (
    _(*fc*), _(*arg*), _res
  ) => _res
| _ => let
    val () = prerr_interror ()
    val (
    ) = (
      prerrln! (": d2cst_get_type_arg: hse = ", hse)
    ) // end of [val]
    val () = assertloc (false)
  in
    exit (1) // HX: this is deadcode
  end (* end of [_] *)
//
end // end of [d2cst_get_type_res]

(* ****** ****** *)
//
implement
d2var_get2_hisexp (d2v) =
  $UN.cast{hisexpopt}($D2E.d2var_get_hisexp(d2v))
implement
d2var_set2_hisexp (d2v, opt) =
  $D2E.d2var_set_hisexp (d2v, $UN.cast{$D2E.hisexpopt}(opt))
//
(* ****** ****** *)

implement
d2cst_get2_funclo (d2c) = let
  val opt = d2cst_get2_hisexp (d2c)
in
//
case+ opt of
| Some (hse) =>
  (
    case+ hse.hisexp_node of
    | HSEfun (fc, _, _) => Some_vt (fc) | _ => None_vt ()
  )
| None () => None_vt ()
//
end // end of [d2cst_get2_funclo]

(* ****** ****** *)

implement
d2var_get2_funclo (d2v) = let
  val opt = d2var_get2_hisexp (d2v)
in
//
case+ opt of
| Some (hse) =>
  (
    case+ hse.hisexp_node of
    | HSEfun (fc, _, _) => Some_vt (fc) | _ => None_vt ()
  )
| None () => None_vt ()
//
end // end of [d2var_get2_funclo]

(* ****** ****** *)

local

fun hidexplst_is_value
  (xs: hidexplst): bool =
  list_forall_fun (xs, hidexp_is_value)
// end of [hidexplst_is_value]

fun labhidexplst_is_value
  (lxs: labhidexplst): bool = let
//
fun ftest (lx: labhidexp) = let
  val LABHIDEXP (l, x) = lx in hidexp_is_value (x)
end // end of [fun]
//
in
  list_forall_fun (lxs, ftest)
end // end of [labhidexplst_is_value]

in (* in of [local] *)

implement
hidexp_is_value
  (hde0) = case+ hde0.hidexp_node of
//
  | HDEvar _ => true
  | HDEcst _ => true
//
  | HDEbool _ => true
  | HDEchar _ => true
  | HDEstring _ => true
//
  | HDEi0nt _ => true
  | HDEf0loat _ => true
//
  | HDEextval _ => true
//
  | HDElam _ => true
  | HDErec (_, lhdes, _) => labhidexplst_is_value (lhdes)
//
  | HDEtmpcst _ => true
  | HDEtmpvar _ => true
//
  | _ => false
// end of [hidexp_is_value]

end // end of [local]

(* ****** ****** *)

implement
hidexp_let_simplify
  (loc, hse, hids, hde) = hidexp_let (loc, hse, hids, hde)

(* ****** ****** *)

(* end of [pats_hidynexp_util.dats] *)
