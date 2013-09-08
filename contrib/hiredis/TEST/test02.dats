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
val ctx = redisConnect ("127.0.0.1", 6379)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val rds = redis_ping (ctx)
val () = println! ("PING: ", rds)
//
val rds = redis_auth (ctx, "xyz")
val () = println! ("AUTH: ", rds)
//
val rds = redis_echo (ctx, "Hello, world!")
val () = println! ("ECHO: ", rds)
//
val-RDSnil() = redis_get (ctx, "nonexistentkey")
//
val _ = redis_set_int (ctx, "foo", 0)
val-RDSstring (str) = redis_get (ctx, "foo")
val () = println! ("foo = ", str)
val-RDSstring (str) = redis_getset_string (ctx, "foo", "1")
val () = println! ("foo(old) = ", str)
val-RDSstring (str) = redis_get (ctx, "foo")
val () = println! ("foo(new) = ", str)
val-RDSinteger (len) = redis_strlen (ctx, "foo")
val () = println! ("STRLEN foo = ", len)
//
val _ = redis_del (ctx, "counter")
//
val-RDSinteger
  (i) = redis_exists (ctx, "counter")
val () = println! ("EXISTS counter = ", i)
//
val ret = redis_incr (ctx, "counter")
val () = println! ("counter = ", ret)
val ret = redis_decr (ctx, "counter")
val () = println! ("counter = ", ret)
val-RDSstring (int) = redis_get (ctx, "counter")
val () = println! ("counter = ", int)
//
val _ = redis_del (ctx, "mylist")
val len = redis_llen (ctx, "mylist")
val () = println! ("length(mylist) = ", len)
val _ = redis_rpush_int (ctx, "mylist", 1)
val _ = redis_rpush_int (ctx, "mylist", 2)
val len = redis_llen (ctx, "mylist")
val () = println! ("length(mylist) = ", len)
//
val rds =
redis_lrange (ctx, "mylist", 0, ~1)
val () = println! ("mylist = ", rds)
//
val _ = redis_lpush_int (ctx, "mylist", 0)
//
val rds =
redis_lrange (ctx, "mylist", 0,  2)
val () = println! ("mylist = ", rds)
//
val _ = redis_lpop (ctx, "mylist")
val _ = redis_rpop (ctx, "mylist")
//
val rds =
redis_lrange (ctx, "mylist", 0, ~1)
val () = println! ("mylist = ", rds)
//
val _ = redis_sadd_int (ctx, "myset", 0)
val _ = redis_sadd_int (ctx, "myset", 2)
val _ = redis_sadd_int (ctx, "myset", 4)
val _ = redis_sadd_int (ctx, "myset", 6)
//
val rds = redis_sadd_int (ctx, "myset", 8)
val () = println! ("SADD myset 8: ", rds)
val rds = redis_srem_int (ctx, "myset", 8)
val () = println! ("SREM myset 8: ", rds)
//
val rds =
  redis_sismember_int (ctx, "myset", 0)
val () = println! ("SISMEMBER myset 0: ", rds)
val rds = redis_sismember_int (ctx, "myset", 1)
val () = println! ("SISMEMBER myset 1: ", rds)
//
val rds = redis_smembers (ctx, "myset")
val () = println! ("myset = ", rds)
val () = println! ("SPOP: ", redis_spop (ctx, "myset"))
val rds = redis_smembers (ctx, "myset")
val () = println! ("myset = ", rds)
//
val _ = redis_hset_int (ctx, "myhtable", "a", 0)
val _ = redis_hset_int (ctx, "myhtable", "b", 1)
val _ = redis_hset_int (ctx, "myhtable", "c", 2)
//
val _ = redis_hincrby (ctx, "myhtable", "c", 10)
//
val () = println! ("HGET c: ", redis_hget(ctx, "myhtable", "c"))
//
val () = println! ("HDEL c: ", redis_hdel(ctx, "myhtable", "c"))
val () = println! ("HDEL c: ", redis_hdel(ctx, "myhtable", "c"))
//
val () = println! ("HEXISTS c: ", redis_hexists(ctx, "myhtable", "c"))
//
val rds = redis_hlen (ctx, "myhtable")
val () = println! ("HLEN myhtable: ", rds)
val rds = redis_hkeys (ctx, "myhtable")
val () = println! ("HKEYS myhtable: ", rds)
val rds = redis_hvals (ctx, "myhtable")
val () = println! ("HVALS myhtable: ", rds)
//
val rds = redis_hgetall (ctx, "myhtable")
val () = println! ("HGETALL myhtable: ", rds)
//
val () =
println! ("KEYS *: ", redis_keys (ctx, "*"))
val (
) = println! ("FLUSHDB: ", redis_flushdb (ctx))
//
val () = println! ("QUIT: ", redis_quit (ctx))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* en of [test02.dats] *)
