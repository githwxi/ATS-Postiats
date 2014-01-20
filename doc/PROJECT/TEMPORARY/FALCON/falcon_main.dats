(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/cstream/SATS/cstream.sats"
staload
"{$LIBATSHWXI}/cstream/SATS/cstream_tokener.sats"
//
(* ****** ****** *)
  
staload "./falcon.sats"
  
(* ****** ****** *)

staload "./falcon_tokener.dats"

(* ****** ****** *)

dynload "./falcon.sats"
dynload "./falcon_tokener.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val (
) = println! ("Hello from [FALCON]!")
//
val cs0 =
cstream_make_fileref (stdin_ref)
//
val buf = tokener_make_cstream (cs0)
//
val tok = my_tokener_get_token (buf)
val () = fprintln! (stdout_ref, "tok = ", tok)
val tok = my_tokener_get_token (buf)
val () = fprintln! (stdout_ref, "tok = ", tok)
val tok = my_tokener_get_token (buf)
val () = fprintln! (stdout_ref, "tok = ", tok)
//
val ((*freed*)) = tokener_free (buf)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [falcon_main.dats] *)
