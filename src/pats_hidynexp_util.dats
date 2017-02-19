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
// Start Time: September, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "./prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<>
  ((*void*)) = prerr "pats_hidynexp_util"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

(* ****** ****** *)

staload LOC = "./pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload S2E = "./pats_staexp2.sats"
staload D2E = "./pats_dynexp2.sats"
overload = with $S2E.eq_d2con_d2con
overload = with $D2E.eq_d2var_d2var

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

implement
hipat_is_wild
  (hip) = let
in
//
case+
  hip.hipat_node of
| HIPany _ => true
| HIPvar _ => true
| HIPann (hip, _) => hipat_is_wild (hip)
| HIPrefas (_, hip) => hipat_is_wild (hip)
| _ => false
//
end // end of [hipat_is_wild]

implement
hipatlst_is_wild
  (hips) = list_forall_fun (hips, hipat_is_wild)
// end of [hipatlst_is_wild]

implement
labhipatlst_is_wild
  (lhips) = let
//
fun labhipat_is_wild
  (lhip: labhipat): bool = let
  val LABHIPAT (_, hip) = lhip in hipat_is_wild (hip)
end // end of [labhipat_is_wild]
//
in
  list_forall_fun (lhips, labhipat_is_wild)
end // end of [labhipatlst_is_wild]

(* ****** ****** *)

implement
hipat_subtest
  (hip1, hip2) = let
//
(*
val () =
(
  println! ("hipat_subtest: hip1 = ", hip1);
  println! ("hipat_subtest: hip2 = ", hip2);
) // end of [val]
*)
//
val hipn1 = hip1.hipat_node
val hipn2 = hip2.hipat_node
//
in
//
case+
  (hipn1, hipn2) of
//
| (_, HIPany _) => true
| (_, HIPvar _) => true
| (_, HIPann (hip2, _)) => hipat_subtest (hip1, hip2)
| (_, HIPrefas (_, hip2)) => hipat_subtest (hip1, hip2)
//
| (HIPann (hip1, _), _) => hipat_subtest (hip1, hip2)
| (HIPrefas (_, hip1), _) => hipat_subtest (hip1, hip2)
//
| (HIPcon
    (_, d2c1, _, lxs1), _) => (
  case+ hipn2 of
  | HIPcon (_, d2c2, _, lxs2) =>
    (
      if d2c1 = d2c2
        then labhipatlst_subtest (lxs1, lxs2) else false
      // end of [if]
    )
  | HIPcon_any (_, d2c2) => d2c1 = d2c2
  | _ => false
  )
| (HIPcon_any (_, d2c1), _) => (
  case+ hipn2 of
  | HIPcon (_, d2c2, _, lxs2) =>
      if d2c1 = d2c2 then labhipatlst_is_wild (lxs2) else false
  | HIPcon_any (_, d2c2) => d2c1 = d2c2
  | _ => false
  )
//
| (HIPint i1, _) => (
  case+ hipn2 of HIPint i2 => i1 = i2 | _ => false
  )
| (HIPbool b1, _) => (
  case+ hipn2 of HIPbool b2 => b1 = b2 | _ => false
  )
| (HIPchar c1, _) => (
  case+ hipn2 of HIPchar c2 => c1 = c2 | _ => false
  )
| (HIPstring str1, _) => (
  case+ hipn2 of HIPstring str2 => str1 = str2 | _ => false
  )
| (HIPfloat f1, _) => (
  case+ hipn2 of HIPfloat f2 => f1 = f2 | _ => false
  )
//
| (HIPempty (), _) => (
  case+ hipn2 of HIPempty () => true | _ => false
  )
//
(*
//
// HX-2014-07: [HIPlst] is no longer in use
//
| (HIPlst (_, xs1), _) => (
  case+ hipn2 of
  | HIPlst (_, xs2) => hipatlst_subtest (xs1, xs2) | _ => false
  )
*)
//
| (HIPrec (_, lxs1, _), _) => (
  case+ hipn2 of
  | HIPrec (_, lxs2, _) => labhipatlst_subtest (lxs1, lxs2) | _ => false
  )
