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
** Source:
** $PATSHOME/prelude/SATS/CODEGEN/list.atxt
** Time of generation: Tue Jun 19 17:49:57 2012
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

staload "libats/mlstyle/SATS/list.sats"

(* ****** ****** *)

#define nil list0_nil
#define cons list0_cons
#define :: list0_cons

#define Some Some0
#define None None0

(* ****** ****** *)

implement{a}
list_head_exn
  (xs) = let
in
  case+ xs of
  | cons (x, _) => x
  | nil _ => $raise ListSubscriptExn()
end // end of [list_head_exn]

implement{a}
list_head_opt (xs) = (
  case+ xs of
  | cons (x, _) => Some (x) | nil _ => None ()
) // end of [list_head_opt]

(* ****** ****** *)

implement{a}
list_tail_exn
  (xs) = let
in
  case+ xs of
  | cons (_, xs) => xs
  | nil _ => $raise ListSubscriptExn()
end // end of [list_tail_exn]

implement{a}
list_tail_opt (xs) = (
  case+ xs of
  | cons (_, xs) => Some (xs) | nil _ => None ()
) // end of [list_tail_opt]

(* ****** ****** *)

local

fun{a:t0p}
loop (
  xs: list a, i: int // i >= 0
) : a = let
in
  case+ xs of
  | cons (x, xs) =>
      if i > 0 then loop (xs, i-1) else x
  | nil _ => $raise ListSubscriptExn ()
end // end of [loop]

in // in of [local]

implement{a}
list_nth_exn (xs, i) = (
  if i >= 0 then
    loop<a> (xs, i) else $raise ListSubscriptExn ()
  // end of [if]
) // end of [list_nth_exn]

implement{a}
list_nth_opt (xs, i) = (
  if i >= 0 then (
    try
      Some (loop<a> (xs, i))
    with
      ~ListSubscriptException () => None ()
    // end of [try]
  ) else None () // end of [if]
) // end of [list_nth_opt]

end // end of [local]

(* ****** ****** *)

(* end of [list.dats] *)
