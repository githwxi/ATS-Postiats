(* ****** ****** *)
//
// RPC based on WebWorker
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/mylibies.hats"
//  
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define
WORKERSESSION_CHANNEG 1
//
#include "./../mylibies.dats"
#include "./../mylibies.hats"
//
(* ****** ****** *)

%{^
//
var
myworker =
  new Worker("./rpc_server_dats_.js");
//
if (myworker)
{
  myworker.onmessage =
  function(e){ alert(e.data); return; };
}
//
if (!myworker)
{
  alert('Creating of myworker failed!');
}
//
function
theTrigger_onclick()
{
  var
  arg1 =
  document.getElementById('theArg1').value;
  var
  arg2 =
  document.getElementById('theArg2').value;
  return theTrigger_onclick_(myworker, arg1, arg2);
}
//
%} // end of [%{^]

(* ****** ****** *)
//
vtypedef
channeg() = $CHANNEL.channeg()
//
extern
fun
theTrigger_onclick_
(
  channeg(), arg1: string, arg2: string
) : void = "mac#" // endfun
//
implement
theTrigger_onclick_
  (chn, arg1, arg2) = let
//
val
args =
cons(arg1, cons(arg2, nil))
//
typedef stringlst = List0(string)
//
in
//
$CHANNEL.rpc_client<stringlst><int>
(
  chn, args, lam(res) => alert(arg1 + " + " + arg2 + " = " + String(res))
)
//
end // end of [theTrigger_onclick_]
//
(* ****** ****** *)

(* end of [rpc_client.dats] *)
