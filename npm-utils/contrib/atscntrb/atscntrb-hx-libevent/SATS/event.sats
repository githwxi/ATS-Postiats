(*
** Copyright (C) 2011 Chris Double.
**
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
** Copyright (C) 2014 Hongwei Xi.
**
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
//
// HX-2014-05: Ported to ATS2
//
(* ****** ****** *)

%{#
//
#include \
"atscntrb-hx-libevent/CATS/event.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libevent"
#define ATS_EXTERN_PREFIX "atscntrb_libevent_" // prefix for external names

(* ****** ****** *)
//
staload
TIME = "\
libats/libc/SATS/sys/time.sats"
typedef timeval = $TIME.timeval
//
(* ****** ****** *)

typedef SHR(x:type) = x // for commenting purpose
typedef NSH(x:type) = x // for commenting purpose

(* ****** ****** *)

typedef interr = intBtwe(~1,0)
typedef interr2 = intBtwe(~1,1)

(* ****** ****** *)

typedef ev_ssize_t = ssize_t

(* ****** ****** *)

typedef ev_uint32_t = uint32
typedef ev_uint64_t = uint64

(* ****** ****** *)

absvt@ype
event_struct = $extype"event_struct"

(* ****** ****** *)

absvtype event (l:addr) = ptr (l)
vtypedef event0 = [l:addr] event (l)
vtypedef event1 = [l:addr | l > null] event (l)

(* ****** ****** *)
//
castfn
event2ptr
  {l:addr}(!event(l)):<> ptr(l)
//
overload ptrcast with event2ptr
//
(* ****** ****** *)

fun event_null
  ((*void*)):<> event (null) = "mac#atspre_ptr_null"
// end of [event_null]

praxi event_free_null{l:alez} (p: event l):<prf> void

(* ****** ****** *)
//
fun
event_is_null
  {l:addr}
  (p: !event l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun event_isnot_null
  {l:addr}
  (p: !event l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with event_is_null
overload isneqz with event_isnot_null
//
(* ****** ****** *)

absvtype
event_base (l:addr) = ptr (l)
vtypedef
event0_base = [l:addr] event_base (l)
vtypedef
event1_base = [l:addr | l > null] event_base (l)

(* ****** ****** *)
//
castfn
event2ptr_base
  {l:addr}(!event_base(l)):<> ptr(l)
//
overload ptrcast with event2ptr_base
//
(* ****** ****** *)
//
fun event_base_null
  ((*void*)):<> event_base (null) = "mac#atspre_ptr_null"
//
praxi
event_base_free_null{l:alez} (p: event_base (l)):<prf> void
//
(* ****** ****** *)
//
fun
event_base_is_null
  {l:addr}
  (p: !event_base l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun
event_base_isnot_null
  {l:addr}
  (p: !event_base l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with event_base_is_null
overload isneqz with event_base_isnot_null
//
(* ****** ****** *)

absvtype
event_config (l:addr) = ptr (l)
vtypedef
event0_config = [l:addr] event_config (l)
vtypedef
event1_config = [l:addr | l > null] event_config (l)

(* ****** ****** *)
//
castfn
event2ptr_config
  {l:addr}(!event_config(l)):<> ptr(l)
//
overload ptrcast with event2ptr_config
//
(* ****** ****** *)
//
fun
event_config_null
(
// argumentless
) :<> event_config (null) = "mac#atspre_ptr_null"
//
praxi
event_config_free_null
  {l:addr | l <= null} (p: event_config l):<> void
//
(* ****** ****** *)
//
fun
event_config_is_null
  {l:addr}
  (p: !event_config l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun
event_config_isnot_null
  {l:addr}
  (p: !event_config l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with event_config_is_null
overload isneqz with event_config_isnot_null
//
(* ****** ****** *)

fun event_get_version ((*void*)): string = "mac#%"
fun event_get_version_number ((*void*)): ev_uint32_t = "mac#%"

(* ****** ****** *)
//
fun
event_enable_debug_mode ((*void*)): void = "mac#%"
//
fun event_debug_unassign (ev: !event1): void = "mac#%"
//  
(* ****** ****** *)
//
fun event_config_new (): event0_config = "mac#%"
fun event_config_free (p: event0_config): void = "mac#%"
//
fun event_config_avoid_method
  (cfg: !event1_config, method: NSH(string)): interr = "mac#%"
//
(* ****** ****** *)

fun event_base_new (): event0_base = "mac#%"
fun event_reinit (evb: !event1_base): interr = "mac#%"
fun event_base_dispatch (evb: !event1_base): interr2 = "mac#%"
fun event_base_get_method (evb: !event1_base): string = "mac#%"

(* ****** ****** *)
//
abst@ype
event_method_feature = $extype"event_method_feature"
//
macdef EV_FEATURE_ET = $extval (event_method_feature, "EV_FEATURE_ET")
macdef EV_FEATURE_O1 = $extval (event_method_feature, "EV_FEATURE_O1")
macdef EV_FEATURE_FDS = $extval (event_method_feature, "EV_FEATURE_FDS")
//
(* ****** ****** *)
//
abst@ype
event_base_config_flag = $extype"event_base_config_flag"
//
macdef
EVENT_BASE_FLAG_NOLOCK = $extval (event_base_config_flag, "EVENT_BASE_FLAG_NOLOCK")
macdef
EVENT_BASE_FLAG_IGNORE_ENV = $extval (event_base_config_flag, "EVENT_BASE_FLAG_IGNORE_ENV")
macdef
EVENT_BASE_FLAG_NO_CACHE_TIME = $extval (event_base_config_flag, "EVENT_BASE_FLAG_NO_CACHE_TIME")
macdef
EVENT_BASE_FLAG_EPOLL_USE_CHANGELIST = $extval (event_base_config_flag, "EVENT_BASE_FLAG_EPOLL_USE_CHANGELIST")
//
(* ****** ****** *)
//
fun
event_base_get_features
  (evb: !event1_base): int = "mac#%"
fun
event_config_require_features
  (cfg: !event1_config, features: int): interr = "mac#%"
//
fun
event_config_set_flag
  (cfg: !event1_config, flag: int): int = "mac#%"
fun
event_config_set_num_cpus_hint
  (cfg: !event1_config, cpus: int): interr = "mac#%"
//
fun
event_base_new_with_config
  (cfg: !event1_config): event0_base = "mac#%"
//
fun event_base_free (evb: event0_base): void = "mac#%"
//
(* ****** ****** *)
  
#define _EVENT_LOG_DEBUG 0
#define _EVENT_LOG_MSG   1
#define _EVENT_LOG_WARN  2
#define _EVENT_LOG_ERR   3

(* ****** ****** *)
//
typedef
event_log_cb = (int, string) -> void
fun event_set_log_callback (cb: event_log_cb): void = "mac#%"
//
typedef event_fatal_cb = (int) -> void
fun event_set_fatal_callback (cb: event_fatal_cb): void = "mac#%"
//
fun event_base_set (evb: !event1_base, ev: !event1): int = "mac#%"
//
(* ****** ****** *)

#define EVLOOP_ONCE 0x01
#define EVLOOP_NONBLOCK 0x02
  
(* ****** ****** *)
//  
fun
event_base_loop
  (evb: !event1_base, flag: int): interr2 = "mac#%"
//
fun
event_base_loopexit
  (evb: !event1_base, tv: cPtr0(timeval)): interr = "mac#%"
fun event_base_loopbreak (evb: !event1_base): interr = "mac#%"
//
fun event_base_got_exit (evb: !event1_base): intGte(0) = "mac#%"
//
(* ****** ****** *)

macdef EV_READ    = $extval (sint, "EV_READ")
macdef EV_WRITE   = $extval (sint, "EV_WRITE")
macdef EV_SIGNAL  = $extval (sint, "EV_SIGNAL")
macdef EV_TIMEOUT = $extval (sint, "EV_TIMEOUT")
macdef EV_PERSIST = $extval (sint, "EV_PERSIST")
macdef EV_ET      = $extval (sint, "EV_ET") // edge-triggered

(* ****** ****** *)
//
abst@ype
evutil_socket_t = $extype"evutil_socket_t"
//
typedef
event_callback
(
  a:vt0p, l:addr
) = (evutil_socket_t, sint, cptr(a,l)) -> void
typedef
event_callback_ref
  (a:vt0p) = (evutil_socket_t, sint, &(a) >> _) -> void
//
(* ****** ****** *)

fun
event_new
  {a:vt0p}{l:addr}
(
  evb: !event1_base
, sock: evutil_socket_t, what: sint
, cbfn: event_callback (a, l), arg: cptr(a, l)
) : event0 = "mac#%" // end-of-fun

fun
event_new_ref{a:vt0p}
(
  evb: !event1_base
, sock: evutil_socket_t, what: sint
, cbfn: event_callback_ref (a), arg: &(a) >> _
) : event0 = "mac#%" // end-of-fun

fun event_free (ev: event0): void = "mac#%"

(* ****** ****** *)
//
fun event_add
  (ev: !event1, tv: &timeval): interr = "mac#%"
fun event_add_null (ev: !event1): interr = "mac#%"
//
(* ****** ****** *)

fun event_initialized (ev: !event1): intBtwe(0, 1) = "mac#%"

(* ****** ****** *)
//
fun event_priority_set (ev: !event1, pri: int): interr = "mac#%"
//
fun
event_base_priority_init (evb: !event1_base, pri: int): interr = "mac#%"
//
(* ****** ****** *)

(*
//
// buffer.h
//
*)

(* ****** ****** *)
//
absvtype evbuffer (l:addr) = ptr (l)
vtypedef evbuffer0 = [l:agez ] evbuffer(l)
vtypedef evbuffer1 = [l:addr | l > null ] evbuffer(l)
//
fun evbuffer_null () :<> evbuffer (null) = "mac#atspre_null_ptr"
fun evbuffer_is_null
  {l:addr} (p: !evbuffer l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evbuffer_isnot_null
  {l:addr} (p: !evbuffer l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evbuffer_is_null
overload isneqz with evbuffer_isnot_null
//
(* ****** ****** *)

#include "./buffer.sats"

(* ****** ****** *)

(*
//
// http.h
//
*)

(* ****** ****** *)
(*
** HX-2014-05: response code
*)
macdef HTTP_OK = $extval (int, "HTTP_OK")
macdef HTTP_NOCONTENT = $extval(int, "HTTP_NOCONTENT")
macdef HTTP_MOVEPERM = $extval(int, "HTTP_MOVEPERM")
macdef HTTP_MOVETEMP = $extval(int, "HTTP_MOVETEMP")
macdef HTTP_NOTMODIFIED = $extval(int, "HTTP_NOTMODIFIED")
macdef HTTP_BADREQUEST = $extval(int, "HTTP_BADREQUEST")
macdef HTTP_NOTFOUND = $extval(int, "HTTP_NOTFOUND")
macdef HTTP_BADMETHOD = $extval(int, "HTTP_BADMETHOD")
macdef HTTP_ENTITYTOOLARGE = $extval(int, "HTTP_ENTITYTOOLARGE")
macdef HTTP_EXPECTATIONFAILED = $extval(int, "HTTP_EXPECTATIONFAILED")
macdef HTTP_INTERNAL = $extval(int, "HTTP_INTERNAL")
macdef HTTP_NOTIMPLEMENTED = $extval(int, "HTTP_NOTIMPLEMENTED")
macdef HTTP_SERVUNAVAIL = $extval(int, "HTTP_SERVUNAVAIL")

(* ****** ****** *)

(*
** CD:
** [lb] is the address of an event_base object
** with which that the evhttp object is associated
*)
absvtype
evhttp (lh:addr, lb:addr) = ptr (lh)
//
vtypedef
evhttp1 = [lh,lb:addr | lh > null; lb > null] evhttp (lh, lb)
//
(* ****** ****** *)
//
fun evhttp_null ():<> evhttp (null, null) = "mac#atspre_ptr_null"
//
praxi
evhttp_free_null
  {lh,lb:addr | lh <= null} (http: evhttp (null, null)):<prf> void
//
fun evhttp_is_null
  {lh,lb:addr} (!evhttp (lh, lb)):<> bool (lh==null) = "mac#atspre_ptr_is_null"
fun evhttp_isnot_null
  {lh,lb:addr} (!evhttp (lh, lb)):<> bool (lh > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evhttp_is_null
overload isneqz with evhttp_isnot_null
//
(* ****** ****** *)
//
absvtype evhttp_request (l:addr) = ptr (l)
vtypedef evhttp0_request = [l:agez] evhttp_request(l)
vtypedef evhttp1_request = [l:addr | l > null ] evhttp_request(l)
//
fun evhttp_request_null () :<> evhttp_request (null) = "mac#atspre_ptr_null"
//
fun evhttp_request_is_null
  {l:addr} (!evhttp_request l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evhttp_request_isnot_null
  {l:addr} (!evhttp_request l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evhttp_request_is_null
overload isneqz with evhttp_request_isnot_null
//
(* ****** ****** *)
//
(*
typedef
evhttp_callback0
(
  a:vt@ype, l:addr
) = (evhttp1_request, cptr(a,l)) -> void
*)
typedef
evhttp_callback1
(
  a:vt@ype, l:addr
) = (!evhttp1_request, cptr(a,l)) -> void
typedef
evhttp_callback1_ref
  (a:vt@ype) = (!evhttp1_request, &(a) >> _) -> void
//
(* ****** ****** *)
//
absvtype evkeyvalq (l:addr) = ptr (l)
vtypedef evkeyvalq0 = [l:agez ] evkeyvalq l
vtypedef evkeyvalq1 = [l:addr | l > null ] evkeyvalq l
//
fun evkeyvalq_null () :<> evkeyvalq (null) = "mac#atspre_ptr_null"
//
fun evkeyvalq_is_null {l:addr} (p: !evkeyvalq l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evkeyvalq_isnot_null {l:addr} (p: !evkeyvalq l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evkeyvalq_is_null
overload isneqz with evkeyvalq_isnot_null
//
(* ****** ****** *)
//
absvtype
evhttp_bound_socket (l:addr) = ptr l
vtypedef
evhttp0_bound_socket = [l:agez] evhttp_bound_socket l
vtypedef
evhttp1_bound_socket = [l:addr | l > null ] evhttp_bound_socket l
//
fun evhttp_bound_socket_null ():<> evhttp_bound_socket (null) = "mac#atspre_ptr_null"
//
fun evhttp_bound_socket_is_null
  {l:addr} (p: !evhttp_bound_socket l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evhttp_bound_socket_isnot_null
  {l:addr} (p: !evhttp_bound_socket l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evhttp_bound_socket_is_null
overload isneqz with evhttp_bound_socket_isnot_null
//
(* ****** ****** *)
//
absvtype
evconnlistener (l:addr) = ptr (l)
vtypedef
evconnlistener0 = [l:agez ] evconnlistener(l)
vtypedef
evconnlistener1 = [l:addr | l > null ] evconnlistener(l)
//
fun evconnlistener_null () :<> evconnlistener (null) = "mac#atspre_ptr_null"
//
fun evconnlistener_is_null
  {l:addr} (p: !evconnlistener l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evconnlistener_isnot_null
  {l:addr} (p: !evconnlistener l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evconnlistener_is_null
overload isneqz with evconnlistener_isnot_null
//
(* ****** ****** *)

absvtype evhttp_connection (l:addr) = ptr (l)
vtypedef evhttp0_connection = [l:agez] evhttp_connection(l)
vtypedef evhttp1_connection = [l:addr | l > null ] evhttp_connection(l)
//
fun evhttp_connection_null () :<> evhttp_connection (null) = "mac#atspre_ptr_null"
//
fun evhttp_connection_is_null
  {l:addr} (p: !evhttp_connection l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evhttp_connection_isnot_null
  {l:addr} (p: !evhttp_connection l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evhttp_connection_is_null
overload isneqz with evhttp_connection_isnot_null
//
(* ****** ****** *)
//
absvtype evhttp_uri (l:addr) = ptr (l)
vtypedef evhttp0_uri = [l:agez] evhttp_uri(l)
vtypedef evhttp1_uri = [l:addr | l > null ] evhttp_uri(l)
//
fun evhttp_uri_null () :<> evhttp_uri (null) = "mac#atspre_ptr_null"
fun evhttp_uri_is_null
  {l:addr} (p: !evhttp_uri l):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun evhttp_uri_isnot_null
  {l:addr} (p: !evhttp_uri l):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with evhttp_uri_is_null
overload isneqz with evhttp_uri_isnot_null
//
(* ****** ****** *)
//
abst@ype
evhttp_cmd_type = int
//
macdef EVHTTP_REQ_GET = $extval (evhttp_cmd_type, "EVHTTP_REQ_GET")
macdef EVHTTP_REQ_POST = $extval (evhttp_cmd_type, "EVHTTP_REQ_POST")
macdef EVHTTP_REQ_HEAD = $extval (evhttp_cmd_type, "EVHTTP_REQ_HEAD")
macdef EVHTTP_REQ_PUT = $extval (evhttp_cmd_type, "EVHTTP_REQ_PUT")
macdef EVHTTP_REQ_DELETE = $extval (evhttp_cmd_type, "EVHTTP_REQ_DELETE")
macdef EVHTTP_REQ_OPTIONS = $extval (evhttp_cmd_type, "EVHTTP_REQ_OPTIONS")
macdef EVHTTP_REQ_TRACE = $extval (evhttp_cmd_type, "EVHTTP_REQ_TRACE")
macdef EVHTTP_REQ_CONNECT = $extval (evhttp_cmd_type, "EVHTTP_REQ_CONNECT")
macdef EVHTTP_REQ_PATCH = $extval (evhttp_cmd_type, "EVHTTP_REQ_PATCH")
//
(* ****** ****** *)
//
abst@ype
evhttp_request_error = int
//
macdef
EVREQ_HTTP_TIMEOUT = $extval(evhttp_request_error, "EVREQ_HTTP_TIMEOUT")
macdef
EVREQ_HTTP_EOF = $extval(evhttp_request_error, "EVREQ_HTTP_EOF")
macdef
EVREQ_HTTP_INVALID_HEADER = $extval(evhttp_request_error, "EVREQ_HTTP_INVALID_HEADER")
macdef
EVREQ_HTTP_BUFFER_ERROR = $extval(evhttp_request_error, "EVREQ_HTTP_BUFFER_ERROR")
macdef
EVREQ_HTTP_REQUEST_CANCEL = $extval(evhttp_request_error, "EVREQ_HTTP_REQUEST_CANCEL")
macdef
EVREQ_HTTP_DATA_TOO_LONG  = $extval(evhttp_request_error, "EVREQ_HTTP_DATA_TOO_LONG")
//
(* ****** ****** *)
//
abst@ype
evhttp_request_kind = int
//
macdef EVHTTP_REQUEST = $extval (evhttp_request_kind, "EVHTTP_REQUEST")
macdef EVHTTP_RESPONSE = $extval (evhttp_request_kind, "EVHTTP_RESPONSE")
//
(* ****** ****** *)

#include "./http.sats"

(* ****** ****** *)

(* end of [event.sats] *)
