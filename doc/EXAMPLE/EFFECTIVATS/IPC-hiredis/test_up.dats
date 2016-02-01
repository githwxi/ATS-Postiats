(*
** uploading messages
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

staload "libc/SATS/time.sats"
staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)

#include "./params.hats"

(* ****** ****** *)

staload "./msgchan.sats"
staload "./redisContextSetup.dats"

(* ****** ****** *)

extern
fun randsleep (n: intGte(1)): void

implement
randsleep (n) =
  ignoret (sleep($UN.cast{uInt}(rand() mod n + 1)))
// end of [randsleep]

(* ****** ****** *)

extern
fun
msgchan_upload_fileref
  (chan: msgchan, inp: FILEref): void
implement
msgchan_upload_fileref
  (chan, inp) = let
//
var nerr: int = 0
val isnot = fileref_isnot_eof (inp)
//
in
//
if isnot then
{
  val () = randsleep (3)
  val line = fileref_get_line_string (inp)
  val () =
    msgchan_insert2
      (chan, $UN.strptr2string(line), nerr)
    // end of [msgchan_insert2]
//
  val () = strptr_free (line)
  val () = msgchan_upload_fileref (chan, inp)
} else {
  val ((*void*)) = msgchan_insert2 (chan, "\n", nerr)
} (* end of [if] *)
//
end // end of [msgchan_upload_fileref]

(* ****** ****** *)

dynload "./msgchan.dats"
dynload "./redisContextSetup.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var inp: FILEref = stdin_ref
//
val opt =
(
if argc >= 2
  then fileref_open_opt (argv[1], file_mode_r)
  else None_vt(*void*)
) : Option_vt (FILEref)
//
val () =
(
case+ opt of
| ~Some_vt (filr) => inp := filr | ~None_vt () => ()
) : void // end of [val]
//
val ip = "127.0.0.1"
val ctx =
redisConnectWithTimeout (ip, 6379, TIMEOUT)
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val chan = msgchan_create (CHANAME)
//
val ((*void*)) = the_redisContext_set (ctx)
//
val () = srand ($UN.cast{uint}(time_get()))
//
val ((*void*)) =
  msgchan_upload_fileref (chan, inp)
//
val () = fileref_close (inp)
val () = the_redisContext_unset ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_up.dats] *)
