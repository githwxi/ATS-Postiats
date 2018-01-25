(*
//
// event2/buffer.h
//
*)

(* ****** ****** *)

/*
size_t
evbuffer_get_length (const struct evbuffer *buf);
*/
fun
evbuffer_get_lenth (buf: !evbuffer1):<> size_t = "mac#%"

(* ****** ****** *)
//
fun
evbuffer_pullup
  (buf: !evbuffer1, size: ev_ssize_t): vStrptr0 = "mac#%"
//      
(* ****** ****** *)

(* end of [buffer.sats] *)
