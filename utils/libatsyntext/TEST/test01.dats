(* ****** ****** *)
(*
**
** Author: Hongwei Xi
** Start Time: July 23, 2016
** Authoremail: (gmhwxiATgmailDOTcom)
**
*)
(* ****** ****** *)
//
dynload "./../dynloadall.dats"
//
(* ****** ****** *)

staload "./../SATS/syntext.sats"
staload "./../DATS/syntext.dats"
//
(* ****** ****** *)

implement
main() = let
//
var fil : fil_t
//
val d0cs =
parse_from_givename_toplevel
  (1(*dyn*), "./test01.dats", fil)
//
in
  $SYN.fprint_d0eclist(stdout_ref, d0cs)
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
