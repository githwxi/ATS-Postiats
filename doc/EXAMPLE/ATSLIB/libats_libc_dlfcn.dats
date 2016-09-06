(*
** for testing
** [libats/libc/dlfcn]
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

staload "libats/libc/SATS/dlfcn.sats"

(* ****** ****** *)

val () =
{
//
val flag = RTLD_LAZY
val (pfopt | p0) = dlopen (stropt_some("libm.so"), flag)
val () = assertloc (p0 > 0)
prval Some_v(pf) = pfopt
//
val
(
  fpf | str
) = dlerror ()
//
prval () = fpf (str)
//
val PI = 3.1415926535898
val fp = dlsym(pf | p0, "cos")
val ((*void*)) = assertloc (fp > 0)
val cosine = $UN.cast{double->double}(fp)
//
val ((*void*)) = fprintln! (stdout_ref, "cosine(PI) = ", cosine(PI))
//
val err = dlclose (pf | p0)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_libc_dlfcn.dats] *)
