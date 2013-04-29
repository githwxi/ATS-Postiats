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

(*
** Start Time: April, 2013
**
** Author: William Blair 
** Authoremail: wdblair AT bu DOT edu
**
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
*)

(* ****** ****** *)
//
#ifndef
ATSCNTRB_SML_Z3_Z3_HEADER
#include "./z3_header.sats"
#endif
//
(* ****** ****** *)

(*
Z3_symbol
Z3_mk_int_symbol (__in Z3_context c, __in int i)
Create a Z3 symbol using an integer.
*)
fun Z3_mk_int_symbol
  (ctx: !Z3_context, i: int): Z3_symbol = "mac#%"
// end of [Z3_mk_int_symbol]
   
(*
Z3_symbol
Z3_mk_string_symbol (__in Z3_context c, __in Z3_string s)
Create a Z3 symbol using a C string.
*)
fun Z3_mk_string_symbol
  (ctx: !Z3_context, str: Z3_string): Z3_symbol = "mac#%"
// end of [Z3_mk_string_symbol]

(* ****** ****** *)

(* end of [z3_symbol.sats] *)
