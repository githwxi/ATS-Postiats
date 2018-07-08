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
"{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
//
#define
WORKERSESSION_CHANPOS 1
//
#include "./../mylibies.dats"
//
#include
"./../mylibies.hats"; staload $CHANNEL
//
(* ****** ****** *)
//
staload
PROTOCOL = "./test2_prot.sats"
//
typedef sstest1 = $PROTOCOL.sstest1
typedef sstest2 = $PROTOCOL.sstest2
typedef sstest3 = $PROTOCOL.sstest3
//
(* ****** ****** *)

fun
chanpos1_sstest2
(
  chp: chanpos(sstest2), k0: chpcont0_nil, a1: int, a2: int
) : void = (
//
chanpos1_send
( chp, a1
, lam(chp) =>
  chanpos1_send
  ( chp, a2
  , lam(chp) =>
    chanpos1_recv
    ( chp
    , lam(chp, res) =>
      chanpos1_send
      (chp, (chmsg_parse(res) = a1 * a2), lam(chp) => k0(chp))
    )
  )
)
//
) (* end of [channeg1_sstest2] *)

(* ****** ****** *)

val () =
{
//
val chp =
$UN.castvwtp0{chanpos(sstest3)}(0)
//
val ((*void*)) =
chanpos1_recv
(
chp
,
lam(chp, _) => let
//
val N = ref{int}(3)
//
implement
chanpos1_repeat_disj$choose<>() =
  let val n = N[]; val () = N[] := n-1 in if n > 0 then 1 else 0 end
//
in
//
chanpos1_repeat_disj
(
  chp
, lam(chp) => chanpos1_close(chp)
, lam(chp, k0) =>
  let
    val a1 =
      double2int(100*JSmath_random())
    and a2 =
      double2int(100*JSmath_random()) in chanpos1_sstest2(chp, k0, a1, a2)
  end // end of [lam]
) (* chanpos1_repeat_disj *)
//
end // end of [lam]
) (* end of [chanpos1_recv] *)
//
} (* end of [val] *)

(* ****** ****** *)

%{$
//
theWorker_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [test2_server.dats] *)
