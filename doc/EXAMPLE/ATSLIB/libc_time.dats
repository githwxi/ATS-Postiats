(*
** for testing [libc/time]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/time.sats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
var tval = time_get ()
val fpfstr = ctime (tval)
val () = fprint_strptr (out, fpfstr.1)
prval () = fpfstr.0 (fpfstr.1)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
var tval: time_t
val opt = time_getset (tval)
val () = assertloc (opt)
prval () = opt_unsome (tval)
val fpfstr = ctime (tval)
val () = fprint_strptr (out, fpfstr.1)
prval () = fpfstr.0 (fpfstr.1)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_time.dats] *)
