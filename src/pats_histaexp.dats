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
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

#define ATSTYPE_PTR "atstype_ptr"
#define ATSTYPE_ABS "atstype_abs"
#define ATSTYPE_REF "atstype_ref"
#define ATSTYPE_VOID "atstype_void"

(* ****** ****** *)
//
val HITYPE_PTR =
  HITYPE (1(*non*), 1(*fin*), ATSTYPE_PTR)
val HITYPE_ABS =
  HITYPE (0(*non*), 1(*fin*), ATSTYPE_ABS)
val HITYPE_REF =
  HITYPE (1(*ptr*), 1(*fin*), ATSTYPE_REF)
//
val HITYPE_APP =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyapp")
val HITYPE_CLO =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyclo")
//
val HITYPE_FUNPTR =
  HITYPE (1(*ptr*), 1(*fin*), "atstype_funptr")
val HITYPE_CFUNPTR =
  HITYPE (1(*ptr*), 1(*fin*), "atstype_cfunptr")
val HITYPE_CLOPTR =
  HITYPE (1(*ptr*), 1(*fin*), "atstype_cloptr")
//
val HITYPE_CONPTR =
  HITYPE (1(*ptr*), 1(*fin*), "atstype_conptr")
//
val HITYPE_TYARR =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyarr")
val HITYPE_TYREC =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyrec")
val HITYPE_TYRECSIN =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyrecsin")
val HITYPE_TYSUM =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tysum")
//
val HITYPE_TYVAR =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyvar")
val HITYPE_TYVARET =
  HITYPE (0(*non*), 0(*tmp*), "atstype_tyvaret")
//
val HITYPE_VARARG =
  HITYPE (0(*non*), 0(*tmp*), "atstype_vararg")
//
val HITYPE_S2EXP =
  HITYPE (0(*non*), 0(*tmp*), "atstype_s2exp")
//
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
hisexp_tyclo = let
  val sym = $SYM.symbol_empty
in '{
  hisexp_name= HITYPE_CLO, hisexp_node= HSEtyabs (sym)
} end // end of [hisexp_tyclo]

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
hisexp_make_srtsym
  (s2t, sym) = let
  val isbox = s2rt_is_boxed_fun (s2t)
in
  if isbox then hisexp_typtr else hisexp_tyabs (sym)
end // end of [hisexp_make_srtsym]

(* ****** ****** *)

implement
hisexp_fun
  (fc, arg, res) =
  hisexp_make_node (HITYPE_FUNPTR, HSEfun (fc, arg, res))
// end of [hisexp_fun]

(* ****** ****** *)

implement
hisexp_app
  (_fun, _arg) =
  hisexp_make_node (HITYPE_APP, HSEapp (_fun, _arg))
// end of [hisexp_app]

(* ****** ****** *)

implement
hisexp_extype
  (name, s2ess) = let
  val hit = HITYPE(0(*non*), 1(*fin*), name)
in
  hisexp_make_node (hit, HSEextype (name, s2ess))
end // end of [hisexp_extype]

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

fun aux (
  sub: !stasub, hse0: hisexp, flag: &int
) : hisexp = let
in
//
case+
  hse0.hisexp_node
of // of [case]
//
| HSEtyptr _ => hse0
| HSEtyabs _ => hse0
//
| HSEfun (fc, hses_arg, hse_res) => let
    val flag0 = flag
    val hses_arg = auxlst (sub, hses_arg, flag)
    val hse_res = aux (sub, hse_res, flag)
  in
    if flag > flag0
      then hisexp_fun (fc, hses_arg, hse_res) else hse0
    // end of [if]
  end // end of [HSEfun]
//
| HSEcfun _ => hse0
//
| HSEapp (hse_fun, hses_arg) => let
    val flag0 = flag
    val hse_fun = aux (sub, hse_fun, flag)
    val hses_arg = auxlst (sub, hses_arg, flag)
  in
    if flag > flag0 then hisexp_app (hse_fun, hses_arg) else hse0
  end // end of [HSEapp]
//
| HSEextype (name, hsess) => let
    val flag0 = flag
    val hsess = auxlstlst (sub, hsess, flag)
  in
    if flag > flag0 then hisexp_extype (name, hsess) else hse0
  end // end of [HSEextype]
//
| HSErefarg (knd, hse) => let
    val flag0 = flag
    val hse = aux (sub, hse, flag)
  in
    if flag > flag0 then hisexp_refarg (knd, hse) else hse0
  end // end of [HSErefarg]
//
(*
| HSEtyarr (hisexp, s2explst) // for arrays
| HSEtyrec of (tyreckind, labhisexplst) // for records
| HSEtyrecsin of (labhisexp) // for singleton records
| HSEtysum of (d2con, hisexplst) // for tagged unions
*)
//
| HSEtyvar (s2v) => let
    val ans = stasub_find (sub, s2v)
  in
    case+ ans of
    | ~Some_vt (s2e) => let
        val () = flag := flag + 1 in hisexp_s2exp (s2e)
      end // end of [Some_vt]
    | ~None_vt () => hse0
  end // end of [HSEtyvar]
//
| HSEvararg (s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then hisexp_vararg (s2e) else hse0
  end // end of [HSEvararg]
//
| HSEs2exp (s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then hisexp_s2exp (s2e) else hse0
  end // end of [HSEs2exp]
//
| _ => hse0
//
end // end of [aux]

and auxlst (
  sub: !stasub, hses0: hisexplst, flag: &int
) : hisexplst = let
in
//
case+ hses0 of
| list_cons
    (hse, hses) => let
    val flag0 = flag
    val hse = aux (sub, hse, flag)
    val hses = auxlst (sub, hses, flag)
  in
    if flag > flag0 then list_cons (hse, hses) else hses0
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]

and auxlstlst (
  sub: !stasub, hsess0: hisexplstlst, flag: &int
) : hisexplstlst = let
in
//
case+ hsess0 of
| list_cons
    (hses, hsess) => let
    val flag0 = flag
    val hses = auxlst (sub, hses, flag)
    val hsess = auxlstlst (sub, hsess, flag)
  in
    if flag > flag0 then list_cons (hses, hsess) else hsess0
  end // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [auxlstlst]

in // in of [local]

implement
hisexp_subst
  (sub, hse0) = let
  var flag: int = 0 in aux (sub, hse0, flag)
end // end of [hisexp_subst]

end // end of [local]

(* ****** ****** *)

(* end of [pats_histaexp.dats] *)
