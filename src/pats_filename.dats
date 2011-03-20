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
// Start Time: March, 2011
//
(* ****** ****** *)

staload SYM = "pats_symbol.sats"
typedef symbol= $SYM.symbol

(* ****** ****** *)

staload "pats_filename.sats"

(* ****** ****** *)

local

#include
"prelude/params_system.hats"
#if SYSTEM_IS_UNIX_LIKE #then
//
val theDirSep: char = '/'
val theCurentDir: string = "./"
val theParentDir: string = "../"
//
#endif

in // in of [local]

implement theDirSep_get () = theDirSep
implement theCurentDir_get () = theCurentDir
implement theParentDir_get () = theParentDir

end // end of [local]

(* ****** ****** *)

assume
filename_type = '{
  filename_name= string
, filename_full= symbol
} // end of [filename]

(* ****** ****** *)

implement
fprint_filename (out, fil) =
  fprint_string (out, fil.filename_name)
// end of [fprint_filename]

implement
print_filename (fil) = fprint_filename (stdout_ref, fil)

(* ****** ****** *)

implement
fprint_filename_full
  (out, fil) = let
  val name = $SYM.symbol_get_name (fil.filename_full)
in
  fprint_string (out, name)
end // end of [fprint_filename_full]

implement
print_filename_full (fil) = fprint_filename_full (stdout_ref, fil)

(* ****** ****** *)

implement
filename_is_relative
  (name) = let
  val name = string1_of_string (name)
  fn aux {n,i:nat | i <= n} (
    name: string n, i: size_t i, dirsep: char
  ) : bool =
    if string_is_at_end (name, i) then true else name[i] != dirsep
  // end of [aux]
  val dirsep = theDirSep_get ()
in
  aux (name, 0, dirsep)
end // [filename_is_relative]

(* ****** ****** *)

implement
filename_none = '{
  filename_name= "", filename_full= $SYM.symbol_empty
} // end of [filename_none]

(* ****** ****** *)

implement
filename_get_current () = filename_none

(* ****** ****** *)

(* end of [pats_filename.dats] *)
