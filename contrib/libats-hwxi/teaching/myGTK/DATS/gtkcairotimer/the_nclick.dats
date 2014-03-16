(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#define ATS_PACKNAME
"ATSCNTRB.libats-hwxi.teaching.gtkcairotimer_the_nclick"
//
(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

local
//
typedef T = int
//
fun initize (x: &T? >> T): void = x := 0
//
in (* in of [local] *)

#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"

end // end of [local]

(* ****** ****** *)

(* end of [the_nclick.dats] *)
