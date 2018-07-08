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
get_URL<>() = "http://www.ats-lang.org"

(* ****** ****** *)

implement
main0
  (argc, argv) = () where
{
//
val URL =
(
if argc >= 2
  then argv[1] else get_URL()
) : string // end of [val]
//
val opt =
(
if
(argc >= 3)
then
fileref_open_opt(argv[2], file_mode_w)
else None_vt((*void*))
) : Option_vt(FILEref)
val out =
(
case+ opt of
| ~Some_vt(out) => out
| ~None_vt((*void*)) => stdout_ref
) : FILEref
//
val err =
  curl_global_init(CURL_GLOBAL_SSL)
val ((*void*)) = assertloc(err = CURLE_OK)
//
val curl =
  curl_easy_init((*void*))
val p_curl = ptrcast(curl)
val ((*void*)) = assertloc(p_curl > 0)
//
val err =
$extfcall
( CURLerror
, "curl_easy_setopt", p_curl, CURLOPT_URL, URL
) (* end of [val] *)
val ((*void*)) = assertloc(err = CURLE_OK)
//
val err =
$extfcall
( CURLerror
, "curl_easy_setopt", p_curl, CURLOPT_FILE, out
) (* end of [val] *)
val ((*void*)) = assertloc(err = CURLE_OK)
//
val err =
$extfcall
( CURLerror
, "curl_easy_setopt", p_curl, CURLOPT_SSL_VERIFYPEER, 1L)
val err = CURLerror2code(err)
val errmsg = curl_easy_strerror(err)
val ((*void*)) =
(
  if (err != CURLE_OK)
    then println! ("errmsg = ", errmsg)
  // end of [if]
)
(*
//
This results in an error:
curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST , 1L)
//
HX: Note that 1L needs to be changed to 2L!!!
//
*)
val err =
$extfcall
( CURLerror
, "curl_easy_setopt", p_curl, CURLOPT_SSL_VERIFYHOST, 2L)
val err = CURLerror2code(err)
val errmsg = curl_easy_strerror(err)
val ((*void*)) =
(
  if (err != CURLE_OK)
    then println! ("errmsg = ", errmsg)
  // end of [if]
)
val ((*void*)) = assertloc(err = CURLE_OK)
//
val err =
  curl_easy_perform(curl)
//
val err = CURLerror2code(err)
//
val errmsg = curl_easy_strerror(err)
val ((*void*)) =
(
  if (err != CURLE_OK)
    then println! ("errmsg = ", errmsg)
  // end of [if]
)
//
val ((*void*)) = assertloc (err = CURLE_OK)
//
val () = curl_easy_cleanup (curl)
//
val () = curl_global_cleanup ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
