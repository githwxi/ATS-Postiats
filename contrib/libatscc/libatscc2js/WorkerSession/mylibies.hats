(* ****** ****** *)
(*
** HX-2017-01-30:
** For downstream staloading
*)
(* ****** ****** *)
//
#staload
CHANNEL = "./SATS/channel.sats"
//
#staload
_(*CHANNEL*) = "./DATS/channel.dats"
//
(* ****** ****** *)
//
// HX:
// for server-side of a channel
//
#ifdef
WORKERSESSION_CHANPOS
#include "./DATS/chanpos.dats"
#endif // #if(WORKERSESSION_CHANPOS)
//
(* ****** ****** *)
//
// HX:
// for client-side of a channel
//
#ifdef
WORKERSESSION_CHANNEG
#include "./DATS/channeg.dats"
#endif // #if(WORKERSESSION_CHANNEG)
//
(* ****** ****** *)

(* end of [mylibies.hats] *)