//
| (_, _) (*rest-of-hipat-hipat*) => false
//
end // end of [hipat_subtest]

(* ****** ****** *)

implement
hipatlst_subtest
  (xs1, xs2) = let
in
//
case+ xs1 of
| list_cons
    (x1, xs1) => (
  case+ xs2 of
  | list_cons (x2, xs2) =>
    (
      if hipat_subtest (x1, x2)
        then hipatlst_subtest (xs1, xs2) else false
      // end of [if]
    )
  | list_nil () => false
  )
| list_nil () => (
  case+ xs2 of list_cons _ => false | list_nil () => true
  )
//
end // end of [hipatlst_subtest]

(* ****** ****** *)

local

fun labhipat_subtest
(
  lx1: labhipat, lx2: labhipat
) : bool = let
//
val+LABHIPAT (l1, x1) = lx1
val+LABHIPAT (l2, x2) = lx2
//
in
  if l1 = l2 then hipat_subtest (x1, x2) else false
end // end of [labhipat_subtest]

in (* in of [local] *)

implement
labhipatlst_subtest
  (lxs1, lxs2) = let
in
//
case+ lxs1 of
| list_cons
    (lx1, lxs1) => (
  case+ lxs2 of
  | list_cons (lx2, lxs2) =>
    (
      if labhipat_subtest (lx1, lx2)
        then labhipatlst_subtest (lxs1, lxs2) else false
      // end of [if]
    )
  | list_nil () => false
  )
| list_nil () => (
  case+ lxs2 of list_cons _ => false | list_nil () => true
  )
//
end // end of [labhipatlst_subtest]

end // end of [local]

(* ****** ****** *)
//
implement
hidexp_is_empty
  (x0) = let
(*
val () =
println!
(
"hidexp_is_empty: x0 = ", x0
) (* println! *)
*)
in
//
case+
x0.hidexp_node
of (* case+ *)
| HDEempty() => true
| HDEfoldat() => true
| HDEseq(hdes) => hidexplst_isall_empty(hdes)
| _ (*rest-of-hidexp*) => false
//
end // end of [hidexp_is_empty]
//
implement
hidexplst_isall_empty
  (xs) = list_forall_fun(xs, hidexp_is_empty)
implement
hidexplst_isexi_empty
  (xs) = list_exists_fun(xs, hidexp_is_empty)
//
(* ****** ****** *)

local

fun
hidexplst_is_value
  (xs: hidexplst): bool =
  list_forall_fun (xs, hidexp_is_value)
// end of [hidexplst_is_value]

fun
labhidexplst_is_value
  (lxs: labhidexplst): bool = let
//
fun ftest (lx: labhidexp) = let
  val LABHIDEXP (l, x) = lx in hidexp_is_value (x)
end // end of [fun]
//
in
  list_forall_fun (lxs, ftest)
end // end of [labhidexplst_is_value]

fun
hidecl_is_value
  (hid0: hidecl): bool = let
in
//
case+
hid0.hidecl_node
of // case+
| HIDnone() => true
//
| HIDlist(hids) =>
    hideclist_is_value(hids)
//
| HIDfundecs _ => true
| HIDvaldecs
    (_, hvds) => hivaldecs_is_value(hvds)
  // end of [HIDvaldecs]
//
| _(*rest-of-hidecl*) => false
//
end // end of [hidecl_is_value]

and
hideclist_is_value
  (hids: hideclist): bool =
  list_forall_fun(hids, hidecl_is_value)
// end of [hideclist_is_value]

and
hivaldec_is_value
  (hvd: hivaldec): bool =
  hidexp_is_value(hvd.hivaldec_def)
//
and
hivaldecs_is_value
  (hvds: hivaldeclst): bool =
  list_forall_fun(hvds, hivaldec_is_value)

in (* in of [local] *)

implement
hidexp_is_value
  (hde0) = let
