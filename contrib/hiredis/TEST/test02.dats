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
val ctx =
redisConnectWithTimeout ("127.0.0.1", 6379, 1.0)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val () = redis_set_int (ctx, "foo", 0)
val-RDSVstring (str) = redis_get_val (ctx, "foo")
val () = println! ("str = ", str)
//
val () = redis_set_string (ctx, "foo", "1")
val-RDSVstring (str) = redis_get_val (ctx, "foo")
val () = println! ("str = ", str)
//
val ((*void*)) = redisFree (ctx)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* en of [test02.dats] *)
