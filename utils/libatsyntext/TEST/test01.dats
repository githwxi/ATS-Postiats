(*
**
** Author: Hongwei Xi
** Authoremail: (gmhwxiATgmailDOTcom)
** Start Time: July 23, 2016
**
*)

(* ****** ****** *)
//
staload
"./../SATS/libatsyntext.sats"
//
(* ****** ****** *)
//
staload
"./../DATS/libatsyntext.dats"
//
(* ****** ****** *)

dynload "./../dynloadall.dats"

(* ****** ****** *)

implement
main() = let
//
val d0cs =
parse_from_stdin_toplevel(1)
//
in
  // ...
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
