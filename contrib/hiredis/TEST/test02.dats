//
// A simple example for testing hiredis_ML
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "hiredis/SATS/hiredis.sats"
staload _(*anon*) = "hiredis/DATS/hiredis.dats"

(* ****** ****** *)

staload "hiredis/SATS/hiredis_ML.sats"

(* ****** ****** *)

val () =
{
//
val ctx = redisConnect ("127.0.0.1", 6379)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val r = redis_ping (ctx)
val () = println! ("PING: ", r)
//
val _ = redis_set_int (ctx, "foo", 0)
val-RDSstring (str) = redis_get (ctx, "foo")
val () = println! ("foo = ", str)
val-RDSstring (str) = redis_getset_string (ctx, "foo", "1")
val () = println! ("foo(old) = ", str)
val-RDSstring (str) = redis_get (ctx, "foo")
val () = println! ("foo(new) = ", str)
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
val rdsv =
redis_lrange (ctx, "mylist", 0, ~1)
val () = println! ("mylist = ", rdsv)
//
val _ = redis_lpush_int (ctx, "mylist", 0)
//
val rdsv =
redis_lrange (ctx, "mylist", 0,  2)
val () = println! ("mylist = ", rdsv)
//
val _ = redis_lpop (ctx, "mylist")
val _ = redis_rpop (ctx, "mylist")
//
val rdsv =
redis_lrange (ctx, "mylist", 0, ~1)
val () = println! ("mylist = ", rdsv)
//
val ((*void*)) = redisFree (ctx)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* en of [test02.dats] *)
