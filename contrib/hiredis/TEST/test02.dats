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
val () = redis_set_int (ctx, "foo", 0)
val-RDSVstring (str) = redis_get (ctx, "foo")
val () = println! ("foo = ", str)
val-RDSVstring (str) = redis_getset_string (ctx, "foo", "1")
val () = println! ("foo(old) = ", str)
val-RDSVstring (str) = redis_get (ctx, "foo")
val () = println! ("foo(new) = ", str)
//
val () = redis_del (ctx, "counter")
val ret = redis_incr (ctx, "counter")
val () = println! ("counter = ", ret)
val ret = redis_decr (ctx, "counter")
val () = println! ("counter = ", ret)
val-RDSVstring (int) = redis_get (ctx, "counter")
val () = println! ("counter = ", int)
//
val () = redis_del (ctx, "mylist")
val len = redis_llen (ctx, "mylist")
val () = println! ("length(mylist) = ", len)
val () = redis_rpush_int (ctx, "mylist", 1)
val () = redis_rpush_int (ctx, "mylist", 2)
val len = redis_llen (ctx, "mylist")
val () = println! ("length(mylist) = ", len)
//
val rdsv =
redis_lrange (ctx, "mylist", 0, ~1)
val () = println! ("mylist = ", rdsv)
//
val () = redis_lpush_int (ctx, "mylist", 0)
//
val rdsv =
redis_lrange (ctx, "mylist", 0,  2)
val () = println! ("mylist = ", rdsv)
//
val () = redis_lpop (ctx, "mylist")
val () = redis_rpop (ctx, "mylist")
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
