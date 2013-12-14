(*
** message channels
*)

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

staload "./msgchan.sats"

(* ****** ****** *)

staload "{$HIREDIS}/SATS/hiredis.sats"
staload "{$HIREDIS}/SATS/hiredis_ML.sats"
staload _(*anon*) = "{$HIREDIS}/DATS/hiredis.dats"

(* ****** ****** *)
//
extern
fun the_redisContext_vtget
  ((*void*)):<!ref> [l:addr] vttakeout0 (redisContext(l)) = "ext#"
//
(* ****** ****** *)

local
//
datatype
msgchan = MSGCHAN of string
assume msgchan_type = msgchan
//
fun
chan_name_test
  (name: string): bool = true
//
in (* in of [local] *)

implement
msgchan_create_opt
  (name) = let
//
val test = chan_name_test (name)
//
in
  if test then Some_vt{msgchan}(MSGCHAN(name)) else None_vt(*void*)
end // end of [msgchan_create_opt]

(* ****** ****** *)

implement
msgchan_insert
  (chan, msg, err) = let
//
val (
  fpf | ctx
) = the_redisContext_vtget ()
//
val p_ctx = ptrcast (ctx)
//
val rds =
(
if p_ctx > 0
  then let
    val MSGCHAN (name) = chan
  in
    redis_lpush_string (ctx, name, msg, err)
  end // end of [then]
  else let
    val () = err := err + 1 in RDSnil(*void*)
  end // end of [else]
// end of [if]
) : redisVal // end of [val]
//
prval ((*void*)) = fpf (ctx)
//
in
  // nothing
end // end of [msgchan_insert]

(* ****** ****** *)

implement
msgchan_takeout
  (chan, err) = let
//
val (
  fpf | ctx
) = the_redisContext_vtget ()
//
val p_ctx = ptrcast (ctx)
//
val rds =
(
if p_ctx > 0
  then let
    val MSGCHAN (name) = chan
  in
    redis_brpop (ctx, name, 0u, err)
  end // end of [then]
  else let
    val () = err := err + 1 in RDSnil(*void*)
  end // end of [else]
// end of [if]
) : redisVal // end of [val]
//
prval ((*void*)) = fpf (ctx)
//
in
//
case+ rds of
| RDSarray (A, n) => let
    val (
    ) = assertloc (n >= 2)
    val-RDSstring (msg) = A[1]
  in
    stropt_some (msg)
  end // end of [RDSarray]
| _ => stropt_none ((*void*))
//
end // end of [msgchan_takeout]

end // end of [local]

(* ****** ****** *)

(* end of [msgchan.dats] *)
