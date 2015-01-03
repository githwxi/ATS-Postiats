(*
** Bug in compiling
** singular record as a return value.
*)

(* ****** ****** *)

(*
** Source: Reported by HX-2015-01-03
*)

(* ****** ****** *)

(*
** Status: HX: It is yet to be fixed
*)

(* ****** ****** *)
//
// A linear stream of characters
//
(* ****** ****** *)
//
(*
#include "share/atspre_staload.hats"
*)
//
(* ****** ****** *)
//
abstype
sstream_type(l:addr) = ptr(l)
//
stadef sstream = sstream_type
//
(* ****** ****** *)
//
extern
fun
sstream_create () : [l:addr] sstream(l)
//
(* ****** ****** *)

local

assume
sstream_type(l:addr) = (unit_p | ptr(l))

in (* in-of-local *)

implement
sstream_create() =
(
  unit_p() | the_null_ptr
) // end of [sstream_create]

end // end of [local]

(* ****** ****** *)

(* end of [bug-2015-01-03.dats] *)
