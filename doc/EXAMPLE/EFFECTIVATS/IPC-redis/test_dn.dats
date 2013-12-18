(*
** downloading messages
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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#include "./params.hats"

(* ****** ****** *)

staload "./msgchan.sats"
staload "./redisContextSetup.dats"

(* ****** ****** *)

extern
fun
msgchan_dnload_fileref
  (chan: msgchan, inp: FILEref): void
implement
msgchan_dnload_fileref
(
  chan, out
) : void = let
//
var nerr: int = 0
val opt =
  msgchan_takeout2 (chan, nerr)
//
val issome = stropt_is_some (opt)  
//
in
//
if issome then let
  val str = stropt_unsome (opt)
in
  case+ str of
  | _ when str = "\n" => ((*exit*))
  | _ (*regular*) => let
      val () = fprintln! (out, str)
    in
      msgchan_dnload_fileref (chan, out)
    end (* end of [_] *)
end else ((*error*))
//
end // end of [msgchan_dnload_fileref]

(* ****** ****** *)

dynload "./msgchan.dats"
dynload "./redisContextSetup.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var out: FILEref = stdout_ref
//
val opt =
(
if argc >= 2
  then fileref_open_opt (argv[1], file_mode_w)
  else None_vt(*void*)
) : Option_vt (FILEref)
//
val () =
(
case+ opt of
| ~Some_vt (filr) => out := filr | ~None_vt () => ()
) : void // end of [val]
//
val ip = "127.0.0.1"
val ctx =
redisConnectWithTimeout (ip, 6379, TIMEOUT)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val () = the_redisContext_set (ctx)
//
val chan = msgchan_create (CHANAME)
//
val ((*void*)) =
  msgchan_dnload_fileref (chan, out)
//
val () = fileref_close (out)
val () = the_redisContext_unset ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_dn.dats] *)
