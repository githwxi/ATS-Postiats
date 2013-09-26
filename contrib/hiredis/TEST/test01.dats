//
// A simple example for testing hiredis
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/hiredis.sats"
staload _(*anon*) = "./../DATS/hiredis.dats"

(* ****** ****** *)

val () =
{
  val () = println! ("The version of [hiredis]: ", hiredis_version ())
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val ctx =
redisConnectWithTimeout ("127.0.0.1", 6379, 1.0)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val err = redis_get_err (ctx)
val () = println! ("err = ", err)
val
(
fpf | str
) = redis_get_errstr (ctx)
val ((*void*)) = println! ("errstr = ", str)
prval ((*void*)) = fpf (str)
//
val () = assertloc (err = REDIS_OK)
//
val pctx = ptrcast (ctx)
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "PING"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val (fpf | str) = redisReply_get_status (rep)
val () = println! ("PING: ", str)
prval () = fpf (str)
val () = freeReplyObject (rep)
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "SET %s %s", "foo", "hello world"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val (fpf | str) = redisReply_get_status (rep)
val () = println! ("SET: ", str)
prval () = fpf (str)
val () = freeReplyObject (rep)
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "GET foo"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val (fpf | str) = redisReply_get_string (rep)
val () = println! ("GET foo: ", str)
prval () = fpf (str)
val () = freeReplyObject (rep)
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "SET %b %b", "foo", i2sz(3), "hello world", i2sz(5)
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val (fpf | str) = redisReply_get_status (rep)
val () = println! ("SET(bin): ", str)
prval () = fpf (str)
val () = freeReplyObject (rep)
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "GET foo"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val (fpf | str) = redisReply_get_string (rep)
val () = println! ("GET foo: ", str)
prval () = fpf (str)
val () = freeReplyObject (rep)
//
val rep = 
$extfcall (
  redisReply0
, "redisCommand", pctx, "DEL counter"
) // end of [val]
val () = freeReplyObject (rep)
val rep = 
$extfcall (
  redisReply0
, "redisCommand", pctx, "INCR counter"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val repint = redisReply_get_integer (rep)
val () = println! ("INCR counter: ", repint)
val () = freeReplyObject (rep)
val rep = 
$extfcall (
  redisReply0
, "redisCommand", pctx, "INCR counter"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val repint = redisReply_get_integer (rep)
val () = println! ("INCR counter: ", repint)
val () = freeReplyObject (rep)
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "DEL mylist"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val int = redisReply_get_integer (rep)
val () = println! ("DEL mylist: ", int)
val () = freeReplyObject(rep);
//
val rep = 
$extfcall (
  redisReply0
, "redisCommand", pctx, "LPUSH mylist element-%s", "0"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val repint = redisReply_get_integer (rep)
val () = println! ("LPUSH mylist: ", repint)
val () = freeReplyObject(rep);
//
val rep = 
$extfcall (
  redisReply0
, "redisCommand", pctx, "LPUSH mylist element-%s", "1"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
val repint = redisReply_get_integer (rep)
val () = println! ("LPUSH mylist: ", repint)
val () = freeReplyObject(rep);
//
val rep =
$extfcall (
  redisReply0
, "redisCommand", pctx, "LRANGE mylist 0 -1"
) // end of [val]
val () = assertloc (ptrcast (rep) > 0)
var asz: size_t (* uninitialized *)
val (pfarr, fpf | p) = redisReply_get_array (rep, asz)
val () = println! ("LRANGE: size: ", asz)
prval () = fpf (pfarr)
val () = freeReplyObject(rep)
//
val ((*void*)) = redisFree (ctx)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test01.dats] *)
