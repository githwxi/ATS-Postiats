(*
** for testing [libc/fcntl]
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

staload "libc/SATS/fcntl.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)

val () =
{
//
val fd = open_flags ("/tmp/foo", O_RDONLY)
val ifd = fildes_get_int (fd)
val () = println! ("fildes_get_int (fd) = ", ifd)
//
val () =
(
//
if ifd >= 0 then let
  val (pfopt | err ) = close (fd)
  val () = assertloc (err = 0)
  prval close_v_succ () = pfopt
in
  // nothing
end else let
  prval () = fildes_neg_elim (fd)
in
  // nothing
end // end of [if]
//
) : void
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_fcntl.dats] *)
