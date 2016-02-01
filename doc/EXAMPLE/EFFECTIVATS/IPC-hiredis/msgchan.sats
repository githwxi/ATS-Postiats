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
//
// HX-2013-12-18:
// this function re-establishes redis connection and then
// calls [mschan_insert] for the second time if its first call
// to [mschan_insert] fails to insert a message.
//
fun msgchan_insert2
(
  chan: msgchan, msg: string, nerr: &int >> _
) : void // end of [msgchan_insert2]

(* ****** ****** *)
//
// HX-2013-12-18:
// this function re-establishes redis connection and then
// calls [mschan_takeout2] for the second time if its first call
// to [mschan_takeout] fails to take out a message.
//
fun msgchan_takeout2
  (chan: msgchan, nerr: &int >> _) : stropt

(* ****** ****** *)

(* end of [msgchan.sats] *)
