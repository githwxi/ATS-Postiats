(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

symintr macislist
symintr macisnil
symintr maciscons
symintr maccar maccdr

(* ****** ****** *)

(* macros in short form *)
//
// [orelse] and [andalso] are declared as infix ops
//
macdef orelse (x, y) = if ,(x) then true else ,(y)
macdef andalso (x, y) = if ,(x) then ,(y) else false
//
(* ****** ****** *)

macdef exitloc (x) = exit_errmsg (,(x), #LOCATION)
macdef assertloc (x) = assert_errmsg (,(x), #LOCATION)

(* ****** ****** *)

macdef ignoret (x) = let val x = ,(x) in (*nothing*) end

(* ****** ****** *)

macdef foldret (x) = let val x = ,(x) in fold@ (x); x end

(* ****** ****** *)

local

macrodef
rec
auxlist
  (xs, y) = (
  if maciscons (xs) then
    `(print ,(maccar xs); ,(auxlist (maccdr xs, y)))
  else y // end of [if]
) // end of [auxlist]

in // in of [local]

macdef
print_mac (xs) = ,(
  if macislist (xs) then auxlist (xs, `()) else `(print ,(xs))
) // end of [print_mac]

macdef
println_mac
  (xs) = ,(
  if macislist (xs)
    then auxlist (xs, `(print_newline())) else `(print ,(xs))
  // end of [if]
) // end of [println_mac]

end // end of [local]

(* ****** ****** *)

(* end of [macrodef.sats] *)
