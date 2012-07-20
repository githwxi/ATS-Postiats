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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: July, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [lazy_vt.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

implement{a}
stream_vt_free (xs) = ~(xs)

(* ****** ****** *)

implement{env}
stream_vt_foreach__cont (env) = true

implement{a}
stream_vt_foreach (xs) = let
  var env: void = () in stream_vt_foreach_env<a><void> (xs, env)
end // end of [stream_vt_foreach]

implement{a}{env}
stream_vt_foreach_env
  (xs, env) = let
  val test = stream_vt_foreach__cont (env)
in
//
if test then let
  val xs_con = !xs
in
  case+ xs_con of
  | @stream_vt_cons (x, xs1) => let
      val xs1 = xs1
      val () = stream_vt_foreach__fwork<a> (x, env)
      val () = free@ {a} (xs_con)
    in
      stream_vt_foreach<a> (xs1)
    end // end of [stream_vt_cons]
  | ~stream_vt_nil () => ()
end else
  stream_vt_free (xs)
// end of [if]
end // end of [stream_vt_foreach_env]

(* ****** ****** *)
//
// HX-2012: casting stream_cons to list_cons
//
extern
castfn stream2list_vt_cons
  {l0,l1,l2:addr}
  (x: stream_vt_cons_unfold (l0, l1, l2)):<> list_vt_cons_unfold (l0, l1, l2)
// end of [stream2list_vt_cons]

implement{a}
stream2list_vt (xs) = let
//
fun loop (
  xs: stream_vt a
) :<!laz> List0_vt (a) = let
  val xs_con = !xs
in
  case+ xs_con of
  | @stream_vt_cons (x, xs1) => let
      val xs1_val = xs1
      val () = xs1 := loop (xs1_val)
      val xs_con = stream2list_vt_cons (xs_con)
    in
      fold@ (xs_con); xs_con
    end // end of [stream_cons]
  | ~stream_vt_nil () => list_vt_nil ()
end // end of [loop]
//
in
  loop (xs)
end // end of [stream2list_vt]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [lazy_vt.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [lazy_vt.dats] *)
