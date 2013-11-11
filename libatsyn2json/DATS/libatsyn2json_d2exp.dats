(* ****** ****** *)
(*
**
** Some utility functions
** for turning ATS2 syntax trees into JSON format
**
*)
(* ****** ****** *)
(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: November, 2013
**
*)
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "src/pats_dynexp2.sats"

(* ****** ****** *)
  
staload "./../SATS/libatsyn2json.sats"

(* ****** ****** *)

implement
jsonize_d2exp
  (out, d2e0) = let
in
//
case+ d2e0.d2exp_node of
| _ => let
    val () = (
      prerrln! ("jsonize_d2exp: d2e0 = ", d2e0)
    ) (* end of [val] *)
    val ((*void*)) = assertloc (false)
  in
    exit (1)
  end // end of [_]
//
end // end of [jsonize_d2exp]
  
(* ****** ****** *)

(* end of [libatsyn2json_d2exp.dats] *)
