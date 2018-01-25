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
//
staload "./../SATS/hiredis.sats"
staload "./../SATS/hiredis_ML.sats"
//
staload _(*anon*) = "./../DATS/hiredis.dats"
//
(* ****** ****** *)

#define TIMEOUT 1.0

(* ****** ****** *)

val () =
{
//
var err: int = 0
//
val ip = "127.0.0.1"
//
val ctx =
redisConnectWithTimeout (ip, 6379, TIMEOUT)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val () = println! ("test03_1: connected!")
//
val rdsv = redis_del (ctx, "test03_list", err)
//
val rdsv =
  redis_lpush_string (ctx, "test03_list", "first", err)
val ((*void*)) = println! ("test03_1: lpush: rdsv = ", rdsv)
//
val rdsv =
  redis_lpush_string (ctx, "test03_list", "second", err)
val ((*void*)) = println! ("test03_1: lpush: rdsv = ", rdsv)
//
val rdsv =
  redis_lpush_string (ctx, "test03_list", "third", err)
val ((*void*)) = println! ("test03_1: lpush: rdsv = ", rdsv)
//
val-RDSstatus("OK") = redis_quit (ctx)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test03_1.dats] *)
