//
// Some code for testing the API in ATS for libcurl 
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./../SATS/curl.sats"

(* ****** ****** *)

extern fun{} get_URL (): string

(* ****** ****** *)

implement
get_URL<> () = "http://www.ats-lang.org"

(* ****** ****** *)

implement
main0
  (argc, argv) = () where
{
//
val URL =
(
  if argc >= 2 then argv[1] else get_URL ()
) : string
//
val curl = curl_easy_init ()
val p_curl = ptrcast(curl)
val ((*void*)) = assertloc (p_curl > 0)
//
val err = $extfcall (CURLerror, "curl_easy_setopt", p_curl, CURLOPT_URL, URL)
val ((*void*)) = assertloc (err = CURLE_OK)
//
val err = curl_easy_perform (curl)
val ((*void*)) = assertloc (err = CURLE_OK)
//
val () = curl_easy_cleanup (curl)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
