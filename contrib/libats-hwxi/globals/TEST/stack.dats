(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

local

typedef T = int

in (* in of [local] *)

#include "./../HATS/gstack.hats"

end // end of [local]

(* ****** ****** *)

(* end of [stack.dats] *)
