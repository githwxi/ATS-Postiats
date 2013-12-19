(* ****** ****** *)
//
// Testing the openSSL API in ATS
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/evp.sats"

(* ****** ****** *)

staload _ = "./../DATS/openssl.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val out = stdout_ref
//
val mess = "Hello World!"
//
val () = OpenSSL_add_all_digests ()
//
implement
fprint_array$sep<> (out) = ((*void*))
//
implement fprint_val<uchar> (out, c) =
{
  val _ = $extfcall (int, "printf", "%02x", c)
}
//
var asz: int
val inp = stdin_ref
//
val digest =
EVP_Digestize_fileref ("MD5", inp, asz)
val () =
fprintln! (out, "MD5(<STDIN>) = ")
val () =
fprint_arrayptr (out, digest, i2sz(asz))
val ((*void*)) = fprint_newline (out)
val ((*void*)) = arrayptr_free (digest)
//
val digest =
EVP_Digestize_fileref ("SHA256", inp, asz)
val () =
fprintln! (out, "SHA256(<STDIN>) = ")
val () =
fprint_arrayptr (out, digest, i2sz(asz))
val ((*void*)) = fprint_newline (out)
val ((*void*)) = arrayptr_free (digest)
//
val () = EVP_cleanup ()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)
