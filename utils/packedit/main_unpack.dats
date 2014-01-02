(*
** HX-2013-12-31:
** unpacking one into a list of files
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
EVP = "{$OPENSSL}/SATS/evp.sats"

(* ****** ****** *)

staload "./unpacking.sats"

(* ****** ****** *)

dynload "./unpacking.sats"
dynload "./unpacking.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
$EVP.OpenSSL_add_all_digests ()
//
val nerr = unpack_many_fileref (stdin_ref)
//
val ((*void*)) = $EVP.EVP_cleanup ()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main_unpack.dats] *)
