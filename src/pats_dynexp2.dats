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

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload LEX = "pats_lexing.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

#include "pats_basics.hats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

typedef s2varset = $UT.lstord (s2var)

val p2at_svs_nil : lstord (s2var) = $UT.lstord_nil ()
val p2at_dvs_nil : lstord (d2var) = $UT.lstord_nil ()

fun p2at_svs_add_svar (
  svs: s2varset, s2v: s2var
) : s2varset = let
in
  $UT.lstord_insert (svs, s2v, compare_s2var_s2var)
end // end of [p2at_svs_add_svar]

implement
p2atlst_svs_union (p2ts) = let
  typedef svs = lstord (s2var)
  val cmp = compare_s2var_s2var
in
  list_fold_left_fun<svs><p2at> (
    lam (svs, p2t) =<1> $UT.lstord_union (svs, p2t.p2at_svs, cmp), p2at_svs_nil, p2ts
  ) // end of [list_fold_left]
end // end of [p2atlst_svs_union]

implement
p2atlst_dvs_union (p2ts) = let
  typedef dvs = lstord (d2var)
  val cmp = compare_d2var_d2var
in
  list_fold_left_fun<dvs><p2at> (
    lam (dvs, p2t) =<1> $UT.lstord_union (dvs, p2t.p2at_dvs, cmp), p2at_dvs_nil, p2ts
  ) // end of [list_fold_left]
end // end of [p2atlst_dvs_union]

(* ****** ****** *)
//
// HX: dynamic patterns
//
(* ****** ****** *)

implement
p2at_make (
  loc, svs, dvs, node
) = '{
  p2at_loc= loc
, p2at_svs= svs, p2at_dvs= dvs
, p2at_node= node
} // end of [p2at_make]

implement
p2at_any (loc) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tany ())
// end of [p2at_any]

implement p2at_anys (loc) = p2at_any (loc)

implement
p2at_var
  (loc, refknd, d2v) = let
  val dvs = $UT.lstord_sing (d2v)
in
  p2at_make (loc, p2at_svs_nil, dvs, P2Tvar (refknd, d2v))
end // end of [p2at_var]

(* ****** ****** *)

implement
p2at_bool (loc, b) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tbool (b))
// end of [p2at_bool]

implement
p2at_int (loc, rep) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tint (rep))
// end of [p2at_int]

implement
p2at_char (loc, c) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tchar (c))
// end of [p2at_char]

implement
p2at_string (loc, str) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tstring (str))
// end of [p2at_string]

implement
p2at_float (loc, rep) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tfloat (rep))
// end of [p2at_float]

(* ****** ****** *)

implement
p2at_empty (loc) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tempty ())
// end of [p2at_empty]

implement
p2at_con (
  loc, freeknd, d2c, sarg, npf, darg
) = let
  val svs = let
    fun aux (res: s2varset, x: s2vararg): s2varset =
      case+ x of
      | S2VARARGone () => res
      | S2VARARGall () => res
      | S2VARARGseq (s2vs) =>
          list_fold_left_fun<s2varset><s2var> (p2at_svs_add_svar, res, s2vs)
        // end of [S2VARARGseq]
    // end of [aux]
  in
    list_fold_left_fun<s2varset><s2vararg> (aux, p2at_svs_nil, sarg)
  end // end of [val]
  val dvs = p2atlst_dvs_union (darg)
in
  p2at_make (loc, svs, dvs, P2Tcon (freeknd, d2c, sarg, npf, darg))
end // end of [p2at_con]

implement
p2at_list
  (loc, npf, p2ts) = let
  val knd = TYTUPKIND_flt in p2at_tup (loc, knd, npf, p2ts)
end // end of [p2at_list]

implement
p2at_lst (loc, p2ts) = let
  val svs = p2atlst_svs_union (p2ts)
  val dvs = p2atlst_dvs_union (p2ts)
in
  p2at_make (loc, svs, dvs, P2Tlst (p2ts))
end // end of [p2at_lst]

implement
p2at_tup
  (loc, knd, npf, p2ts) = let
  val svs = p2atlst_svs_union (p2ts)
  val dvs = p2atlst_dvs_union (p2ts)
in
  p2at_make (loc, svs, dvs, P2Ttup (knd, npf, p2ts))
end // end of [p2at_tup]

implement
p2at_as (loc, refknd, d2v, p2t) = let
  val svs = p2t.p2at_svs
  val dvs = $UT.lstord_insert
    (p2t.p2at_dvs, d2v, compare_d2var_d2var)
  // end of [val]
in
  p2at_make (loc, svs, dvs, P2Tas (refknd, d2v, p2t))
end // end of [p2at_as]

implement
p2at_exist
  (loc, s2vs, p2t) = let
  val svs =
    list_fold_left_fun<s2varset><s2var> (p2at_svs_add_svar, p2t.p2at_svs, s2vs)
  val dvs = p2t.p2at_dvs
in
  p2at_make (loc, svs, dvs, P2Texist (s2vs, p2t))
end // end of [p2at_exist]

implement
p2at_ann (loc, p2t, s2e) =
  p2at_make (loc, p2t.p2at_svs, p2t.p2at_dvs, P2Tann (p2t, s2e))
// end of [p2at_ann]

implement
p2at_err (loc) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Terr ())
// end of [p2at_err]

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

implement
d2exp_make (loc, node) = '{
  d2exp_loc= loc, d2exp_node= node
} // end of [d2exp_make]

implement
d2exp_var (loc, d2v) = d2exp_make (loc, D2Evar (d2v))
implement
d2exp_cst (loc, d2c) = d2exp_make (loc, D2Ecst (d2c))
implement
d2exp_con (loc, d2c, sarg, npf, darg) =
  d2exp_make (loc, D2Econ (d2c, sarg, npf, darg))
