(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: October, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_staexp2_error.sats"

(* ****** ****** *)

local

#define MAXLEN 100
#assert (MAXLEN > 0)

val the_length = ref<int> (0)
val the_staerrlst = ref<staerrlst_vt> (list_vt_nil)

in // in of [local]

implement
the_staerrlst_clear
  () = () where {
  val () = !the_length := 0
  val () = () where {
    val (vbox pf | p) = ref_get_view_ptr (the_staerrlst)
    val () = list_vt_free (!p)
    val () = !p := list_vt_nil ()
  } // end of [val]
} // end of [the_staerrlst_clear]

implement
the_staerrlst_add
  (err) = () where {
  val n = let
    val (vbox pf | p) = ref_get_view_ptr (the_length)
    val n = !p
    val () = !p := n + 1
  in n end // end of [val]
  val () = if n < MAXLEN then let
    val (vbox pf | p) = ref_get_view_ptr (the_staerrlst)
  in
    !p := list_vt_cons (err, !p)
  end // end of [val]
} // end of [the_staerrlst_add]

implement
the_staerrlst_get
  (n) = xs where {
  val () = n := !the_length
  val () = !the_length := 0
  val (vbox pf | p) = ref_get_view_ptr (the_staerrlst)
  val xs = !p
  val xs = list_vt_reverse (xs)
  val () = !p := list_vt_nil ()
} // end of [the_staerrlst_get]

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_error.dats] *)
