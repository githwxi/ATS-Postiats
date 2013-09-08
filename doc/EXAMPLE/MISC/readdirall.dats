(*
//
// It is a bit like [scandir] ...
//
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: hwxi AT cs DOT bu DOT edu
** Time: May, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/dirent.sats"
staload _ = "libc/DATS/dirent.dats"

(* ****** ****** *)

staload "libats/SATS/dynarray.sats"
staload _ = "libats/DATS/dynarray.dats"

(* ****** ****** *)

extern
fun{}
readdirall$pred (x: !Direntp1): bool
implement
readdirall$pred<> (x) = true

(* ****** ****** *)

extern
fun{}
readdirall (dirp: !DIRptr1): dynarray (Direntp1)

(* ****** ****** *)

implement{}
readdirall (dirp) = let
//
implement
readdirall$pred<> (x) = let
  val (
    fpf | str
  ) = direntp_get_d_name (x)
  val ans = (str != "." && str != "..")
  prval () = fpf (str)
in
  ans
end // end of [readdirall]
//
vtypedef elt = Direntp1
vtypedef res = dynarray (elt)
//
fun loop
(
  dirp: !DIRptr1, DA: res
) : res = let
  val entp = readdir_r_gc (dirp)
in
//
if direntp2ptr(entp) > 0 then let
  val ans = readdirall$pred (entp)
  val () =
  (
    if ans then
    {
      val-~None_vt () = dynarray_insert_atend_opt (DA, entp)
    } else
      direntp_free (entp)
    // end of [if]
  ) : void (* end of [val] *) 
in
  loop (dirp, DA)
end else let
  val () = direntp_free (entp) in DA
end (* end of [if] *)
//
end (* end of [loop] *)
//
val DA = dynarray_make_nil<elt> (i2sz(1024))
//
in
  loop (dirp, DA)
end // end of [readdirall]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val dname =
(
  if argc >= 2 then argv[1] else "."
) : string // end of [val]
//
val dirp = opendir_exn (dname)
//
val DA = readdirall (dirp)
//
implement(a:vtype)
dynarray_quicksort$cmp<a> (x, y) = let
  val x2 = $UN.castvwtp1{Direntp1}(x)
  val (xfpf | xstr) = direntp_get_d_name (x2)
  val y2 = $UN.castvwtp1{Direntp1}(y)
  val (yfpf | ystr) = direntp_get_d_name (y2)
  prval () = $UN.cast2void(x2)
  prval () = $UN.cast2void(y2)
  val sgn = compare (xstr, ystr)
  prval () = xfpf (xstr) and () = yfpf (ystr)
in
  sgn
end // end of [...]
val () = dynarray_quicksort (DA)
//
var n: size_t
val A = dynarray_getfree_arrayptr (DA, n)
//
val out = stdout_ref
//
implement{}
fprint_array$sep (out) = fprint_newline (out)
//
implement(a:vtype)
fprint_ref<a> (out, x) =
{
  val x2 =
    $UN.castvwtp1{Direntp1}(x)
  val (fpf | str) = direntp_get_d_name (x2)
  prval () = $UN.cast2void(x2)
  val () = fprint_strptr (out, str)
  prval () = fpf (str)
}
val (
) = fprint_arrayptr (out, A, n)
val () = fprint_newline (out)
//
implement(a:vtype)
array_uninitize$clear<a> (i, x) = direntp_free ($UN.castvwtp0(x))
val () = arrayptr_freelin (A, n)
//
val () = closedir_exn (dirp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [readdirall.dats] *)
