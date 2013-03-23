(*
** for testing [libc/dirent]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/dirent.sats"
staload _ = "libc/DATS/dirent.dats"

(* ****** ****** *)

val () =
{
//
fun loop
(
  dirp: !DIRptr1
) : void = let
  val (pfopt | p) = readdir (dirp)
in
//
if p > 0 then let
  prval Some_v @(pf, fpf) = pfopt
  val str = dirent_get_d_name_gc (!p)
  prval () = fpf (pf)
  val () = println! (str)
  val () = strptr_free (str)
in
  loop (dirp)
end else let
  prval None_v () = pfopt in (*nothing*)
end // end of [if]
//
end // end of [loop]
//
val dirp = opendir_exn (".")
//
val () = loop (dirp)
//
val () = closedir_exn (dirp)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
fun loop
(
  dirp: !DIRptr1
) : void = let
  var ent: dirent?
  var res: ptr?
  val err = readdir_r (dirp, ent, res)
in
//
if err = 0 then let
  prval () = opt_unsome (ent)
in
//
if res > 0 then let
  val str = dirent_get_d_name_gc (ent)
  val () = println! (str)
  val () = strptr_free (str)
in
  loop (dirp)
end else () // end of [if]
//
end else let
  prval () = opt_unnone (ent) in (*nothing*)
end // end of [if]
//
end // end of [loop]
//
val dirp = opendir_exn (".")
//
val () = loop (dirp)
//
val ofs = telldir (dirp)
val () = println! ("telldir()")
val () = rewinddir (dirp)
val () = println! ("rewinddir()")
val () = seekdir (dirp, ofs)
val () = println! ("seekdir() ")
//
val () = closedir_exn (dirp)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_dirent.dats] *)
