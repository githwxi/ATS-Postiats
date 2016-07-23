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
var fil : fil_t
//
val d0cs =
parse_from_givename_toplevel(1, "./test01.dats", fil)
//
in
  $SYN.fprint_d0eclist(stdout_ref, d0cs)
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
