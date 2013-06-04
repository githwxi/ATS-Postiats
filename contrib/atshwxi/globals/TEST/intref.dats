#define ATS_DYNLOADFLAG 0

local

typedef T = int
fun initize (x: &T? >> T): void = x := 0

in (* in of [local] *)

#include "atshwxi/globals/HATS/globalref.hats"

end // end of [local]

(* ****** ****** *)

(* end of [intref.dats] *)
