(* ****** ****** *)
//
// RPC based on WebWorker
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "theWorker_start"
//
(* ****** ****** *)
//  
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"./../../SATS/Worker/channel.sats"
staload
"./../../DATS/Worker/channel.dats"
#include
"./../../DATS/Worker/chanpos.dats"
//
(* ****** ****** *)
//
fun
list0_add
(
  xs: list0(int)
) : int =
(
  case+ xs of
  | list0_nil() => 0
  | list0_cons(x, xs) => x + list0_add(xs)
)
//
(* ****** ****** *)
//
typedef ARG = list0(int) and RES = int
//
local
//
(*
implement
{a}{b}
rpc_server_cont(ch, f) = chanpos_close(ch)
*)
//
in
//
val ((*void*)) =
  rpc_server<ARG><RES>($UN.cast{chanpos()}(0), lam(xs) => list0_add(xs))
//
end // end of [local]
//
(* ****** ****** *)

%{$
//
theWorker_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [rpc_server.dats] *)