in
//
case+
hde0.hidexp_node
of // case+
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
  | HDElet(hids, hde) =>
    if hideclist_is_value(hids) then hidexp_is_value(hde) else false
//
  | _ (*rest-of-hidexp*) => false
//
end // end of [hidexp_is_value]

end // end of [local]

(* ****** ****** *)

local

fun
auxseq
(
  hde, hdes: hidexplst
) : bool =
(
  case+ hdes of
  | list_nil () => hidexp_is_lvalue (hde)
  | list_cons (hde, hdes) => auxseq (hde, hdes)
) (* end of [auxseq] *)

in (*in-of-local*)

implement
hidexp_is_lvalue
  (hde0) = let
in
//
case+ hde0.hidexp_node of
| HDEvar (d2v) =>
    $D2E.d2var_is_mutabl (d2v)
| HDEselvar (d2v, _, _) =>
    $D2E.d2var_is_mutabl (d2v)
| HDEselptr (hde, _, _) => true
//
| HDEseq (hdes) =>
  (
    case+ hdes of
    | list_cons (hde, hdes) => auxseq (hde, hdes) | list_nil () => false
  ) (* end of [HDEseq] *)
//
| _ (* non-lvalue *) => false
//
end // end of [hidexp_is_lvalue]

end // end of [local]

(* ****** ****** *)

(*
implement
un_hidexp_int (hde) =
(
case+ hde.hidexp_node of
| HDEint (int) => Some_vt (int)
| HDEi0nt (tok) =>
| _(*noninteger*) => None_vt((*void*))
) (* end of [un_hidexp_int] *)
*)

(* ****** ****** *)

implement
hidecl_is_empty (hid) = let
in
//
case+
  hid.hidecl_node of
//
| HIDnone () => true
//
| HIDlist (xs) => list_is_nil (xs)
//
| HIDfundecs (_, _, xs) => list_is_nil (xs)
//
| HIDvaldecs (_, xs) => list_is_nil (xs)
| HIDvaldecs_rec (_, xs) => list_is_nil (xs)
(*
| HIDvardecs (xs) => list_is_nil (xs)
*)
| _ (* rest-of-hidecl *) => false
//
end // end of [hidecl_is_empty]

(* ****** ****** *)

implement
hidexp_seq_simplify
  (loc, hse0, hdes) = let
//
val isexi =
  hidexplst_isexi_empty(hdes)
//
val hdes = (
//
if
isexi
then let
//
val
hdes =
list_filter_fun
( hdes
, lam(x) =<1>
  not(hidexp_is_empty(x))
) (* list_filter_fun *)
//
in
  list_of_list_vt{hidexp}(hdes)
end // end of [then]
else hdes // end of [else]
//
) : hidexplst // end of [val]
//
in
  case+ hdes of
  | list_cons
      (hde, list_nil()) => hde
    // list_sing
  | _(* non-singleton *) => hidexp_seq(loc, hse0, hdes)
end // end of [hidexp_seq_simplify]

(* ****** ****** *)

local

typedef d2var = $D2E.d2var

datavtype
hdevaremp =
  | HDEVEnone of ()
  | HDEVEsome_var of (d2var)
  | HDEVEsome_emp of ((*void*))
// end of [hdevaremp]

fun hidexp_is_varemp
  (hde0: hidexp): hdevaremp = let
in
//
case+ hde0.hidexp_node of
| HDEvar d2v => HDEVEsome_var (d2v)
| HDEempty () => HDEVEsome_emp ((*void*))
| HDEfoldat () => HDEVEsome_emp ((*void*))
| HDErec (knd, lhdes, _) =>
  (
    if knd = 0 then (
      case+ lhdes of
      | list_cons (lhde, list_nil ()) => let
          val+LABHIDEXP (lab, hde) = lhde in hidexp_is_varemp (hde)
        end  // end of [list_cons (_, list_nil)]
      | _ => HDEVEnone ()
    ) else HDEVEnone () // end of [if]
  ) (* end of [HIErec] *)
