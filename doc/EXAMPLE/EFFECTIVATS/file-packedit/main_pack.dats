(*
** HX-2013-12-31:
** packing a list of files into one
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

staload "./packing.sats"

(* ****** ****** *)

dynload "./packing.sats"
dynload "./packing.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
$EVP.OpenSSL_add_all_digests ()
//
var i: intGte(0)
val () =
for (i := 1 ; i < argc ; i := i+1)
{
val nerr = pack_sing_filename (stdout_ref, argv[i])
}
//
val () = $EVP.EVP_cleanup ()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main_pack.dats] *)
