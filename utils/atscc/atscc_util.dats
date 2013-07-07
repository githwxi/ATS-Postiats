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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "./atscc.sats"

(* ****** ****** *)

#define
ATSOPT_DEFAULT "patsopt"

implement
{}(*tmp*)
atsopt_get () = let
//
val def =
  $STDLIB.getenv_gc ("ATSOPT")
//
in
//
if strptr2ptr (def) > 0
  then strptr2string (def)
  else let
    prval () = strptr_free_null (def)
  in
    ATSOPT_DEFAULT
  end (* end of [if] *)
// end of [if]
//
end // end of [atsopt_get]

(* ****** ****** *)

#define
ATSCCOMP_DEFAULT "\
gcc -std=c99 -D_XOPEN_SOURCE\
"
implement
{}(*tmp*)
atsccomp_get () = let
//
val def =
  $STDLIB.getenv_gc ("ATSCCOMP")
//
in
//
if strptr2ptr (def) > 0
  then strptr2string (def)
  else let
    prval () = strptr_free_null (def)
  in
    ATSCCOMP_DEFAULT
  end (* end of [if] *)
// end of [if]
//
end // end of [atsccomp_get]
  
(* ****** ****** *)

(* end of [atscc_util.dats] *)
