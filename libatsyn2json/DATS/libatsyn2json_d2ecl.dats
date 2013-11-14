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
jsonize_d2ecl
  (out, d2c0) = let
in
//
case+ d2c0.d2ecl_node of
| _ => fprint_d2ecl (out, d2c0)
(*
| _ => let
    val () = (
      prerrln! ("jsonize_d2ecl: d2c0 = ", d2c0)
    ) (* end of [val] *)
    val ((*void*)) = assertloc (false)
  in
    exit (1)
  end // end of [_]
*)
//
end // end of [jsonize_d2ecl]
  
(* ****** ****** *)

implement
jsonize_d2eclist
  (out, d2cs) = let
in
//
case+ d2cs of 
| list_nil () => ()
| list_cons
    (d2c, d2cs) => let
    val () =
      jsonize_d2ecl (out, d2c)
    // end of [val]
    val () = fprint_newline (out)
  in
    jsonize_d2eclist (out, d2cs)
  end // end of [list_cons]
//
end // end of [jsonize_d2eclist]

(* ****** ****** *)

(* end of [libatsyn2json_d2ecl.dats] *)
