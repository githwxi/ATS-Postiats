(*
** Atscc2erl:
** A basis for
** dyadic session-types
*)

(* ****** ****** *)
//
// HX-2015-07:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
//
(* ****** ****** *)
//
local
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
in
//
staload "{$LIBATSCC2ERL}/basics_erl.sats"
//
end // end of [local]
//
(* ****** ****** *)
//
abstype chsnd(a:vt@ype)
abstype chrcv(a:vt@ype)
//
(* ****** ****** *)

abstype chnil
abstype chcons(a:type, ss:type)

(* ****** ****** *)
//
stadef nil = chnil
//
stadef :: = chcons and cons = chcons
//
(* ****** ****** *)
//
absvtype
chanpos(type) = ptr and channeg(type) = ptr
//
(* ****** ****** *)
//
fun
chanpos_send
  {a:vt0p}{ss:type}
(
  chp: !chanpos(chsnd(a)::ss) >> chanpos(ss), x: a
) : void = "mac#%" // end-of-function
//
fun
channeg_recv
  {a:vt0p}{ss:type}
(
  chn: !channeg(chrcv(a)::ss) >> channeg(ss), x: a
) : void = "mac#%" // end-of-function
//
(* ****** ****** *)
//
fun
chanpos_recv
  {a:vt0p}{ss:type}
  (!chanpos(chrcv(a)::ss) >> chanpos(ss)): a = "mac#%"
//
fun
channeg_send
  {a:vt0p}{ss:type}
  (!channeg(chsnd(a)::ss) >> channeg(ss)): a = "mac#%"
//
(* ****** ****** *)
//
fun chanpos_nil_wait (chp: chanpos(nil)): void = "mac#%"
fun channeg_nil_close (chn: channeg(nil)): void = "mac#%"
//
(* ****** ****** *)
//
fun
chanposneg_link
  {ss:type}(chp: chanpos(ss), chn: channeg(ss)): void = "mac#%"
//
(* ****** ****** *)
//
fun
channeg_create{ss:type}
  (fserv: chanpos(ss) -<lincloptr1> void): channeg(ss) = "mac#%"
fun
channeg_createnv
  {env:t0p}{ss:type}
  (fserv: (env, chanpos(ss)) -<lincloptr1> void, env): channeg(ss) = "mac#%"
//
(* ****** ****** *)

symintr channel_send
overload channel_send with chanpos_send
overload channel_send with channeg_recv

(* ****** ****** *)

symintr channel_recv
overload channel_recv with chanpos_recv
overload channel_recv with channeg_send

(* ****** ****** *)

symintr channel_close
overload channel_close with chanpos_nil_wait
overload channel_close with channeg_nil_close

(* ****** ****** *)
//
macdef
channel_send_close
  (chx, x0) = (
//
let val chx = ,(chx) in channel_send(chx, ,(x0)); channel_close(chx) end
//
) (* end of [channel_send_close] *)
//
(* ****** ****** *)
//
macdef
channel_recv_close(chx) =
let val chx = ,(chx); val x0 = channel_recv(chx) in channel_close(chx); x0 end
//
(* ****** ****** *)
//
// HX-2015-07:
// For persistent service
//
(* ****** ****** *)
//
abstype
chansrvc(ss:type) = ptr
abstype
chansrvc2(env:vt@ype, ss:type) = ptr
//
stadef service = chansrvc
stadef service = chansrvc2
//
(* ****** ****** *)
//
fun
chansrvc_create{ss:type}
(
  fserv: chanpos(ss) -<cloref1> void
) : chansrvc(ss) = "mac#%" // end-of-fun
//
fun
chansrvc_request
  {ss:type}
  (chsrv: chansrvc(ss)): channeg(ss) = "mac#%"
//
(* ****** ****** *)
//
fun
chansrvc2_create
  {env:vt0p}{ss:type}
(
  fserv: (env, chanpos(ss)) -<cloref1> void
) : chansrvc2(env, ss) = "mac#%" // end-of-fun
//
fun
chansrvc2_request
  {env:vt0p}{ss:type}
  (env, chansrvc2(env, ss)): channeg(ss) = "mac#%"
//
(* ****** ****** *)
//
fun
chansrvc_register
  {ss:type}
  (name: atom, chsrv: chansrvc(ss)): void = "mac#%"
fun
chansrvc2_register
  {env:vt0p}{ss:type}
  (name: atom, chsrv: chansrvc2(env, ss)): void = "mac#%"
//
(* ****** ****** *)

(* end of [basis.sats] *)