| _ => HDEVEnone ((*void*))
//
end // end of [hidexp_is_varemp]

datavtype
hianybind =
  | HABNDnone of ()
  | HABNDsome_any of hidexp
  | HABNDsome_var of (d2var, hidexp)
  | HABNDsome_emp of hidexp

fun hidecl_is_anybind
  (hid0: hidecl): hianybind = let
//
fun aux
(
  hip0: hipat, hde: hidexp
) : hianybind = let
in
//
case+
hip0.hipat_node
of (* case+ *)
| HIPany _ => HABNDsome_any (hde)
| HIPvar (d2v) => HABNDsome_var (d2v, hde)
| HIPempty () => HABNDsome_emp (hde)
| HIPrec
  (
    knd, lhips, hse_rec
  ) => (
    if knd = 0 then (
      case+ lhips of
      | list_cons (lhip, list_nil ()) =>
          let val+LABHIPAT (lab, hip) = lhip in aux (hip, hde) end
      | _ => HABNDnone ()
    ) else HABNDnone () // end of [if]
  ) (* end of [HIPrec] *)
| _ => HABNDnone ((*void*))
//
end // end of [aux]
//
in
//
case+
hid0.hidecl_node
of (* case+ *)
| HIDvaldecs
    (_, hvds) => (
  case+ hvds of
  | list_cons (
      hvd, list_nil ()
    ) => aux(hvd.hivaldec_pat, hvd.hivaldec_def)
  | _ => HABNDnone ((*void*))
  ) (* end of [HIDvaldecs] *)
| _ (*non-HIDvaldecs*) => HABNDnone((*void*))
//
end // end of [hidecl_is_anybind]

fun dropz{n:pos}
(
  xs: list (hidecl, n)
) : list (hidecl, n-1) = let
//
val+list_cons (x, xs1) = xs
//
in
//
case+ xs1 of
| list_cons _ =>
    list_cons (x, dropz (xs1))
| list_nil () => list_nil ()
//
end // end of [dropz]

in (* in of [local] *)

implement
hidexp_let_simplify
  (loc, hse, hids, hde) = let
in
//
case+ hids of
//
| list_cons _ => let
    val opt = hidexp_is_varemp (hde)
  in
    case+ opt of
    | ~HDEVEsome_var (d2v) => let
        val hid = list_last (hids)
        val opt2 = hidecl_is_anybind (hid)
      in
        case+ opt2 of
        | ~HABNDnone () =>
            hidexp_let (loc, hse, hids, hde) 
        | ~HABNDsome_var
            (d2v2, hde2) =>
            if not(d2v=d2v2)
              then hidexp_let (loc, hse, hids, hde)
              else hidexp_let (loc, hse, dropz(hids), hde2)
            // end of [if]
        | ~HABNDsome_any _ => hidexp_let (loc, hse, hids, hde)
        | ~HABNDsome_emp _ => hidexp_let (loc, hse, hids, hde)
      end // end of [HDEVEsome_var]        
    | ~HDEVEsome_emp ((*void*)) => let
        val hid = list_last (hids)
        val opt2 = hidecl_is_anybind (hid)
      in
        case+ opt2 of
        | ~HABNDnone () =>
            hidexp_let (loc, hse, hids, hde)
        | ~HABNDsome_emp (hde2) =>
            hidexp_let (loc, hse, dropz (hids), hde2)
          // end of [HABNDsome_emp]
        | ~HABNDsome_any _ => hidexp_let (loc, hse, hids, hde)
        | ~HABNDsome_var _ => hidexp_let (loc, hse, hids, hde)
      end // end of [HDEVEsome_emp]
    | ~HDEVEnone () => hidexp_let (loc, hse, hids, hde)
  end // end of [list_cons]
//
| list_nil ((*void*)) => hde
//
end // end of [hidexp_let_simplify]

end // end of [local]

(* ****** ****** *)

(* end of [pats_hidynexp_util.dats] *)
