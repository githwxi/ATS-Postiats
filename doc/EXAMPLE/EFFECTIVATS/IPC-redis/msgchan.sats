(*
** message channels
*)

(* ****** ****** *)
//  
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: December, 2013
//
(* ****** ****** *)
//
abstype
msgchan_type = ptr
//
typedef msgchan = msgchan_type
//
(* ****** ****** *)
//
fun
msgchan_create (name: string): msgchan
//
(* ****** ****** *)
//
fun msgchan_insert
(
  chan: msgchan, msg: string, nerr: &int >> _
) : void // end of [msgchan_insert]
//
fun msgchan_takeout
  (chan: msgchan, nerr: &int >> _): stropt // blocking
(*
fun msgchan_takeout_try
  (chan: msgchan, nerr: &int >> _): stropt // non-blocking
*)
//
(* ****** ****** *)

fun msgchan_insert2
(
  chan: msgchan, msg: string, nerr: &int >> _
) : void // end of [msgchan_insert2]

(* ****** ****** *)

fun msgchan_takeout2
  (chan: msgchan, nerr: &int >> _) : stropt

(* ****** ****** *)

(* end of [msgchan.sats] *)
