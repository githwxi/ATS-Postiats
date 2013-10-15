(* ****** ****** *)
//
// HX-2013-08
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
//
// They should not be reloaded!
//
staload "prelude/SATS/arrayptr.sats"
staload _ = "prelude/DATS/arrayptr.dats"
*)

(* ****** ****** *)

extern
fun destroy_buf
  {n:int}(buf: arrayptr(float, n)): void

implement
destroy_buf (buf) = arrayptr_free (buf)
  
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [qa-list-67.dats] *)
