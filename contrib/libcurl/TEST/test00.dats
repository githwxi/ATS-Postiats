//
// Some code for testing the API in ATS for libcurl 
//

(* ****** ****** *)

staload "./../SATS/curl.sats"

(* ****** ****** *)

val () =
{
//
val () = println! ("The cURL version is ", curl_version ())
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
