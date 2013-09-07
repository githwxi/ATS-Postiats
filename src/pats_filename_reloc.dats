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
// Start Time: September, 2013
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)

typedef
pkginfo = @{
//
  pkgname=string
, pkgauthor=stropt
, pkgauthoremail=stropt
, pkgsrcloc=string
, pkgdstloc=stropt
//
} (* end of [pkginfo] *)

(* ****** ****** *)

implement
$FIL.pkgsrcname_relocatize
  (given, ngurl) = let
//
extern
fun PATSHOME_get (): string = "ext#patsopt_PATSHOME_get"
extern
fun PATSHOMERELOC_get (): Stropt = "ext#patsopt_PATSHOMERELOC_get"
//
in
//
if ngurl >= 0 then let
  val p0 = $UN.cast2ptr (given)
  val pn = add_ptr_int (p0, ngurl)
  val opt = PATSHOMERELOC_get ()
  val direloc =
  (
    if stropt_is_some (opt)
      then stropt_unsome (opt) else PATSHOME_get ()
    // end of [if]
  ) : string // end of [val]
  val dirsep = $FIL.theDirSep_get ()
  val given2 = $UT.dirpath_append (direloc, $UN.cast{string}(pn), dirsep)
//
  val () = println! ("pkgsrcname_relocatize: given2 = ", given2)
//
in
  string_of_strptr (given2)
end else given // end of [if]
//
end // end of [pkgsrcname_relocatize]

(* ****** ****** *)

(* end of [pats_filename_reloc.sats] *)


