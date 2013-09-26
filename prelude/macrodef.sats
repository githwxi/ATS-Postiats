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
//
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

(* macros in short form *)
//
// [orelse] and [andalso] are declared as infix ops
//
macdef
orelse (x, y) = (if ,(x) then true else ,(y)): bool
macdef
andalso (x, y) = (if ,(x) then ,(y) else false): bool
//
(* ****** ****** *)

macdef assign (lv, rv) = ,(lv) := ,(rv)

(* ****** ****** *)

macdef exitloc (x) = exit_errmsg (,(x), $mylocation)

(* ****** ****** *)

macdef assertloc (x) = assert_errmsg (,(x), $mylocation)

(* ****** ****** *)
//
macdef
assertlocmsg
  (x, msg) = assert_errmsg2 (,(x), $mylocation, ,(msg))
macdef
assertmsgloc
  (x, msg) = assert_errmsg2 (,(x), ,(msg), $mylocation)
//
(* ****** ****** *)

macdef ignoret (x) = let val x = ,(x) in (*nothing*) end

(* ****** ****** *)

macdef foldret (x) = let val x = ,(x) in fold@ (x); x end

(* ****** ****** *)

macdef showlvaltype (x) = pridentity ($showtype ,(x))

(* ****** ****** *)

(* end of [macrodef.sats] *)
