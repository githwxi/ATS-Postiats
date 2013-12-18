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
staload "./redisContextSetup.dats"

(* ****** ****** *)

staload "{$HIREDIS}/SATS/hiredis.sats"
staload "{$HIREDIS}/SATS/hiredis_ML.sats"
staload _(*anon*) = "{$HIREDIS}/DATS/hiredis.dats"

(* ****** ****** *)

local
//
datatype
msgchan =
MSGCHAN of (string(*name*), string(*key*))
assume msgchan_type = msgchan
//
fun
chankey_make_name (name: string): string = name
//
fun msgchan_get_key
  (chan: msgchan): string =
  let val MSGCHAN (name, key) = chan in key end
//
in (* in of [local] *)

implement
msgchan_create (name) = let
  val key = chankey_make_name (name) in MSGCHAN(name, key)
end // end of [msgchan_create]

(* ****** ****** *)

implement
msgchan_insert
  (chan, msg, nerr) = let
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
    val key = msgchan_get_key (chan)
  in
    redis_lpush_string (ctx, key, msg, nerr)
  end // end of [then]
  else let
    val () = nerr := nerr + 1 in RDSnil(*void*)
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
  (chan, nerr) = let
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
    val key = msgchan_get_key (chan)
  in
    redis_brpop (ctx, key, 0u(*blocking*), nerr)
  end // end of [then]
  else let
    val () = nerr := nerr + 1 in RDSnil(*void*)
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

implement
msgchan_insert2
(
  chan, msg, nerr
) = () where
{
  val nerr0 = nerr
  val () = msgchan_insert (chan, msg, nerr)
  val () =
  if nerr > nerr0 then
  {
    val () = nerr := nerr0
    val () = the_redisContext_reset ()
    val () = msgchan_insert (chan, msg, nerr)
  } (* end of [val] *)
} (* end of [msgchan_insert2] *)

(* ****** ****** *)

implement
msgchan_takeout2
  (chan, nerr) = msg where
{
//
  var msg: stropt = stropt_none ()
//
  val nerr0 = nerr
  val msg = msgchan_takeout (chan, nerr)
  val () =
  if nerr > nerr0 then
  {
    val () = nerr := nerr0
    val () = the_redisContext_reset ()
    val msg = msgchan_takeout (chan, nerr)
  } (* end of [val] *)
//
} (* end of [msgchan_takeout2] *)

(* ****** ****** *)

(* end of [msgchan.dats] *)