// end of [d2exp_con]

implement
d2exp_int (loc, rep) = d2exp_make (loc, D2Eint (rep))
implement
d2exp_char (loc, c) = d2exp_make (loc, D2Echar (c))
implement
d2exp_string (loc, s) = d2exp_make (loc, D2Estring (s))
implement
d2exp_float (loc, rep) = d2exp_make (loc, D2Efloat (rep))

implement
d2exp_i0nt (loc, x) = d2exp_make (loc, D2Ei0nt (x))
implement
d2exp_c0har (loc, x) = d2exp_make (loc, D2Ec0har (x))
implement
d2exp_f0loat (loc, x) = d2exp_make (loc, D2Ef0loat (x))
implement
d2exp_s0tring (loc, x) = d2exp_make (loc, D2Es0tring (x))

implement
d2exp_empty (loc) = d2exp_make (loc, D2Eempty ())

(* ****** ****** *)

implement
d2exp_apps (
  loc, d2e_fun, d2as_arg
) = d2exp_make (loc, D2Eapps (d2e_fun, d2as_arg))

implement
d2exp_app_sta (
  loc0, d2e_fun, s2as
) = begin case+ s2as of
| list_cons _ => let
    val d2a = D2EXPARGsta (s2as)
    val node = (
      case+ d2e_fun.d2exp_node of
      | D2Eapps (d2e_fun, d2as) => let
          val d2as = l2l (list_extend (d2as, d2a))
        in
          D2Eapps (d2e_fun, d2as)
        end
      | _ => D2Eapps (d2e_fun, list_sing (d2a))
    ) : d2exp_node // end of [val]
  in
    d2exp_make (loc0, node)
  end // end of [list_cons]
| list_nil _ => d2e_fun
//
end (* end of [d2exp_app_sta] *)

implement
d2exp_app_dyn (
  loc0
, d2e_fun, loc_arg, npf, darg
) = let
  val d2a = D2EXPARGdyn (loc_arg, npf, darg)
  val node = case+ d2e_fun.d2exp_node of
    | D2Eapps (d2e_fun, d2as) => let
        val d2as = l2l (list_extend (d2as, (d2a)))
      in
        D2Eapps (d2e_fun, d2as)
      end
    | _ => D2Eapps (d2e_fun, list_sing (d2a))
  // end of [val]
in
  d2exp_make (loc0, node)
end // end of [d2exp_app_dyn]

implement
d2exp_app_sta_dyn (
  loc_dyn, loc_sta
, d2e_fun, sarg, loc_arg, npf, darg
) = let
  val d2e_sta =
    d2exp_app_sta (loc_sta, d2e_fun, sarg)
  // end of [val]
in
  d2exp_app_dyn (loc_dyn, d2e_sta, loc_arg, npf, darg)
end // end of [d2exp_app_sta_dyn]

(* ****** ****** *)

implement
d2exp_tup (loc, knd, npf, d2es) =
  d2exp_make (loc, D2Etup (knd, npf, d2es))
// end of [d2exp_tup]

implement
d2exp_let (loc, d2cs, body) =
  d2exp_make (loc, D2Elet (d2cs, body))
implement
d2exp_where (loc, body, d2cs) =
  d2exp_make (loc, D2Ewhere (body, d2cs))

(* ****** ****** *)

implement
d2exp_ann_type (loc, d2e, ann) =
  d2exp_make (loc, D2Eann_type (d2e, ann))
// end of [d2exp_ann_type]

(* ****** ****** *)

implement
d2exp_err (loc) = d2exp_make (loc, D2Eerr ())

(* ****** ****** *)
//
// HX: various declarations
//
(* ****** ****** *)

implement
v2aldec_make (
  loc, p2t, def, ann
) = '{
  v2aldec_loc= loc
, v2aldec_pat= p2t
, v2aldec_def= def
, v2aldec_ann= ann
} // end of [v2aldec_make]

(* ****** ****** *)

implement
d2ecl_none (loc) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cnone ()
}

implement
d2ecl_list (loc, xs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Clist (xs)
}

implement
d2ecl_symintr (loc, ids) = '{
  d2ecl_loc= loc, d2ecl_node= D2Csymintr (ids)
}
implement
d2ecl_symelim (loc, ids) = '{
  d2ecl_loc= loc, d2ecl_node= D2Csymelim (ids)
}

implement
d2ecl_overload (loc, id, def) = '{
  d2ecl_loc= loc, d2ecl_node= D2Coverload (id, def)
}

implement
d2ecl_stavars (loc, xs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cstavars (xs)
}

implement
d2ecl_saspdec (loc, d) = '{
  d2ecl_loc= loc, d2ecl_node= D2Csaspdec (d)
}

implement
d2ecl_extype (loc, name, def) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cextype (name, def)
}

implement
d2ecl_datdec (loc, knd, s2cs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cdatdec (knd, s2cs)
}

implement
d2ecl_exndec (loc, d2cs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cexndec (d2cs)
}

implement
d2ecl_dcstdec (loc, knd, d2cs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cdcstdec (knd, d2cs)
}

implement
d2ecl_valdecs (loc, knd, d2cs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cvaldecs (knd, d2cs)
}

implement
d2ecl_include (loc, d2cs) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cinclude (d2cs)
}

implement
d2ecl_staload (
  loc, idopt, fil, flag, loaded, fenv
) = '{
  d2ecl_loc= loc, d2ecl_node= D2Cstaload (idopt, fil, flag, loaded, fenv)
} // endof [d2ecl_staload]

(* ****** ****** *)

(* end of [pats_dynexp2.dats] *)
