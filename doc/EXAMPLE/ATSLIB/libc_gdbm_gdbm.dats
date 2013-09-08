(*
** some testing code for functions declared in
** libc/SATS/printf.sats
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: September, 2010
//
(* ****** ****** *)
//
// Ported to ATS2 by Hongwei Xi in July, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/fcntl.sats"
staload "libc/sys/SATS/stat.sats"
staload "libc/sys/SATS/types.sats"
staload "libc/gdbm/SATS/gdbm.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

val () =
{
//
val mode = S_IRUSR lor S_IWUSR
val [lf:addr] dbf =
gdbm_open ("gdbmtest.gdbm", 512(*blksz*), GDBM_NEWDB, mode, nullp)
//
val () = println! ("errstr = ", gdbm_strerror (gdbm_errno_get ()))
//
val () = assertloc (ptrcast (dbf) > 0)
//
val (fpf_k | k) = datum_make0_string ("a")
val v = datum_make1_string ("A")
val () = assertloc (gdbm_store (dbf, k, v, GDBM_INSERT) = 0)
val () = datum_free (v)
val () = assertloc (gdbm_exists (dbf, k) > 0)
val v = gdbm_fetch (dbf, k)
//
val () = println! ("k(a) = ", $UN.cast{string}(ptrcast(k.dptr)))
val () = println! ("v(A) = ", $UN.cast{string}(ptrcast(v.dptr)))
//
val () = datum_free (v)
val err = gdbm_delete (dbf, k)
val () = assertloc (err = 0)
val isexi = gdbm_exists (dbf, k)
val () = assertloc (isexi = 0)
prval () = fpf_k (k.dptr)
prval () = $UN.cast2void(k)
//
val () = gdbm_close (dbf)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_gdbm_gdbm.dats] *)
