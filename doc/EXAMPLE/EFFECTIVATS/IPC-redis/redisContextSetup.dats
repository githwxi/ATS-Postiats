(* ****** ****** *)
//
// For setting up redis connection
//
(* ****** ****** *)
//  
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: December, 2013
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "{$HIREDIS}/SATS/hiredis.sats"
staload "{$HIREDIS}/SATS/hiredis_ML.sats"
staload _(*anon*) = "{$HIREDIS}/DATS/hiredis.dats"

(* ****** ****** *)

#include "params.hats"

(* ****** ****** *)
//
extern
fun
the_redisContext_set (redisContext1): void
//
extern
fun the_redisContext_unset ((*void*)): void
extern
fun the_redisContext_reset ((*void*)): void
//
extern
fun the_redisContext_vtget ((*void*))
  :<!ref> [l:addr] vttakeout0 (redisContext(l))
//
(* ****** ****** *)

local

val r0 =
ref<ptr> (the_null_ptr)

vtypedef vt0 = [l:addr] vttakeout0(redisContext(l))

in (* in of [local] *)

implement
the_redisContext_set
  (ctx) =
(
  !r0 := $UN.castvwtp0{ptr}(ctx)
)

implement
the_redisContext_unset () = let
  val ctx = !r0
  val ((*void*)) = !r0 := the_null_ptr
in
  redisFree ($UN.castvwtp0{redisContext0}(ctx))
end // end of [the_redisContext_unset]

implement
the_redisContext_reset () = let
//
  val ctx = !r0
  val () =
    redisFree ($UN.castvwtp0{redisContext0}(ctx))
  val ip = "127.0.0.1"
  val ctx = redisConnectWithTimeout (ip, 6379, TIMEOUT)
  val () = !r0 := $UN.castvwtp0{ptr}(ctx)
//
in
  // nothing
end // end of [the_redisContext_reset]

implement
the_redisContext_vtget () = $UN.castvwtp0{vt0}(!r0)

end // end of [local]

(* ****** ****** *)

(* end of [redisContextSetup.hats] *)
