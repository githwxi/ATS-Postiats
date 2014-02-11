(* ****** ****** *)
//
// API in ATS for GUROBI
//
(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)
//
// Start time: January, 2014
//
(* ****** ****** *)

(*
** Author: Brandon Barker 
** Authoremail: brandonDOTbarkerATgmailDOTcom)
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi (gmhwxiDOTgmailDOTcom)
*)

(* ****** ****** *)

staload "./../SATS/gurobi.sats"

(* ****** ****** *)

implement{}
fprint_GRBerrormsg
  (out, env) =
{
  val (fpf | str) = GRBgeterrormsg (env)
  val ((*void*)) = fprint_strptr (out, str)
  prval ((*void*)) = fpf (str)
} (* end of [fprint_GRBerrormsg] *)

(* ****** ****** *)

implement{}
fprint_GRBerrormsg_if
  (out, env, errno) =
(
  if errno > 0 then fprint_GRBerrormsg (out, env)
)

(* ****** ****** *)

(* end of [gurobi.dats] *)
