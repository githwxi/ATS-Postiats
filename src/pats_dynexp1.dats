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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

implement
d1ecl_none (loc) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cnone ()
} // end of [d1ecl_none]

implement
d1ecl_datsrts (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdatsrts (xs)
}

implement
d1ecl_srtdefs (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csrtdefs (xs)
}

(* ****** ****** *)

implement
d1ecl_stacsts (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cstacsts (xs)
}

implement
d1ecl_stacons (loc, knd, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cstacons (knd, xs)
}

implement
d1ecl_stavars (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cstavars (xs)
}

(* ****** ****** *)

implement
d1ecl_sexpdefs (loc, knd, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csexpdefs (knd, xs)
}

implement
d1ecl_saspdec (loc, x) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csaspdec (x)
}

(* ****** ****** *)

implement
d1ecl_datdecs (
  loc, knd, d1cs_datdec, d1cs_sexpdef
) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdatdecs (knd, d1cs_datdec, d1cs_sexpdef)
} // end of [d1ecl_datdecs]

implement
d1ecl_exndecs (loc, d1cs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cexndecs (d1cs)
}

(* ****** ****** *)

implement
d1ecl_dcstdecs (loc, dck, qarg, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdcstdecs (dck, qarg, ds)
} // end of [d1ecl_dcstdecs]

(* ****** ****** *)

implement
d1ecl_local (loc, ds_head, ds_body) = '{
  d1ecl_loc= loc, d1ecl_node= D1Clocal (ds_head, ds_body)
}

(* ****** ****** *)

(* end of [pats_dynexp1.dats] *)
