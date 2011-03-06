(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload Q = "pats_queueref.sats"
staload _(*anon*) = "pats_queueref.dats"
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"

(* ****** ****** *)

staload "pats_lexing.sats"

(* ****** ****** *)

#define i2c char_of_int
#define c2i int_of_char

(* ****** ****** *)

implement
lexstate_get_next_char
  (state) = c where {
  val c = state.getchar ()
  val () = state.cur_char := c
//
  val () = if c >= 0 then let
    val () =
      $Q.queueref_enque (state.charbuf, (i2c)c)
    // end of [val]
    val () = state.cur_ntot := state.cur_ntot + 1
    val () = if (c = (c2i)'\n') then let
      val () = state.cur_nlin := state.cur_nlin + 1
      val () = state.cur_noff := 0
    in
      // nothing
    end else let
      val () = state.cur_noff := state.cur_noff + 1
   in
      // nothing
    end (* end of [if] *)
  in
    // nothing
  end // end of [val]    
//
} // end of [lexstate_get_next_char]

(* ****** ****** *)

(* end of [pats_lexing.dats] *)
