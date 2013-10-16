(*
** Implementing Tetris
** This is a case study on
** combining ATS with Objective-C
*)

(* ****** ****** *)

(*
**
** Author: Chen GUO
** Authoremail: gessichenATgmailDOTcom
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

abstype gmshape_type = ptr
typedef gmshape = gmshape_type

fun gmshape_get_X (gmshape): int // nrow
fun gmshape_get_Y (gmshape): int // ncol

fun gmshape_locate (knd: int): gmshape

(* ****** ****** *)

abstype gmregion_type = ptr
typedef gmregion = gmregion_type

fun gmregion_get_X (gmregion): int // nrow
fun gmregion_get_Y (gmregion): int // ncol

fun gmregion_get_at (gmregion, int, int): int(*kind*)

(* ****** ****** *)

(* end of [tetris.sats] *)
