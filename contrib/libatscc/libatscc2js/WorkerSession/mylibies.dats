(* ****** ****** *)
(*
** HX-2017-01-30:
** For downstream static linking
*)
(* ****** ****** *)
//
// HX:
// for server-side of a channel
//
#ifdef
WORKERSESSION_CHANPOS
//
local
//
#include "./DATS/chanpos.dats"
//
in (* nothing *) end
//
#endif // #ifdef(WORKERSESSION_CHANPOS)
//
(* ****** ****** *)
//
// HX:
// for client-side of a channel
//
#ifdef
WORKERSESSION_CHANNEG
//
local
//
#include "./DATS/channeg.dats"
//
in (* nothing *) end
//
#endif // #ifdef(WORKERSESSION_CHANNEG)
//
(* ****** ****** *)

(* end of [mylibies.dats] *)
