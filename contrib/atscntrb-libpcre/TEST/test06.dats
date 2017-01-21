//
// Some code for testing the API in ATS for pcre
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload
UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"libats/libc/SATS/dirent.sats"
//
staload
_(*anon*) =
"libats/libc/DATS/dirent.dats"
//
(* ****** ****** *)

staload "./../SATS/pcre.sats"
staload "./../SATS/pcre_ML.sats"

(* ****** ****** *)

staload _ = "./../DATS/pcre.dats"
staload _ = "./../DATS/pcre_ML.dats"

(* ****** ****** *)

val () =
{
//
val dirp = opendir_exn (".")
//
val dents =
  streamize_DIRptr_dirent(dirp)
//
val names =
stream_vt_map_cloptr<dirent><Strptr1>
  (dents, lam(x) => dirent_get_d_name_gc(x))
//
local
implement(a)
stream_vt_filterlin$pred<a>(x) =
$effmask_all
( 0
= regstr_match_string
  ("^test\\d{2}\\.dats$", $UN.castvwtp1{string}(x))
) (* stream_vt_filterlin$pred *)
//
implement(a)
stream_vt_filterlin$clear<a>(x) =
  free($UN.castvwtp0{Strptr1}(x))
in
val names =
stream_vt_filterlin<Strptr1>(names)
end // end of [val]
//
val ((*void*)) =
stream_vt_foreach_cloptr
(
  names
, lam(x) =>
  let val x = x in
    println! ("streamize: ", $UN.strptr2string(x)); free(x)
  end // end of [let]
) (* stream_vt_foreach_cloptr *)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [test06.dats] *)
