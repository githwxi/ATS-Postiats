//
// A simple example
// for testing hiredis_ML
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

val () =
{
//
var err: int = 0
//
val ctx = redisConnect ("127.0.0.1", 6379)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val rds = redis_ping (ctx, err)
val () = println! ("PING: ", rds)
//
val rds = redis_auth (ctx, "xyz", err)
val () = println! ("AUTH: ", rds)
//
val rds =
redis_echo (ctx, "Hello, world!", err)
val () = println! ("ECHO: ", rds)
//
val-RDSnil() =
  redis_get (ctx, "nonexistentkey", err)
//
val _ = redis_set_int (ctx, "foo", 0, err)
val-RDSstring(str) = redis_get (ctx, "foo", err)
val () = println! ("foo = ", str)
val-RDSstring(str) = redis_getset_string (ctx, "foo", "1", err)
val () = println! ("foo(old) = ", str)
val-RDSstring(str) = redis_get (ctx, "foo", err)
val () = println! ("foo(new) = ", str)
val-RDSinteger(len) = redis_strlen (ctx, "foo", err)
val () = println! ("STRLEN foo = ", len)
//
val _ = redis_del (ctx, "counter", err)
//
val-RDSinteger
  (i) = redis_exists (ctx, "counter", err)
val () = println! ("EXISTS counter = ", i)
//
val ret =
  redis_incr (ctx, "counter", err)
val () = println! ("counter = ", ret)
val ret =
  redis_decr (ctx, "counter", err)
val () = println! ("counter = ", ret)
val-RDSstring (int) = redis_get (ctx, "counter", err)
val () = println! ("counter = ", int)
//
val _ = redis_del (ctx, "mylist", err)
val len = redis_llen (ctx, "mylist", err)
val () = println! ("length(mylist) = ", len)
val _ = redis_rpush_int (ctx, "mylist", 1, err)
val _ = redis_rpush_int (ctx, "mylist", 2, err)
//
val len = redis_llen (ctx, "mylist", err)
val () = println! ("length(mylist) = ", len)
//
val rds =
redis_lrange (ctx, "mylist", 0, ~1, err)
val () = println! ("mylist = ", rds)
//
val _ =
redis_lpush_int (ctx, "mylist", 0, err)
//
val rds =
redis_lrange (ctx, "mylist", 0,  2, err)
val () = println! ("mylist = ", rds)
//
val _ = redis_lpop (ctx, "mylist", err)
val _ = redis_rpop (ctx, "mylist", err)
//
val rds =
redis_lrange (ctx, "mylist", 0, ~1, err)
val () = println! ("mylist = ", rds)
//
val _ = redis_sadd_int (ctx, "myset", 0, err)
val _ = redis_sadd_int (ctx, "myset", 2, err)
val _ = redis_sadd_int (ctx, "myset", 4, err)
val _ = redis_sadd_int (ctx, "myset", 6, err)
//
val rds =
  redis_sadd_int (ctx, "myset", 8, err)
val () = println! ("SADD myset 8: ", rds)
val rds =
  redis_srem_int (ctx, "myset", 8, err)
val () = println! ("SREM myset 8: ", rds)
//
val rds =
  redis_sismember_int (ctx, "myset", 0, err)
val () = println! ("SISMEMBER myset 0: ", rds)
val rds =
  redis_sismember_int (ctx, "myset", 1, err)
val () = println! ("SISMEMBER myset 1: ", rds)
//
val rds =
redis_smembers (ctx, "myset", err)
val () = println! ("myset = ", rds)
val rds =
  redis_spop (ctx, "myset", err)
val () = println! ("SPOP: ", rds)
val rds =
redis_smembers (ctx, "myset", err)
val () = println! ("myset = ", rds)
//
val _ =
  redis_hset_int (ctx, "myhtable", "a", 0, err)
val _ =
  redis_hset_int (ctx, "myhtable", "b", 1, err)
val _ =
  redis_hset_int (ctx, "myhtable", "c", 2, err)
//
val _ = redis_hincrby (ctx, "myhtable", "c", 10, err)
//
val rds =
redis_hget(ctx, "myhtable", "c", err)
val () = println! ("HGET c: ", rds)
//
val rds =
redis_hdel(ctx, "myhtable", "c", err)
val ((*void*)) = println! ("HDEL c: ", rds)
val rds =
redis_hdel(ctx, "myhtable", "c", err)
val ((*void*)) = println! ("HDEL c: ", rds)
//
val rds =
redis_hexists(ctx, "myhtable", "c", err)
val ((*void*)) = println! ("HEXISTS c: ", rds)
//
val rds =
  redis_hlen (ctx, "myhtable", err)
val () = println! ("HLEN myhtable: ", rds)
val rds =
  redis_hkeys (ctx, "myhtable", err)
val () = println! ("HKEYS myhtable: ", rds)
val rds =
  redis_hvals (ctx, "myhtable", err)
val () = println! ("HVALS myhtable: ", rds)
//
val rds =
  redis_hgetall (ctx, "myhtable", err)
val () = println! ("HGETALL myhtable: ", rds)
//
val rds =
  redis_keys (ctx, "*", err)
val () = println! ("KEYS *: ", rds)
val rds = redis_flushdb (ctx, err)
val () = println! ("FLUSHDB: ", rds)
//
val () = println! ("QUIT: ", redis_quit (ctx))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* en of [test02.dats] *)
