(* ****** ****** *)
//
#define ATS_PACKNAME
"ATSCNTRB.libats-hwxi\
.teaching.gtkcairotimer_the_topwin"
//
(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* ****** ****** *)

local
//
typedef T = ptr
//
fun initize (x: &T? >> T): void = x := the_null_ptr
//
in (* in of [local] *)

#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"

end // end of [local]

(* ****** ****** *)

(* end of [the_topwin.dats] *)
