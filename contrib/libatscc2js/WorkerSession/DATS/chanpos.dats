(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: October, 2015
*)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../SATS/channel.sats"
//
(* ****** ****** *)

%{^
//
var
theWorker_cont;
//
self.onmessage =
function(event)
{
  var k0 = theWorker_cont;
  return ats2jspre_cloref2_app(k0, 0, event.data);
}
//
function
ats2js_workersession_chanpos0_recv
  (chp, k0)
{
  theWorker_cont = k0; return;
}
function
ats2js_workersession_chanpos0_send
  (chp, x0, k0)
{
  postMessage(x0); return ats2jspre_cloref1_app(k0, 0);
}
//
function
ats2js_workersession_chanpos1_recv
  (chp, k0)
{
  return ats2js_workersession_chanpos0_recv(chp, k0);
}
function
ats2js_workersession_chanpos1_send
  (chp, x0, k0)
{
  return ats2js_workersession_chanpos0_send(chp, x0, k0);
}
//
%} // end of [%{^]

(* ****** ****** *)
//
%{^
//
function
ats2js_workersession_chanpos0_close(chp) { return self.close(); }
function
ats2js_workersession_chanpos1_close(chp) { return self.close(); }
//
%} // end of [%{^]
//
(* ****** ****** *)
//
implement
{a}{b}
rpc_server
  (chp, fopr) = let
//
(*
val () = println! ("rpc_server")
*)
//
in
//
chanpos0_recv{a}
( chp
, lam(chp, e) =>
  chanpos0_send{b}
  ( chp
  , fopr(chmsg_parse<a>(e))
  , lam(chp) => rpc_server_cont(chp, fopr)
  )
)
//
end (* end of [rpc_server] *)

(* ****** ****** *)
//
// HX: looping
//
implement
{a}{b}
rpc_server_cont = rpc_server<a><b>
//
(*
//
// HX: one-time service
//
implement
{a}{b}
rpc_server_cont(chp, fopr) = chanpos0_close(chp)
*)
//
(* ****** ****** *)
//
(*
fun{}
chanpos1_append
  {ss1,ss2:type}
(
  chanpos(ssappend(ss1,ss2)), k0: chpcont0_nil
, fserv1: chanpos_nullify(ss1), fserv2: chanpos_nullify(ss2)
) : void // end of [chanpos1_append]
*)
//
implement
{}(*tmp*)
chanpos1_append
  {ss1,ss2}
