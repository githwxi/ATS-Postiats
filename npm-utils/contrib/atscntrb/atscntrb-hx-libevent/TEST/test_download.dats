(* ****** ****** *)
(*
** Copyright (C) 2011 Chris Double.
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)
(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Time: May, 2014
**
** Ported the original code by Chris Double to ATS2
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../SATS/event.sats"

(* ****** ****** *)

fun
get_request_result
(
  req: !evhttp1_request
) : Strptr1 = src2 where
{
//
val (fpf_buf | buf) =
  evhttp_request_get_input_buffer (req)
(*
val len = evbuffer_get_length (buf)
*)
val ssz = g0i2i(~1)
val (fpf_src | src) = evbuffer_pullup (buf, ssz)
val () = assertloc (isneqz(src))
val src2 = string0_copy ($UN.strptr2string(src))
prval () = fpf_src (src)
prval () = minus_addback (fpf_buf, buf | req)
//
} (* end of [get_request_result] *)
//
(* ****** ****** *)

vtypedef
myenv (l:addr) = @{
  bas= event_base(l)
, cnn= Option_vt (evhttp1_connection), cbk= string -> void
} (* end of [myenv] *)

viewtypedef myenv1 = [l:addr | l > null] myenv(l)

(* ****** ****** *)

extern
fun download_renew_request (url: string, env: &myenv1 >> _): void

(* ****** ****** *)

fun
document_moved
(
  req: !evhttp1_request, env: &myenv1 >> _
) : void = () where
{
  val (fpf_headers | headers) =
    evhttp_request_get_input_headers(req)
  val (fpf_location | location) =
    evhttp_find_header(headers, "Location")
  val () = assertloc (isneqz(location))
  val () = println! ("Moved to ", $UN.strptr2string(location))
  val () = download_renew_request ($UN.strptr2string(location), env)
  prval () = fpf_location (location)
  prval () = minus_addback (fpf_headers, headers | req)
} (* end of [document_moved] *)

(* ****** ****** *)

fun document_okay
(
  req: !evhttp1_request, env: &myenv1
) : void = let
  val result = get_request_result (req)
  val ((*void*)) = env.cbk($UN.strptr2string(result))
  val ((*void*)) = strptr_free(result)
in
  ignoret(event_base_loopexit(env.bas, $UN.cast{cPtr0(timeval)}(0)))
end // end of [document_okay]

(* ****** ****** *)

fun document_error
(
  req: !evhttp1_request, env: &myenv1
) :void = let
  val () = println! ("error!")
in
  ignoret(event_base_loopexit(env.bas, $UN.cast{cPtr0(timeval)}(0)))
end // end of [document_error]

(* ****** ****** *)

fun
download_callback
(
  req: !evhttp1_request, env: &myenv1 >> _
) : void = let
  val code = evhttp_request_get_response_code (req)
in
//
case+ 0 of
| _ when code = HTTP_OK => document_okay (req, env)
| _ when code = HTTP_MOVEPERM => document_moved (req, env)
| _ when code = HTTP_MOVETEMP => document_moved (req, env)
| _ (*all-the-rest*) => document_error (req, env)
//
end // end of [download_callback]

(* ****** ****** *)

fun
download_url
(
  url: string
) : void = () where
{
  var env: myenv(null)?
  val evb = event_base_new()
  val () = assertlocmsg(isneqz(evb), "[event_base_new] failed")
  val () = env.bas := evb
  val () = env.cnn := None_vt(*void*)
  val () = env.cbk := (lam (msg: string): void => println! (msg))
//
  val () = download_renew_request (url, env)
//
  val err = // -1/0/1
    event_base_dispatch (env.bas)
  val () = (
    case+ env.cnn of
    | ~Some_vt(cnn) => evhttp_connection_free (cnn) | ~None_vt () => ()
  ) : void // end of [val]
  val () = event_base_free (env.bas)
  prval ((*void*)) = topize (env.cbk)
} (* end of [download_url] *)

(* ****** ****** *)

implement
download_renew_request
  (url, env) = () where
{
//
val uri = evhttp_uri_parse (url)
val () = assertlocmsg (isneqz(uri), "[evhttp_uri_parse] failed")
//
val (fpf_host | host) = evhttp_uri_get_host (uri)
val () = assertlocmsg (isneqz(host), "[evhttp_uri_parse] failed")
//
val port = evhttp_uri_get_port (uri)
val port = (if (port >= 0) then g0i2u(port) else 80u): uint
//
val cnn =
evhttp_connection_base_new
  (env.bas, the_null_ptr, $UN.strptr2string(host), $UN.cast{uint16}(port))
val ((*void*)) =
assertlocmsg (isneqz(cnn), "[evhttp_connection_base_new] failed")
//
val req = evhttp_request_new1_ref {myenv1} (download_callback, env)
val ((*void*)) = assertlocmsg (isneqz(req), "evhttp_request_new failed")
//
val (fpf_headers | headers) = evhttp_request_get_output_headers(req)
val err = evhttp_add_header (headers, "Host", $UN.strptr2string(host))
prval () = minus_addback (fpf_headers, headers | req)
//
prval () = fpf_host (host)
//
val err =
  evhttp_make_request(cnn, req, EVHTTP_REQ_GET, "/")
val () = (
  case+ env.cnn of
  | ~Some_vt (c) => evhttp_connection_free(c) | ~None_vt () => ()
) : void // end of [val]
val () = env.cnn := Some_vt(cnn)
//
val ((*freed*)) = evhttp_uri_free(uri)
//
} (* end of [download_renew_request] *)

(* ****** ****** *)

implement
main0 (argc, argv) =
(
  if argc < 2
    then
      println! ("usage: ", argv[0], " http://example.com/")
    else download_url (argv[1])
  // end of [if]
) (* end of [main0] *)

(* ****** ****** *)

(* end of [test_download.dats] *)
