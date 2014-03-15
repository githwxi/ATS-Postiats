(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

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
