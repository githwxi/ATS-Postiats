(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#define ATS_PACKNAME
"ATSCNTRB.libats-hwxi.\
teaching.gtkcairotimer_toplevel"
//
(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

staload
NCLICK = {
//
typedef T = int
//
fun
initize (x: &T? >> T): void = x := 0
//
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [NCLICK] *)

(* ****** ****** *)

staload
TOPWIN = {
//
typedef T = ptr
//
fun
initize (x: &T? >> T): void = x := the_null_ptr
//
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [TOPWIN] *)

(* ****** ****** *)

(* end of [the_toplevel.dats] *)
