(*
** for testing [libc/fnmatch]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/fnmatch.sats"

(* ****** ****** *)

val () =
{
//
val () = assertloc (fnmatch ("libc_*.?ats", "libc_fnmatch.dats", 0) = FNM_MATCH)
val () = assertloc (fnmatch ("libc_*.sats", "libc_fnmatch.dats", 0) = FNM_NOMATCH)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_fnmatch.dats] *)
