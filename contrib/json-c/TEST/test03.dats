(*
** Some testing code for [json]
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT edu
** Time: May, 2013
*)

(* ****** ****** *)

%{^
#include "json-c/CATS/json.cats"
#include "json-c/CATS/printbuf.cats"
%}

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/printbuf.sats"

(* ****** ****** *)

implement
main0 () =
{
//
val pb = printbuf_new ()
val () = assertloc (ptrcast(pb) > 0)
val cnt = $extfcall (int, "sprintbuf", ptrcast(pb), "Hello from [sprintbuf]!")
val () = println! ("cnt = ", cnt)
val (fpf | buf) = printbuf_get_buf (pb)
val () = println! ("buf = ", buf)
prval () = fpf (buf)
val () = printbuf_free (pb)
//
} // end of [main]

(* ****** ****** *)

(* end of [test03.dats] *)
