//
// Getting started with hiredis
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/hiredis.sats"
staload _(*anon*) = "./../DATS/hiredis.dats"

(* ****** ****** *)

val () =
{
  val () = println! ("The version of [hiredis]: ", hiredis_version ())
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
