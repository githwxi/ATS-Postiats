(*
** Effective ATS:
** A simple Http-server
*)

(* ****** ****** *)
//
// Author: HX-2014-11-26
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

abst@ype request = int

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
staload "libats/libc/SATS/time.sats"
staload "libats/libc/SATS/unistd.sats"
//
staload "libats/libc/SATS/sys/socket.sats"
staload "libats/libc/SATS/sys/socket_in.sats"
//
staload "libats/libc/SATS/arpa/inet.sats"
staload "libats/libc/SATS/netinet/in.sats"
//
(* ****** ****** *)

%{^
int theSockID = -1;
%} // end of [%{^]

(* ****** ****** *)

#define MYPORT 8888

(* ****** ****** *)

implement
myserver_init () =
{
//
val inport = in_port_nbo(MYPORT)
val inaddr = in_addr_hbo2nbo (INADDR_ANY)
//
var servaddr
  : sockaddr_in_struct
val ((*void*)) =
sockaddr_in_init
  (servaddr, AF_INET, inaddr, inport)
//
val
sockfd =
$extfcall
(
  int
, "socket"
, AF_INET, SOCK_STREAM, 0
) (* $extfcall *)
//
val ((*void*)) = assertloc (sockfd >= 0)
//
extvar "theSockID" = sockfd
//
val () =
$extfcall
(
  void
, "atslib_libats_libc_bind_exn"
, sockfd, addr@servaddr, socklen_in
) (* $extfcall *)
//
val () =
$extfcall
(
  void
, "atslib_libats_libc_listen_exn", sockfd, 5(*LISTENQSZ*)
) (* $extfcall *)
//
} (* end of [myserver_init] *)

(* ****** ****** *)

implement
myserver_waitfor_request
  ((*void*)) = let
//
val fd = $extval(int, "theSockID")
val fd2 =
$extfcall
(
  int
, "accept", fd, 0(*addr*), 0(*addrlen*)
) (* $extfcall *)
//
in
  $UN.cast{request}(fd2)
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
Hello from myserver!
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

%{^
typedef char *charptr;
%} // end of [%{^]
abstype charptr = $extype"charptr"

(* ****** ****** *)

implement
myserver_process_request
  (req) = let
//
val fd2 = $UN.cast{int}(req)
//
var buf = @[byte][BUFSZ]()
var buf2 = @[byte][BUFSZ2]()
//
val bufp = addr@buf and bufp2 = addr@buf2
//
val nread = $extfcall(ssize_t, "read", fd2, bufp, BUFSZ)
//
(*
val () = println! ("myserver_process_request: nread = ", nread)
*)
//
var time = time_get()
val tmstr = $extfcall(charptr, "ctime", addr@time)
//
val () =
if
nread >= 0
then let
  val [n:int] n = $UN.cast{Size}(nread)
  val () = $UN.ptr0_set_at<char> (bufp, n, '\000')
//
  val nbyte =
    $extfcall(int, "snprintf", bufp2, BUFSZ2, theRespFmt, bufp, tmstr)
  // end of [val]
//
  val nwrit = $extfcall (ssize_t, "write", fd2, bufp2, min(nbyte, BUFSZ2))
//
in
  // nothing
end // end of [then]
//
//
val err = $extfcall (int, "close", fd2)
//
in
  // nothing
end // end of [myserver_process_request]

(* ****** ****** *)

(* end of [myserver.dats] *)
