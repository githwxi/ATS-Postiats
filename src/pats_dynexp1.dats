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
p1at_any (loc) = '{
  p1at_loc= loc, p1at_node= P1Tany ()
}
implement
p1at_anys (loc) = '{
  p1at_loc= loc, p1at_node= P1Tanys ()
}

implement
p1at_ide (loc, id) = let
  val dq = d0ynq_none (loc) in p1at_dqid (loc, dq, id)
end // end of [p1at_ide]
implement
p1at_dqid (loc, dq, id) = '{
  p1at_loc= loc, p1at_node= P1Tdqid (dq, id)
}

implement
p1at_ref (loc, id) = '{
  p1at_loc= loc, p1at_node= P1Tref (id)
}

implement
p1at_int (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tint (x)
}
implement
p1at_char (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tchar (x)
}
implement
p1at_float (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tfloat (x)
}
implement
p1at_string (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tstring (x)
}
implement
p1at_empty (loc) = '{
  p1at_loc= loc, p1at_node= P1Tempty ()
}

implement
p1at_app_dyn (
  loc, _fun, loc_arg, npf, _arg
) = '{
  p1at_loc= loc
, p1at_node= P1Tapp_dyn (_fun, loc_arg, npf, _arg)
} // end of [p1at_app_dyn]

implement
p1at_app_sta
  (loc, _fun, _arg) = '{
  p1at_loc= loc, p1at_node= P1Tapp_sta (_fun, _arg)
} // end of [p1at_app_sta]

implement
p1at_list (loc, npf, p1ts) = '{
  p1at_loc= loc, p1at_node= P1Tlist (npf, p1ts)
}

implement
p1at_lst (loc, p1ts) = '{
  p1at_loc= loc, p1at_node= P1Tlst (p1ts)
}
implement
p1at_tup (loc, knd, npf, p1ts) = '{
  p1at_loc= loc, p1at_node= P1Ttup (knd, npf, p1ts)
}
implement
p1at_rec (loc, knd, npf, lp1ts) = '{
  p1at_loc= loc, p1at_node= P1Trec (knd, npf, lp1ts)
}

implement
p1at_free (loc, p1t) = '{
  p1at_loc= loc, p1at_node= P1Tfree (p1t)
}
implement
p1at_as (loc, id, p1t) = '{
  p1at_loc= loc, p1at_node= P1Tas (id, p1t)
}
implement
p1at_refas (loc, id, p1t) = '{
  p1at_loc= loc, p1at_node= P1Trefas (id, p1t)
}

implement
p1at_exist (loc, arg, p1t) = '{
  p1at_loc= loc, p1at_node= P1Texist (arg, p1t)
}
implement
p1at_svararg (loc, arg) = '{
  p1at_loc= loc, p1at_node= P1Tsvararg (arg)
}

implement
p1at_ann (loc, p1t, ann) = '{
  p1at_loc= loc, p1at_node= P1Tann (p1t, ann)
}

(* ****** ****** *)

implement
d1ecl_none (loc) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cnone ()
} // end of [d1ecl_none]

implement
d1ecl_list (loc, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Clist (ds)
} // end of [d1ecl_list]

(* ****** ****** *)

implement
d1ecl_symintr (loc, ids) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csymintr (ids)
}

implement
d1ecl_symelim (loc, ids) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csymelim (ids)
}

implement
d1ecl_overload (loc, id, qid) = '{
  d1ecl_loc= loc, d1ecl_node= D1Coverload (id, qid)
}

(* ****** ****** *)

implement
d1ecl_e1xpdef (loc, id, def) = '{
  d1ecl_loc= loc, d1ecl_node= D1Ce1xpdef (id, def)
}
implement
d1ecl_e1xpundef (loc, id) = '{
  d1ecl_loc= loc, d1ecl_node= D1Ce1xpundef (id)
}

(* ****** ****** *)

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
d1ecl_classdec (loc, id, sup) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cclassdec (id, sup)
}

(* ****** ****** *)

implement
d1ecl_dcstdecs (loc, dck, qarg, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdcstdecs (dck, qarg, ds)
} // end of [d1ecl_dcstdecs]

(* ****** ****** *)

implement
d1ecl_extcode
  (loc, knd, pos, code) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cextcode (knd, pos, code)
} // end of [d1ecl_extcode]

(* ****** ****** *)

implement
d1ecl_include (loc, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cinclude (ds)
} // end of [d1ecl_include]

(* ****** ****** *)

implement
d1ecl_local (loc, ds_head, ds_body) = '{
  d1ecl_loc= loc, d1ecl_node= D1Clocal (ds_head, ds_body)
}

(* ****** ****** *)

(* end of [pats_dynexp1.dats] *)
