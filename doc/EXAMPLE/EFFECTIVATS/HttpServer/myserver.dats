(*
** Effective ATS:
** A simple Http-server
*)

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

implement
myserver_init () =
{
//
val () = println! ("myserver_init: start")
val () = println! ("myserver_init: finish")
//
} (* end of [myserver_init] *)

(* ****** ****** *)

abstype request

(* ****** ****** *)
//
extern
fun myserver_waitfor_request (): request
extern
fun myserver_process_request (request): void
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

(* end of [myserver.dats] *)
