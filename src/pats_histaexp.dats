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
// Start Time: July, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

#define ATSTYPE_PTR "atstype_ptr"
#define ATSTYPE_ABS "atstype_abs"
#define ATSTYPE_REF "atstype_ref"
#define ATSTYPE_VOID "atstype_void"

(* ****** ****** *)
//
val HITYPE_PTR = HITYPE (1(*non*), ATSTYPE_PTR)
val HITYPE_ABS = HITYPE (0(*non*), ATSTYPE_ABS)
val HITYPE_REF = HITYPE (1(*ptr*), ATSTYPE_REF)
//
val HITYPE_APP = HITYPE (0(*non*), "atstype_tyapp")
val HITYPE_CLO = HITYPE (0(*non*), "atstype_tyclo")
//
val HITYPE_FUNPTR = HITYPE (1(*ptr*), "atstype_funptr")
val HITYPE_CFUNPTR = HITYPE (1(*ptr*), "atstype_cfunptr")
val HITYPE_CLOPTR = HITYPE (1(*ptr*), "atstype_cloptr")
//
val HITYPE_CONPTR = HITYPE (1(*ptr*), "atstype_conptr")
//
val HITYPE_TYARR = HITYPE (0(*non*), "atstype_tyarr")
val HITYPE_TYREC = HITYPE (0(*non*), "atstype_tyrec")
val HITYPE_TYRECSIN = HITYPE (0(*non*), "atstype_tyrecsin")
val HITYPE_TYSUM = HITYPE (0(*non*), "atstype_tysum")
//
val HITYPE_TYVAR = HITYPE (0(*non*), "atstype_tyvar")
val HITYPE_TYVARET = HITYPE (0(*non*), "atstype_tyvaret")
//
val HITYPE_VARARG = HITYPE (0(*non*), "atstype_vararg")
//
val HITYPE_S2EXP = HITYPE (0(*non*), "atstype_s2exp")

(* ****** ****** *)

implement
hisexp_is_void
  (hse0) = let
in
//
case+ hse0.hisexp_node of
(*
| HSEextype (name, _(*arglst*)) => (
  case+ 0 of
  | _ when name = ATSTYPE_VOID => true
  | _ => false
  ) (* end of [HSEextype] *)
*)
| HSEtyrecsin (lhse) => let
    val HSLABELED (_, _, hse) = lhse in hisexp_is_void (hse)
  end // end of [HSEtyrecsin]
//
| _ => false
//
end // end of [hityp_is_void]

(* ****** ****** *)

implement
hisexp_typtr = '{
  hisexp_name= HITYPE_PTR, hisexp_node= HSEtyptr ()
}

implement
hisexp_tyclo = '{
  hisexp_name= HITYPE_CLO, hisexp_node= HSEtyabs ($SYM.symbol_empty)
} // end of [hisexp_tyclo]

implement
hisexp_typtr_fun = '{
  hisexp_name= HITYPE_FUNPTR, hisexp_node= HSEtyptr ()
}
implement
hisexp_typtr_clo = '{
  hisexp_name= HITYPE_CLOPTR, hisexp_node= HSEtyptr ()
}

implement
hisexp_typtr_con = '{
  hisexp_name= HITYPE_CONPTR, hisexp_node= HSEtyptr ()
}

(* ****** ****** *)

fun hisexp_make_node (
  hit: hitype, node: hisexp_node
) : hisexp = '{
  hisexp_name= hit, hisexp_node= node
} // end of [hisexp_make_node]

(* ****** ****** *)

implement
hisexp_tyabs (sym) =
  hisexp_make_node (HITYPE_ABS, HSEtyabs (sym))
// end of [hisexp_tyabs]

(* ****** ****** *)

implement
hisexp_varetize
  (hse) = let
  val node = hse.hisexp_node
in
//
case+ node of
| HSEtyvar (s2v) =>
    hisexp_make_node (hse.hisexp_name, node)
| _ => hse // end of [_]
//
end // end of [hityp_varetize]

(* ****** ****** *)

implement
hisexp_make_srt (s2t) =
  hisexp_make_srtsym (s2t, $SYM.symbol_empty)
(* end of [hisexp_make_srt]*)

implement
hisexp_make_srtsym (s2t, sym) =
  if s2rt_is_boxed_fun (s2t) then hisexp_typtr else hisexp_tyabs (sym)
// end of [hisexp_make_srtsym]

(* ****** ****** *)

implement
hisexp_fun
  (fc, arg, res) =
  hisexp_make_node (HITYPE_FUNPTR, HSEfun (fc, arg, res))
// end of [hisexp_fun]

(* ****** ****** *)

implement
hisexp_app
  (_fun, _arg) = hisexp_make_node (HITYPE_APP, HSEapp (_fun, _arg))
// end of [hisexp_app]

(* ****** ****** *)

implement
hisexp_refarg
  (knd, arg) = let
  val name = (
    if knd > 0 then HITYPE_REF else arg.hisexp_name
  ) : hitype // end of [val]
in '{
  hisexp_name= name, hisexp_node= HSErefarg (knd, arg)
} end // end of [hisexp_refarg]

(* ****** ****** *)

implement
hisexp_cfun (fl) =
  hisexp_make_node (HITYPE_CFUNPTR, HSEcfun (fl))
// end of [hisexp_cfun]

(* ****** ****** *)

implement
hisexp_tyarr (hse, dim) =
  hisexp_make_node (HITYPE_TYARR, HSEtyarr (hse, dim))
// end of [hisexp_tyarr]

(* ****** ****** *)

implement
hisexp_tyrec (knd, lhses) =
  hisexp_make_node (HITYPE_TYREC, HSEtyrec (knd, lhses))
// end of [hisexp_tyrec]

implement
hisexp_tyrecsin (lhse) =
  hisexp_make_node (HITYPE_TYRECSIN, HSEtyrecsin (lhse))
// end of [hisexp_tyrecsin]

(* ****** ****** *)

implement
hisexp_tysum (d2c, hses) =
  hisexp_make_node (HITYPE_TYSUM, HSEtysum (d2c, hses))
// end of [hisexp_tysum]

(* ****** ****** *)

implement
hisexp_tyvar (s2v) = let
  val s2t = s2var_get_srt (s2v)
  val hit = (
    if s2rt_is_boxed (s2t) then HITYPE_PTR else HITYPE_TYVAR
  ) : hitype // end of [val]
in
  hisexp_make_node (hit, HSEtyvar (s2v))
end // end of [hisexp_tyvar]

(* ****** ****** *)

implement
hisexp_vararg (s2e) = '{
  hisexp_name= HITYPE_VARARG, hisexp_node= HSEvararg (s2e)
} // end of [hisexp_vararg]

(* ****** ****** *)

implement
hisexp_s2exp (s2e) =
  hisexp_make_node (HITYPE_S2EXP, HSEs2exp (s2e))
// end of [hisexp_s2exp]

(* ****** ****** *)

local

#define :: list_vt_cons
assume hsesub_viewtype = List_vt @(s2var, s2exp)

in // in of [local]

implement
hsesub_make_nil () = list_vt_nil ()
implement
hsesub_copy (sub) = list_vt_copy (sub)
implement
hsesub_free (sub) = list_vt_free (sub)

(* ****** ****** *)

implement
hisexp_subst (sub, hse) = hse

end // end of [local]

(* ****** ****** *)

(* end of [pats_histaexp.dats] *)
