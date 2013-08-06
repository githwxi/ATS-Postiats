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

val arg = "fact_arg"
val res = "fact_res"

(* ****** ****** *)

fun fact
  (n: int): void = let
//
fun loop
(
  ctx: !redisContext1
) : void = let
//
val-RDSstring(n) = redis_get (ctx, arg)
val n = g0string2int_int (n)
//
in
//
if n > 0 then let
//
val _ = redis_set_int (ctx, arg, n-1)
val-RDSstring(r) = redis_get (ctx, res)
val r = g0string2int_int (r)
val _ = redis_set_int (ctx, res, n*r)
//
in
  loop (ctx)
end // end of [if]
//
end // end of [loop]
//
val ctx =
  redisConnect ("127.0.0.1", 6379)
val () = assertloc (ptrcast(ctx) > 0)
//
val _ = redis_set_int (ctx, arg, n)
val _ = redis_set_int (ctx, res, 1)
val () = loop (ctx)
val-RDSstring (r) = redis_get (ctx, res)
//
val ((*void*)) = redisFree (ctx)
//
in
  println! ("fact(", n, ") = ", r)
end // end of [fact]

(* ****** ****** *)

implement
main0 () =
{
//
val () = fact (10)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fact.dats] *)
