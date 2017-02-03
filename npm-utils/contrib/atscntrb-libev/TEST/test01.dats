//
// Some code for testing
// the API in ATS for libev
//
(* ****** ****** *)
//
staload
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)

%{^
//
#undef ATSextfcall
//
#define ATSextfcall(f, xs) f xs
//
%} // end of [%{^]

(* ****** ****** *)
//
staload "./../SATS/ev.sats"
//
(* ****** ****** *)

fun stdin_cb
(
  loop: ev_loop_ref, watcher: &ev_io >> _, revents: int
) : void =
{
  val _ = puts ("stdin ready")
  val () = ev_io_stop (loop, watcher)
  val () = ev_break (loop, EVBREAK_ALL)
}

(* ****** ****** *)

fun timeout_cb
(
  loop: ev_loop_ref, watcher: &ev_timer >> _, revents: int
) : void =
{
  val _ = puts ("timeout");
  val () = ev_break (loop, EVBREAK_ONE)
}

(* ****** ****** *)

implement
main0 () = () where
{
//
val loop = EV_DEFAULT
//
var stdin_watcher: ev_io?
var timeout_watcher: ev_timer?
//
val () = ev_init_io (stdin_watcher, stdin_cb)
val () =
$extfcall
(
  void, "ev_io_set", addr@stdin_watcher, 0(*STDIN_FILENO*), EV_READ
) (* end of [val] *)
val () = ev_io_start (loop, stdin_watcher)
//
val () = ev_init_timer (timeout_watcher, timeout_cb)
val () = $extfcall (void, "ev_timer_set", addr@timeout_watcher, 2.5, 0.0)
val () = ev_timer_start (loop, timeout_watcher)
//
local
//
// HX-2014-05:
// for backward compatibility
//
extern
fun ev_run (loop: ev_loop_ref, flags: int): void = "mac#"
in(*in-of-local*)
val _(*cnt*) = ev_run (loop, 0)
end // end of [loop]
//
} (* end of [main0] *)

(* ****** ****** *)

(*

/*
** original source of the file:
** http://cvs.schmorp.de/libev/ev.pod
*/

#include <ev.h>
#include <stdio.h> // for puts

// every watcher type has its own typedef'd struct
// with the name ev_TYPE
ev_io stdin_watcher;
ev_timer timeout_watcher;

// all watcher callbacks have a similar signature
// this callback is called when data is readable on stdin
static void
stdin_cb (EV_P_ ev_io *w, int revents)
{
  puts ("stdin ready");
  // for one-shot events, one must manually stop the watcher
  // with its corresponding stop function.
  ev_io_stop (EV_A_ w);

  // this causes all nested ev_run's to stop iterating
  ev_break (EV_A_ EVBREAK_ALL);
}

// another callback, this time for a time-out
static void
timeout_cb (EV_P_ ev_timer *w, int revents)
{
  puts ("timeout");
  // this causes the innermost ev_run to stop iterating
  ev_break (EV_A_ EVBREAK_ONE);
}

int
main (void)
{
  // use the default event loop unless you have special needs
  struct ev_loop *loop = EV_DEFAULT;

  // initialise an io watcher, then start it
  // this one will watch for stdin to become readable
  ev_io_init (&stdin_watcher, stdin_cb, /*STDIN_FILENO*/ 0, EV_READ);
  ev_io_start (loop, &stdin_watcher);

  // initialise a timer watcher, then start it
  // simple non-repeating 5.5 second timeout
  ev_timer_init (&timeout_watcher, timeout_cb, 5.5, 0.);
  ev_timer_start (loop, &timeout_watcher);

  // now wait for events to arrive
  ev_run (loop, 0);

  // break was called, so exit
  return 0;
} // end of [main]

*)

(* ****** ****** *)

(* end of [test01.dats] *)
