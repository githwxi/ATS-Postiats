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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: July, 2012
//
(* ****** ****** *)

typedef
size_t0ype = g0uint(size_kind)

(* ****** ****** *)

abst@ype
wchar_t0ype = $extype"wchar_t"
abst@ype
ptrdiff_t0ype = $extype"ptrdiff_t"

(* ****** ****** *)

typedef size = size_t0ype
typedef size_t = size_t0ype
typedef wchar = wchar_t0ype
typedef wchar_t = wchar_t0ype
typedef ptrdiff = ptrdiff_t0ype
typedef ptrdiff_t = ptrdiff_t0ype

(* ****** ****** *)

(* end of [stddef.sats] *)
