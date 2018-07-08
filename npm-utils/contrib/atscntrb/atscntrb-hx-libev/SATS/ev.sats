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
// Author: Hongwei Xi
// Start Time: May, 2014
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

%{#
//
#include \
"atscntrb-hx-libev/CATS/ev.cats"
//
%} // end of [%{]

(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.libev"
#define
ATS_EXTERN_PREFIX "atscntrb_libev_" // prefix for external names

(* ****** ****** *)
//
macdef EV_UNDEF = $extval (int, "EV_UNDEF")
macdef EV_NONE = $extval (int, "EV_NONE")
macdef EV_READ = $extval (int, "EV_READ")
macdef EV_WRITE = $extval (int, "EV_WRITE")
macdef EV__IOFDSET = $extval (int, "EV__IOFDSET")
macdef EV_IO = $extval (int, "EV_IO")
macdef EV_TIMER = $extval (int, "EV_TIMER")
macdef EV_TIMEOUT = $extval (int, "EV_TIMEOUT")
macdef EV_PERIODIC = $extval (int, "EV_PERIODIC")
macdef EV_SIGNAL = $extval (int, "EV_SIGNAL")
macdef EV_CHILD = $extval (int, "EV_CHILD")
macdef EV_STAT = $extval (int, "EV_STAT")
macdef EV_IDLE = $extval (int, "EV_IDLE")
macdef EV_PREPARE = $extval (int, "EV_PREPARE")
macdef EV_CHECK = $extval (int, "EV_CHECK")
macdef EV_EMBED = $extval (int, "EV_EMBED")
macdef EV_FORK = $extval (int, "EV_FORK")
macdef EV_CLEANUP = $extval (int, "EV_CLEANUP")
macdef EV_ASYNC = $extval (int, "EV_ASYNC")
macdef EV_CUSTOM = $extval (int, "EV_CUSTOM")
macdef EV_ERROR = $extval (int, "EV_ERROR")
//
(* ****** ****** *)

(*
**
** Global functions
**
*)

(* ****** ****** *)

abst@ype
ev_tstamp = $extype"ev_tstamp"

(* ****** ****** *)
//
castfn ev_tstamp_of_int: int -> ev_tstamp
castfn ev_tstamp_of_double: double -> ev_tstamp
//
symintr ev_tstamp
overload ev_tstamp with ev_tstamp_of_int
overload ev_tstamp with ev_tstamp_of_double
//
(* ****** ****** *)

fun ev_time ((*void*)): ev_tstamp = "mac#%"

(* ****** ****** *)

fun ev_sleep (interval: ev_tstamp): void = "mac#%"

(* ****** ****** *)

macdef
EV_VERSION_MAJOR = $extval (int, "EV_VERSION_MAJOR")
macdef
EV_VERSION_MINOR = $extval (int, "EV_VERSION_MINOR")

(* ****** ****** *)

fun ev_version_major ((*void*)): int = "mac#%"
fun ev_version_minor ((*void*)): int = "mac#%"

(* ****** ****** *)
  
fun ev_supported_backends ((*void*)): uint = "mac#%"
fun ev_recommended_backends ((*void*)): uint = "mac#%"
fun ev_embeddable_backends ((*void*)): uint = "mac#%"
  
(* ****** ****** *)

fun ev_feed_signal (signum: int): void = "mac#%"

(* ****** ****** *)

(*
**
** Functions controlling event loops
**
*)

(* ****** ****** *)

abstype ev_loop_ref = ptr // HX: NZ
absvtype ev_loop_ptr(l:addr) = ptr(l)

(* ****** ****** *)
//
vtypedef
ev_loop_ptr0 = [l:agez] ev_loop_ptr(l)
vtypedef
ev_loop_ptr1 = [l:addr | l > null] ev_loop_ptr(l)
//
(* ****** ****** *)
//
castfn
ev_loop_ptr2ptr
  {l:addr}(!ev_loop_ptr(l)):<> ptr(l)
//
overload ptrcast with ev_loop_ptr2ptr
//
(* ****** ****** *)
//
// HX: only for muliplicity build
//
macdef
EV_DEFAULT = $extval (ev_loop_ref, "EV_DEFAULT")

(* ****** ****** *)

(*
** flag bits for ev_default_loop and ev_loop_new
*)
macdef EVFLAG_AUTO = $extval (uint, "EVFLAG_AUTO")
macdef EVFLAG_NOENV = $extval (uint, "EVFLAG_NOENV")
macdef EVFLAG_FORKCHECK = $extval (uint, "EVFLAG_FORKCHECK")
macdef EVFLAG_NOINOTIFY = $extval (uint, "EVFLAG_NOINOTIFY")
macdef EVFLAG_NOSIGFD = $extval (uint, "EVFLAG_NOSIGFD")
macdef EVFLAG_SIGNALFD = $extval (uint, "EVFLAG_SIGNALFD")
macdef EVFLAG_NOSIGMASK = $extval (uint, "EVFLAG_NOSIGMASK")

(* ****** ****** *)

(*
** method bits to be ored together
*)
macdef EVBACKEND_SELECT = $extval (uint, "EVBACKEND_SELECT")
macdef EVBACKEND_POLL = $extval (uint, "EVBACKEND_POLL")
macdef EVBACKEND_EPOLL = $extval (uint, "EVBACKEND_EPOLL")
macdef EVBACKEND_KQUEUE = $extval (uint, "EVBACKEND_KQUEUE")
macdef EVBACKEND_DEVPOLL = $extval (uint, "EVBACKEND_DEVPOLL")
macdef EVBACKEND_PORT = $extval (uint, "EVBACKEND_PORT")
macdef EVBACKEND_ALL = $extval (uint, "EVBACKEND_ALL")
macdef EVBACKEND_MASK = $extval (uint, "EVBACKEND_MASK")

(* ****** ****** *)

/*
fun
ev_default_loop (flags: int): ev_loop_ref = "mac#%"

(* ****** ****** *)

/*
struct ev_loop *ev_loop_new (unsigned int flags)
*/
fun ev_loop_new (flags: int): ev_loop_ptr0 = "mac#%"

(* ****** ****** *)

fun ev_loop_destroy (loop: ev_loop_ptr1): void = "mac#%"

(* ****** ****** *)

fun ev_loop_fork (loop: ev_loop_ref): void = "mac#%"

(* ****** ****** *)

fun ev_is_default_loop (loop: ev_loop_ref): bool = "mac#%"

(* ****** ****** *)
//
abst@ype
ev_io = $extype"ev_io"
typedef
ev_io_callback =
  (ev_loop_ref, &ev_io >> _, int(*revents*)) -> void
//
(* ****** ****** *)

fun ev_init_io
  (watcher: &ev_io? >> _, ev_io_callback): void = "mac#%"

(* ****** ****** *)

(*
ev_TYPE_set (ev_TYPE *watcher, [args])
ev_TYPE_init (ev_TYPE *watcher, callback, [args])
*)

(* ****** ****** *)
//
fun ev_io_start
  (ev_loop_ref, watcher: &ev_io >> _): void = "mac#%"
//
fun ev_io_stop (ev_loop_ref, &ev_io >> _): void = "mac#%"
//
(* ****** ****** *)

abst@ype
ev_timer = $extype"ev_timer"
typedef
ev_timer_callback = (ev_loop_ref, &ev_timer >> _, int(*revents*)) -> void

(* ****** ****** *)

fun ev_init_timer
  (watcher: &ev_timer? >> _, ev_timer_callback): void = "mac#%"

(* ****** ****** *)

(*
ev_TYPE_set (ev_TYPE *watcher, [args])
ev_TYPE_init (ev_TYPE *watcher, callback, [args])
*)

(* ****** ****** *)
//
fun ev_timer_start
  (ev_loop_ref, watcher: &ev_timer >> _): void = "mac#%"
//
fun ev_timer_stop (ev_loop_ref, &ev_timer >> _): void = "mac#%"
//
(* ****** ****** *)
//
macdef
EVRUN_NOWAIT = $extval (int, "EVRUN_NOWAIT")
macdef EVRUN_ONCE = $extval (int, "EVRUN_ONCE")
//
fun ev_run (loop: ev_loop_ref, flags: int): int = "mac#%"
//
(* ****** ****** *)
//
abst@ype
ev_break_how = int
//
macdef
EVBREAK_CANCEL =
$extval (ev_break_how, "EVBREAK_CANCEL")
macdef
EVBREAK_ONE = $extval (ev_break_how, "EVBREAK_ONE")
macdef
EVBREAK_ALL = $extval (ev_break_how, "EVBREAK_ALL")
//
fun ev_break (loop: ev_loop_ref, how: ev_break_how): void = "mac#%"
//
(* ****** ****** *)
//
fun{
watcher:t0ype
} ev_is_active (watcher: &watcher): bool
//
fun ev_is_active_io (watcher: &ev_io): bool = "mac#%"
fun ev_is_active_timer (watcher: &ev_timer): bool = "mac#%"
//
(* ****** ****** *)
//
fun{
watcher:t0ype
} ev_is_pending (watcher: &watcher): bool
//
fun ev_is_pending_io (watcher: &ev_io): bool = "mac#%"
fun ev_is_pending_timer (watcher: &ev_timer): bool = "mac#%"
//
(* ****** ****** *)

(* end of [ev.sats] *)
