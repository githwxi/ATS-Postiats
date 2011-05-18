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

staload "pats_dynexp2.sats"

(* ****** ****** *)

implement
s2tavar_make (loc, s2v) = '{
  s2tavar_loc= loc, s2tavar_var= s2v
}

implement
s2aspdec_make (loc, s2c, def) = '{
  s2aspdec_loc= loc, s2aspdec_cst= s2c, s2aspdec_def= def
}

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

implement
d2exp_let (loc, d2cs, body) = '{
  d2exp_loc= loc, d2exp_node= D2Elet (d2cs, body)
}

implement
d2exp_where (loc, body, d2cs) = '{
  d2exp_loc= loc, d2exp_node= D2Ewhere (body, d2cs)
}

(* ****** ****** *)

implement
d2exp_ann_type (loc, d2e, ann) = '{
  d2exp_loc= loc, d2exp_node= D2Eann_type (d2e, ann)
}

(* ****** ****** *)
//
// HX: various declarations
//
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
