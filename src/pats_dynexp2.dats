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
//
// HX: dynamic expressions
//
(* ****** ****** *)

val p2at_svs_nil : lstord (s2var) = $UT.lstord_nil ()
val p2at_dvs_nil : lstord (d2var) = $UT.lstord_nil ()

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

implement
p2at_bool (loc, b) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tbool (b))
// end of [p2at_bool]

implement
p2at_char (loc, c) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tchar (c))
// end of [p2at_char]

implement
p2at_c0har
  (loc, tok) = let
  val- $LEX.T_CHAR (c) = tok.token_node in p2at_char (loc, c)
end // end of [p2at_c0har]

implement
p2at_empty (loc) =
  p2at_make (loc, p2at_svs_nil, p2at_dvs_nil, P2Tempty ())
// end of [p2at_empty]

implement
p2at_con (
  loc, d2c, sarg, npf, darg
) = let
//
  typedef s2varset = lstord (s2var)
  fun p2at_svs_add (
    svs: s2varset, s2v: s2var
  ) : s2varset =
    $UT.lstord_insert (svs, s2v, compare_s2var_s2var)
  // end of [p2at_svs_add]
//
  val svs = let
    fun aux (res: s2varset, x: s2vararg): s2varset =
      case+ x of
      | S2VARARGone () => res
      | S2VARARGall () => res
      | S2VARARGseq (s2vs) =>
          list_fold_left_fun<s2varset><s2var> (p2at_svs_add, res, s2vs)
        // end of [S2VARARGseq]
    // end of [aux]
  in
    list_fold_left_fun<s2varset><s2vararg> (aux, p2at_svs_nil, sarg)
  end // end of [val]
  val dvs = p2atlst_dvs_union (darg)
in
  p2at_make (loc, svs, dvs, P2Tcon (d2c, sarg, npf, darg))
end // end of [p2at_con]

implement
p2at_list
  (loc, npf, p2ts) = let
  val knd = TYTUPKIND_flt in p2at_tup (loc, knd, npf, p2ts)
end // end of [p2at_list]

implement
p2at_tup
  (loc, knd, npf, p2ts) = let
  val svs = p2atlst_svs_union (p2ts)
  val dvs = p2atlst_dvs_union (p2ts)
in
  p2at_make (loc, svs, dvs, P2Ttup (knd, npf, p2ts))
end // end of [p2at_tup]

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
d2exp_i0nt (loc, x) = d2exp_make (loc, D2Ei0nt (x))
implement
d2exp_c0har (loc, x) = d2exp_make (loc, D2Ec0har (x))
implement
d2exp_f0loat (loc, x) = d2exp_make (loc, D2Ef0loat (x))
implement
d2exp_s0tring (loc, x) = d2exp_make (loc, D2Es0tring (x))

implement
d2exp_empty (loc) = d2exp_make (loc, D2Eempty ())

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
