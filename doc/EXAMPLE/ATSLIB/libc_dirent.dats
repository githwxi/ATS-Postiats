(*
** for testing [libc/dirent]
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
  val () = if (str != "." && str != "..") then println! (str)
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
if res > 0 then let
  prval () = opt_unsome (ent)
in
//
if res > 0 then let
  val str = dirent_get_d_name_gc (ent)
  val () = if (str != "." && str != "..") then println! (str)
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
val
(
  pfopt | err
) = closedir (dirp)
val () = assertloc (err = 0)
prval None_v () = pfopt
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val dirp = opendir_exn (".")
//
val () = while (true)
{
val entp = readdir_r_gc (dirp)
val isnot =
  ptr_isnot_null (direntp2ptr(entp))
val () =
if isnot then
{
//
val (
  fpf | str
) = direntp_get_d_name (entp)
val () = println! ("entp.d_name = ", str)
prval () = fpf (str)
//
} (* end of [if] *)
//
val () = direntp_free (entp)
val () = if ~isnot then $break
} (* end of [val] *)
//
val () = closedir_exn (dirp)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
typedef filter = (&dirent) -> int
typedef compar = (&ptr(*direntp*), &ptr(*direntp*)) -> int
//
val dirp = "."
var namelst: ptr // uninitized
val nitm = scandir (dirp, namelst, $UNSAFE.cast{filter}(0), $UNSAFE.cast{compar}(0))
val () = assertloc (nitm >= 0)
val () = println! ("scandir(...) = ", nitm)
//
extern fun direntp_free (x: ptr): void = "mac#atsruntime_mfree_libc"
//
implement
array_uninitize$clear<ptr> (i, x) = direntp_free (x)
val asz = g0i2u (nitm)
val [n:int] asz = g1ofg0_uint (asz)
val () = arrayptr_freelin ($UNSAFE.castvwtp0{arrayptr(ptr, n)}(namelst), asz)
//
val () = println! ("[namelst] is properly freed.")
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_dirent.dats] *)
