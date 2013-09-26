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

val arg = "fact_arg"
val res = "fact_res"

(* ****** ****** *)

fun fact
  (n: int): int = let
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
  g0string2int (r)
end // end of [fact]

(* ****** ****** *)

implement
main0 (argc, argv) = let
//
val n =
(
  if argc >= 2
    then g0string2int(argv[1]) else 10(*default*)
  // end of [if]
) : int // end of [val]
//
in
  println! ("fact(", n, ") = ", fact (n))
end // end of [main0]
          
(* ****** ****** *)

(* end of [fact.dats] *)
