(*
** Implementing Tetris
** This is a case study on
** combining ATS with Objective-C
*)

(* ****** ****** *)

(*
**
** Author: Chen GUO
** Authoremail: ...
** Author: Hongwei XI
** Authoremail: gmhwxiATgmailDOTcom
**
*)

(* ****** ****** *)
//
// HX:
// the current game state
//
abstype gmstate_type = ptr
typedef gmstate = gmstate_type
//
(* ****** ****** *)
//
// HX: for game events
//
abstype gmevent_type = ptr
typedef gmevent = gmevent_type
//
(* ****** ****** *)

fun gmstate_poll_wait (): void

(* ****** ****** *)

fun gmstate_poll_event (): Option_vt (gmevent)

(* ****** ****** *)

fun gmstate_handle_event (gmevent): void

(* ****** ****** *)

(* end of [tetris.sats] *)