(
  chp, k0, fserv1, fserv2
) = (
//
fserv1
(
  $UN.castvwtp0{chanpos(ss1)}(chp)
, $UN.castvwtp0{chpcont0_nil}(lam(chp:chanpos(ss2)) =<cloref1> fserv2(chp, k0))
) (* end of [fserv1] *)
//
) (* end of [chanpos1_append] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
chanpos1_choose_conj
  {ss0,ss1}
  (chp, k0, fserv0, fserv1) = let
//
val chp0 = $UN.castvwtp0{chanpos()}(chp)
//
in
//
chanpos0_recv
  {int}
(
  chp0
, lam(chp0, tag0) => let
    val tag0 =
      chmsg_parse<int>(tag0)
    // end of [val]
    val ((*void*)) =
      chanpos1_choose_conj$fwork_tag(tag0)
    // end of [val]
  in
    case+ tag0 of
    | 0 => fserv0($UN.castvwtp0(chp0), k0)
    | _ => fserv1($UN.castvwtp0(chp0), k0)
  end // end of [lam]
) (* end of [chanpos0_recv] *)
//
end // end of [chanpos1_choose_conj]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
chanpos1_choose_disj
  {ss0,ss1}
  (chp, k0, fserv0, fserv1) = let
//
val chp0 = $UN.castvwtp0{chanpos()}(chp)
val tag0 = chanpos1_choose_disj$choose()
val ((*void*)) = chanpos1_choose_disj$fwork_tag(tag0)
//
in
//
case+
tag0 of
| 0 =>
  chanpos0_send{int}
  (
    chp0, tag0, lam(chp0) => fserv0($UN.castvwtp0(chp0), k0)
  ) (* end of [0] *)
| _ =>
  chanpos0_send{int}
  (
    chp0, tag0, lam(chp0) => fserv1($UN.castvwtp0(chp0), k0)
  ) (* end of [1] *)
//
end // end of [chanpos1_choose_disj]]
//
(* ****** ****** *)
(*
fun{}
chanpos1_option_conj
  {ss:type}
(
  chanpos(ssconj(ssoption(ss)))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_option_conj]
*)
//
implement
{}(*tmp*)
chanpos1_option_conj
  {ss}(chp, k0, fserv) = let
//
val chp0 = $UN.castvwtp0{chanpos()}(chp)
//
in
//
chanpos0_recv
  {int}
(
  chp0
, lam(chp0, tag0) => let
    val tag0 =
      chmsg_parse<int>(tag0)
    // end of [val]
    val ((*void*)) =
      chanpos1_option_conj$fwork_tag(tag0)
    // end of [val]
  in
    case+ tag0 of
    | 0 => k0($UN.castvwtp0(chp0))
    | _ => fserv($UN.castvwtp0(chp0), k0)
  end // end of [lam]
) (* end of [chanpos0_recv] *)
//
end // end of [chanpos1_option_conj]
//
(* ****** ****** *)
//
(*
fun{}
chanpos1_option_disj
  {ss:type}
(
  chanpos(ssdisj(ssoption(ss)))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_option_disj]
*)
//
implement
{}(*tmp*)
chanpos1_option_disj
  {ss}(chp, k0, fserv) = let
//
val chp0 = $UN.castvwtp0{chanpos()}(chp)
val tag0 = chanpos1_option_disj$choose()
val ((*void*)) = chanpos1_option_disj$fwork_tag(tag0)
//
in
//
case+
tag0 of
| 0 =>
  chanpos0_send{int}(chp0, tag0, $UN.cast{chpcont0()}(k0))
| _ =>
  chanpos0_send{int}
  (
    chp0, tag0, lam(chp0) => fserv($UN.castvwtp0(chp0), k0)
  ) (* end of [1] *)
//
end // end of [chanpos1_option_disj]]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
chanpos1_option_conj$fwork_tag(tag) = () // nothing is done by default
//
implement
{}(*tmp*)
chanpos1_option_disj$fwork_tag(tag) = () // nothing is done by default
//
(* ****** ****** *)
(*
fun{}
chanpos1_repeat_conj
  {ss:type}
(
  chanpos(ssconj(ssrepeat(ss)))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_repeat_conj]
*)
//
implement
{}(*tmp*)
chanpos1_repeat_conj
  {ss}(chp, k0, fserv) = let
//
typedef
loop =
$d2ctype
  (chanpos1_repeat_conj<>)
//
fun
loop: loop =
lam(chp, k0, fserv) => let
  val chp0 =
    $UN.castvwtp0{chanpos()}(chp)
  // end of [val]
in
//
chanpos0_recv
  {int}
(
  chp0
, lam(chp0, tag0) => let
    val tag0 =
      chmsg_parse<int>(tag0)
    // end of [val]
    val ((*void*)) =
      chanpos1_repeat_conj$fwork_tag(tag0)
    // end of [val]
  in
    case+ tag0 of
    | 0 => k0($UN.castvwtp0(chp0))
    | _ => fserv($UN.castvwtp0(chp0), lam(chp) => loop($UN.castvwtp0(chp), k0, fserv))
  end // end of [lam]
) (* end of [chanpos0_recv] *)
//
end // end of [loop]
//
val () = chanpos1_repeat_conj$init<>()
//
in
  loop(chp, k0, fserv)
end // end of [chanpos1_repeat_conj]
//
(* ****** ****** *)
(*
//
fun{}
chanpos1_repeat_disj
  {ss:type}
(
  chanpos(ssrepeat(ss))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_repeat_disj]
//
*)
//
implement
{}(*tmp*)
chanpos1_repeat_disj
  {ss}(chp, k0, fserv) = let
//
typedef
loop =
$d2ctype
  (chanpos1_repeat_disj<>)
//
fun
loop: loop =
lam(chp, k0, fserv) => let
  val chp0 =
    $UN.castvwtp0{chanpos()}(chp)
  val tag0 =
    chanpos1_repeat_disj$choose()
  // end of [val]
(*
  val () = console_log
  (
    "chanpos1_repeat_disj: loop: tag0 = " + String(tag0)
  )
*)
  val ((*void*)) =
    chanpos1_repeat_disj$fwork_tag(tag0)
  // end of [val]
in
//
case+
tag0 of
| 0 =>
  chanpos0_send{int}(chp0, tag0, $UN.cast{chpcont0()}(k0))
| _ =>
  chanpos0_send{int}
  (
    chp0, tag0
  , lam(chp0) =>
      fserv($UN.castvwtp0(chp0), lam(chp) => loop($UN.castvwtp0(chp), k0, fserv))
    // end of [lam]
  ) (* end of [1] *)
//
end // end of [loop]
//
val () = chanpos1_repeat_disj$init<>()
//
in
  loop(chp, k0, fserv)
end // end of [chanpos1_repeat_disj]]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
chanpos1_repeat_conj$init() = () // nothing is done by default
//
implement
{}(*tmp*)
chanpos1_repeat_disj$init() = () // nothing is done by default
//
implement
{}(*tmp*)
chanpos1_repeat_conj$fwork_tag(tag) = () // nothing is done by default
//
implement
{}(*tmp*)
chanpos1_repeat_disj$fwork_tag(tag) = () // nothing is done by default
//
(* ****** ****** *)

(* end of [chanpos.dats] *)
