(*
** Effective ATS:
** A simple Http-server
*)

(* ****** ****** *)
//
// Author: HX-2014-11-29
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

extern
fun myserver (): void
extern
fun myserver_init (): void
extern
fun myserver_loop (): void

(* ****** ****** *)

implement
myserver () =
{
//
val () = myserver_init ()
val () = myserver_loop ()
//
} (* end of [myserver] *)

(* ****** ****** *)

(*
implement
myserver_init () =
{
//
val () = println! ("myserver_init: start")
val () = println! ("myserver_init: finish")
//
} (* end of [myserver_init] *)
*)

(* ****** ****** *)

absvtype request = ptr

(* ****** ****** *)
//
extern
fun
myserver_waitfor_request (): request
extern
fun
myserver_process_request (request): void
//
(* ****** ****** *)

implement
myserver_loop () =
{
//
val req =
myserver_waitfor_request ()
//
val () =
myserver_process_request (req)
//
val () = myserver_loop ((*void*))
//
} (* end of [myserver_loop] *)

(* ****** ****** *)

implement main0 () = myserver ()

(* ****** ****** *)
//
staload "libc/SATS/time.sats"
//
staload "{$ZEROMQ}/SATS/zmq.sats"
staload "{$ZEROMQ}/SATS/czmq.sats"
//
(* ****** ****** *)

%{^
void *theRouter = 0;
typedef char *charptr;
%} // end of [%{^]
abstype charptr = $extype"charptr"

(* ****** ****** *)

#define MYENDPOINT "tcp://*:8888"

(* ****** ****** *)

implement
myserver_init () =
{
//
#define BUFSZ 128
//
var buf = @[byte][BUFSZ]()
//
val router = zsock_new (ZMQ_ROUTER)
val ((*void*)) = assertloc (ptrcast(router) > 0)
val ((*void*)) = zsock_set_router_raw (router, 1)
//
val ((*void*)) =
  assertloc (zsock_bind (router, MYENDPOINT) >= 0)
//
extvar "theRouter" = $UN.castvwtp0{ptr}(router)
//
} (* end of [myserver_init] *)

(* ****** ****** *)

implement
myserver_waitfor_request
  ((*void*)) = let
//
val router =
  $extval(zsock1, "theRouter")
//
val handle = zframe_recv (router)
//
prval ((*void*)) = $UN.cast2void(router)
//
in
  $UN.castvwtp0{request}(handle)
end // end of [myserver_waitfor_request]

(* ****** ****** *)

#define BUFSZ 1024
#define BUFSZ2 1280

(* ****** ****** *)

val
theRespFmt = "\
HTTP/1.0 200 OK\r\n\
Content-type: text/html\r\n\r\n\
<!DOCTYPE html>
<html>
<head>
<meta charset=\"UTF-8\">
<meta http-equiv=\"Content-Type\" content=\"text/html\">
</head>
<body>
<h1>
Hello from myserver2!
</h1>
<pre>
%s
</pre>
<pre>
<u>The time stamp</u>: <b>%s</b>
</pre>
</body>
</html>
" // end of [val]

(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)

implement
myserver_process_request
  (req) = let
//
val handle = $UN.castvwtp0{zframe0}(req)
val router = $extval(zsock1, "theRouter")
//
in
//
if
ptrcast(handle) > 0
then let
//
var time = time_get()
val tmstr = $extfcall(charptr, "ctime", addr@time)
//
val req2 = zstr_recv (router)
val nreq2 = string_length($UN.castvwtp1{string}(req2))
//
in
//
if
nreq2 > 0
then let
//
val err =
zframe_send1_val (handle, router, ZFRAME_MORE)
val err =
$extfcall
(
  int
, "zstr_sendf"
, dataget(router)
, theRespFmt, $UN.castvwtp1{charptr}(req2), tmstr
) (* end of [val] *)
val () = zstr_free_val (req2)
val err =
zframe_send0_val (handle, router, ZFRAME_MORE)
//
val fpfx =
  zsock_get_socket (router)
val err = zmq_send_null (fpfx.1)
prval ((*void*)) = minus_addback (fpfx.0, fpfx.1 | router)
//
prval () = $UN.cast2void(router)
//
in
  // nothing
end // end of [then]
else let
//
val () =
  zframe_destroy_val (handle)
//
val () = zstr_free_val (req2)
//
prval () = $UN.cast2void(router)
//
in
  // nothing
end // end of [else]
//
end // end of [then]
else let
  prval () = zframe_free_null (handle)
  val ((*void*)) = zsock_destroy_val (router)
in
  exit(0)
end (* end of [else] *)
//
end // end of [myserver_process_request]

(* ****** ****** *)

(* end of [myserver2.dats] *)
