(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/SATS/hashtbl_chain.sats"
staload
_ = "libats/DATS/hashtbl_chain.dats"
//
(* ****** ****** *)

local
//
typedef key = string
typedef itm = int
//
#define CAPACITY 1024
//
in (* in of [local] *)

#include "./../HATS/ghashtbl_chain.hats"

end // end of [local]

(* ****** ****** *)

(* end of [ghashtbl_chain.dats] *)
