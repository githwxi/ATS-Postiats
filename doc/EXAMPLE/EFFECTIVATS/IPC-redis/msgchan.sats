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
  chan: msgchan, msg: string, err: &int >> _
) : void // end of [msgchan_insert]
//
fun msgchan_takeout
  (chan: msgchan, err: &int >> _): stropt // blocking
(*
fun msgchan_takeout_try
  (chan: msgchan, err: &int >> _): stropt // non-blocking
*)
//
(* ****** ****** *)

(* end of [msgchan.sats] *)
