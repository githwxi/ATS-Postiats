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
// Start Time: April, 2011
//
(* ****** ****** *)

exception FatalErrorExn of ()
exception FatalErrorExn_interr of ()

(* ****** ****** *)
//
// HX:
// raising FatalErrorException
//
fun abort{a:viewt@ype}():<!exn> (a)
//
(* ****** ****** *)
//
// HX-2015-01-04:
// raising FatalErrorException_interr
//
fun abort_interr{a:viewt@ype}():<!exn> (a)
//
(* ****** ****** *)
//
exception
PATSOPT_FILENONE_EXN of (string)
//
(* ****** ****** *)
//
exception PATSOPT_FIXITY_EXN of ()
//
(* ****** ****** *)
//
exception PATSOPT_TRANS1_EXN of ()
exception PATSOPT_TRANS2_EXN of ()
exception PATSOPT_TRANS3_EXN of ()
exception PATSOPT_TRANS4_EXN of ()
(*
exception PATSOPT_TYPERASE_EXN of ()
*)
//
(* ****** ****** *)

(* end of [pats_error.sats] *)
