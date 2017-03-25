(* ****** ****** *)

(*
** CML.channel
*)

(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "ats2erlcml_cml_"
//
(* ****** ****** *)

abstype thread_id
typedef tid = thread_id

(* ****** ****** *)
//
abstype
chan_type(a:t@ype)
//
typedef
chan(a:t@ype) = chan_type(a)
//
(* ****** ****** *)
//
abstype
event_type(a:t@ype)
//
typedef
event(a:t@ype) = event_type(a)
//
(* ****** ****** *)
//
fun spawn
  (f: () -<cloref1> void): thread_id = "mac#%"
//
fun
spawnc{a:t@ype}
  (f: (a) -<cloref1> void, env: a): thread_id = "mac#%"
//
(* ****** ****** *)

fun exit : {a:t@ype} ((*void*)) -> a = "mac#%"

(* ****** ****** *)
//
fun
channel{a:t@ype}(): chan(a) = "mac#%"
//
fun recv{a:t@ype} (ch: chan(a)): a = "mac#%"
fun send{a:t@ype} (ch: chan(a), x: a): void = "mac#%"
//
(* ****** ****** *)

(* end of [CML.sats] *)
