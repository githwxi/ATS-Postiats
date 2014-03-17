(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/SATS/deqarray.sats"
staload
_ = "libats/DATS/deqarray.dats"
//
(* ****** ****** *)

local
//
typedef T = double
//
#define CAPACITY1 1024
//
in (* in of [local] *)

#include "./../HATS/gdeqarray.hats"

end // end of [local]

(* ****** ****** *)

(* end of [gdeqarray.dats] *)
