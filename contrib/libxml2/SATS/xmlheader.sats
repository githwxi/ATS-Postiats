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

(*
** Start Time: August, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

abst@ype xmlChar = $extype"xmlChar"

(* ****** ****** *)

absvtype
xmlStrptr(l:addr) = ptr(l) // xmlChar*
vtypedef xmlStrptr0 = [l:agez] xmlStrptr(l)
vtypedef xmlStrptr1 = [l:addr | l > null] xmlStrptr(l)

castfn xmlStrptr2ptr : {l:addr} xmlStrptr(l) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlDocPtr(l:addr) = ptr(l) // xmlDocPtr
vtypedef xmlDocPtr0 = [l:agez] xmlDocPtr(l)
vtypedef xmlDocPtr1 = [l:addr | l > null] xmlDocPtr(l)

castfn xmlDocPtr2ptr : {l:addr} xmlDocPtr(l) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlNodePtr(l:addr) = ptr(l) // xmlNodePtr
vtypedef xmlNodePtr0 = [l:agez] xmlNodePtr(l)
vtypedef xmlNodePtr1 = [l:addr | l > null] xmlNodePtr(l)

castfn xmlNodePtr2ptr : {l:addr} xmlNodePtr(l) -<> ptr(l)

(* ****** ****** *)

overload ptrcast with xmlStrptr2ptr
overload ptrcast with xmlDocPtr2ptr
overload ptrcast with xmlNodePtr2ptr

(* ****** ****** *)

(* end of [xml_header.sats] *)
