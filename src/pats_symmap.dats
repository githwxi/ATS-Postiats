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

#define SYMMAP_AVLTREE 1
#define SYMMAP_HTLINPRB 0

(* ****** ****** *)

#assert(SYMMAP_AVLTREE >= 0)
#assert(SYMMAP_AVLTREE <= 1)

(* ****** ****** *)

#assert(SYMMAP_HTLINPRB >= 0)
#assert(SYMMAP_HTLINPRB <= 1)

(* ****** ****** *)

#assert(SYMMAP_AVLTREE+SYMMAP_HTLINPRB==1)

(* ****** ****** *)

#if(SYMMAP_AVLTREE)
#include "./pats_symmap_avltree.hats"
#endif // end of [SYMMAP_AVLTREE]

(* ****** ****** *)

#if(SYMMAP_HTLINPRB)
#include "./pats_symmap_htlinprb.hats" // HX: hashtable for experiment
#endif // end of [SYMMAP_HTLINPRB]
  
(* ****** ****** *)

(* end of [pats_symmap.dats] *)
