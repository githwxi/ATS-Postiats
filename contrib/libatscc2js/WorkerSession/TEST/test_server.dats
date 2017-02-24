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
UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
//
#define
WORKERSESSION_CHANPOS 1
//
#include "./../mylibies.dats"
#include "./../mylibies.hats"
//
vtypedef
chanpos(ss:type) = $CHANNEL.chanpos(ss)
//
(* ****** ****** *)
//
staload
PROTOCOL = "./test_prot.sats"
//
typedef sstest1 = $PROTOCOL.sstest1
typedef sstest2 = $PROTOCOL.sstest2
typedef sstest3 = $PROTOCOL.sstest3
//
(* ****** ****** *)

val () =
{
//
val chp =
$UN.castvwtp0{chanpos(sstest3)}(0)
//
val ((*void*)) =
$CHANNEL.chanpos1_recv
(
chp
,
lam(chp, _) => let
  val a1 = double2int(100*JSmath_random())
  val a2 = double2int(100*JSmath_random())
in
  $CHANNEL.chanpos1_send
  ( chp, a1
  , lam(chp) =>
    $CHANNEL.chanpos1_send
    ( chp, a2
    , lam(chp) =>
      $CHANNEL.chanpos1_recv
      ( chp
      , lam(chp, res) =>
        $CHANNEL.chanpos1_send
        ( chp, ($CHANNEL.chmsg_parse(res) = a1 * a2), lam(chp) => $CHANNEL.chanpos1_close(chp))
      )
    )
  )
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

(* end of [test_server.dats] *)
