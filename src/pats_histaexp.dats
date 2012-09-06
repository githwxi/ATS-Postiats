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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

val HITYPE_ABS = HITYPE (0(*non*), "atstype_abs")
val HITYPE_PTR = HITYPE (0(*non*), "atstype_ptr")
val HITYPE_REF = HITYPE (1(*ptr*), "atstype_ref")
//
val HITYPE_FUNPTR = HITYPE (1(*ptr*), "atstype_funptr")
val HITYPE_CLOPTR = HITYPE (1(*ptr*), "atstype_cloptr")
//
val HITYPE_TYCLO = HITYPE (0(*non*), "atstype_tyclo")
//
val HITYPE_TYCST = HITYPE (0(*non*), "atstype_tycst")
val HITYPE_TYVAR = HITYPE (0(*non*), "atstype_tyvar")
//
val HITYPE_VARARG = HITYPE (0(*non*), "atstype_vararg")
//
val HITYPE_ERROR = HITYPE (0(*non*), "atstype_error")

(* ****** ****** *)

val hisexp_typtr = '{
  hisexp_name= HITYPE_PTR, hisexp_node= HSEtyptr ()
}
val hisexp_tyabs = '{
  hisexp_name= HITYPE_ABS, hisexp_node= HSEtyabs ()
}

(* ****** ****** *)

fun hisexp_make_node (
  hit: hitype, node: hisexp_node
) : hisexp = '{
  hisexp_name= hit, hisexp_node= node
} // end of [hisexp_make_node]

(* ****** ****** *)

implement
hisexp_make_srt (s2t) =
  if s2rt_is_boxed (s2t) then hisexp_typtr else hisexp_tyabs
// end of [hisexp_make_srt]

(* ****** ****** *)

implement
hisexp_fun
  (fc, arg, res) =
  hisexp_make_node (HITYPE_FUNPTR, HSEfun (fc, arg, res))
// end of [hisexp_fun]

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
hisexp_tyclo (fl) =
  hisexp_make_node (HITYPE_TYCLO, HSEtyclo (fl))
// end of [hisexp_tyclo]

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
hisexp_vararg () = '{
  hisexp_name= HITYPE_VARARG, hisexp_node= HSEvararg ()
} // end of [hisexp_vararg]

(* ****** ****** *)

implement
hisexp_s2exp (loc, s2e) =
  hisexp_make_node (HITYPE_ERROR, HSEs2exp (loc, s2e))
// end of [hisexp_s2exp]

(* ****** ****** *)

(* end of [pats_histaexp.dats] *)
