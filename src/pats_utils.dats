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

staload "pats_utils.sats"

(* ****** ****** *)

implement{a}
fprintlst (
  out, xs, sep, fprint
) = let
  fun aux (
    xs: List a, i: int
  ) :<cloref1> void =
    case+ xs of
    | list_cons (x, xs) => let
        val () = if i > 0 then fprint_string (out, sep)
        val () = fprint (out, x)
      in
         aux (xs, i+1)
      end // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [aux]
in
  aux (xs, 0)
end // end of [fprintlst]

(* ****** ****** *)

local
//
staload Q = "libats/SATS/linqueue_arr.sats"
//
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"
//
in

implement
queue_get_strptr1
  (q, st, ln) = let
  val [l:addr]
    (pfgc, pfarr | p) = malloc_gc (ln+1)
  // end of [val]
  prval (pf1, fpf2) =
   __assert (pfarr) where {
   extern prfun __assert {k:nat} (
     pfarr: b0ytes(k+1) @ l
   ) : (
     @[char?][k] @ l, @[char][k] @ l -<lin,prf> bytes(k+1) @ l
   ) (* end of [_assert] *)
  } // end of [prval]
  val () = $Q.queue_copyout<char> (q, st, ln, !p)
  prval () = pfarr := fpf2 (pf1)
  val () = bytes_strbuf_trans (pfarr | p, ln)
in
  strptr_of_strbuf @(pfgc, pfarr | p)
end // end of [queue_get_strptr1]

end // end of [local]

(* ****** ****** *)

(* end of [pats_utils.sats] *)
