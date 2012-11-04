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
// Start Time: August, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_global.sats"

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

val the_DEBUGATS_dbgflag = ref<int> (0)

in // in of [local]

implement
the_DEBUGATS_dbgflag_get () = !the_DEBUGATS_dbgflag
implement
the_DEBUGATS_dbgflag_set (flag) = !the_DEBUGATS_dbgflag := flag

end // end of [local]

(* ****** ****** *)

local

val the_DEBUGATS_dbgline = ref<int> (0)

in // in of [local]

implement
the_DEBUGATS_dbgline_get () = !the_DEBUGATS_dbgline
implement
the_DEBUGATS_dbgline_set (line) = !the_DEBUGATS_dbgline := line

end // end of [local]

(* ****** ****** *)

(* end of [pats_global.dats] *)
