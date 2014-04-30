(*
** for testing [libc/sys/stat]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = $UNSAFE // aliasing
//
(* ****** ****** *)

staload "libc/SATS/stdlib.sats"
staload _ = "libc/DATS/stdlib.dats"

(* ****** ****** *)

staload UNISTD = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libc/sys/SATS/stat.sats"
staload _ = "libc/sys/DATS/stat.dats"

(* ****** ****** *)
//
val user = getenv_gc ("USER")
val user =
(
if strptr2ptr(user) > 0
  then strptr2string(user) else (free(user); "")
) : string // end of [val]
//
val tmp_user =
  strptr2string(string0_append ("/tmp/", user))
//
(* ****** ****** *)

val () =
{
//
val err = mkdirp (tmp_user, S_IRWXU)
val ((*void*)) = println! ("mkdir(", tmp_user, ") = ", err) 
val ((*void*)) = $UNISTD.rmdir_exn (tmp_user)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_sys_stat.dats] *)
