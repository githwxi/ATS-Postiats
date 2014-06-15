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
// Start Time: May, 2014
//
(* ****** ****** *)

#include "./pats_params.hats"

(* ****** ****** *)

#if
C3NSTRINTKND="intknd" #then
//
#include "./pats_lintprgm_myint_int.dats"
//
#elif
C3NSTRINTKND="gmpknd" #then
//
#include "./pats_lintprgm_myint_gmp.dats"
//
#else
//
#error ("ERROR: pats_lintprgm_myint: [C3NSTRINTKND] is undefined!\n")
//
#endif // end of [#if]

(* ****** ****** *)

(* end of [pats_lintprgm_myint.dats] *)
