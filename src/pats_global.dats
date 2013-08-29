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
// Start Time: August, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_global.sats"

(* ****** ****** *)

#include "./pats_params.hats"

(* ****** ****** *)

local

val the_PACKNAME = ref<Stropt> (stropt_none)

in (* in of [local] *)

implement the_PACKNAME_get () = !the_PACKNAME

implement
the_PACKNAME_set (opt) = !the_PACKNAME := opt

end // end of [local]

implement
the_PACKNAME_set_name
  (ns) = the_PACKNAME_set (stropt_some (ns))
// end of [the_PACKNAME_set]
implement
the_PACKNAME_set_none
  ((*none*)) = the_PACKNAME_set (stropt_none)
// end of [the_PACKNAME_set_none]

(* ****** ****** *)

local

val the_STALOADFLAG = ref<int> (1)
val the_DYNLOADFLAG = ref<int> (1)

in (* in of [local] *)

implement the_STALOADFLAG_get () = !the_STALOADFLAG
implement the_STALOADFLAG_set (flag) = !the_STALOADFLAG := flag

implement the_DYNLOADFLAG_get () = !the_DYNLOADFLAG
implement the_DYNLOADFLAG_set (flag) = !the_DYNLOADFLAG := flag

end // end of [local]

(* ****** ****** *)

local

val the_MAINATSFLAG = ref<int> (0)

in (* in of [local] *)

implement the_MAINATSFLAG_get () = !the_MAINATSFLAG
implement the_MAINATSFLAG_set (flag) = !the_MAINATSFLAG := flag

end // end of [local]

(* ****** ****** *)

local

typedef dirlst = List (string)

val the_IATS_dirlst = ref<dirlst> (list_nil ())

in // in of [local]

implement
the_IATS_dirlst_get () = !the_IATS_dirlst

implement
the_IATS_dirlst_ppush
  (dir) = let
  val dirs = !the_IATS_dirlst
in
  !the_IATS_dirlst := list_cons (dir, dirs)
end // end of [the_IATS_dirlst_ppush]

end // end of [local]

(* ****** ****** *)

local

val rdbgflag = ref<int> (0)

in // in of [local]

implement
the_DEBUGATS_dbgflag_get () = !rdbgflag
implement
the_DEBUGATS_dbgflag_set (flag) = !rdbgflag := flag

end // end of [local]

(* ****** ****** *)

local

val rdbgline = ref<int> (0)

in // in of [local]

implement
the_DEBUGATS_dbgline_get () = !rdbgline
implement
the_DEBUGATS_dbgline_set (flag) = !rdbgline := flag

end // end of [local]

(* ****** ****** *)

local

val rmaxtmprecdepth = ref<int> (CCOMPENV_MAXTMPRECDEPTH)

in // in of [local]

implement
the_CCOMPENV_maxtmprecdepth_get () = !rmaxtmprecdepth
implement
the_CCOMPENV_maxtmprecdepth_set (mtd) = !rmaxtmprecdepth := mtd

end // end of [local]

(* ****** ****** *)

(* end of [pats_global.dats] *)
