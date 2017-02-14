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
#define
WORKERSESSION_CHANPOS 1
//
#include "./../mylibies.dats"
#include "./../mylibies.hats"
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
vtypedef
chanpos() = $CHANNEL.chanpos()
//
(* ****** ****** *)

local
//
(*
implement
{a}{b}
rpc_server_cont(ch, f) = chanpos_close(ch)
*)
//
typedef ARG = list0(int) and RES = int
//
in
//
val ((*void*)) =
$CHANNEL.rpc_server<ARG><RES>
  ($UN.cast{chanpos()}(0), lam(xs) => list0_add(xs))
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
