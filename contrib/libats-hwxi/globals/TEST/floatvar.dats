#define ATS_DYNLOADFLAG 0

local
//
typedef T = double
//
fun initize (x: &T? >> T): void = x := 0.0
//
in (* in of [local] *)

#include "./../HATS/gvar.hats"

end // end of [local]

(* ****** ****** *)

(* end of [floatvar.dats] *)
