(*
//
// event2/http.h
//
*)

(* ****** ****** *)
//
fun
evhttp_new{lb:agz}
  (base: !event_base lb): [lh:agez] evhttp (lh, lb) = "mac#%"
//
(* ****** ****** *)

/*
void evhttp_free(struct evhttp* http);
*/
fun evhttp_free{lh,lb:addr}(http: evhttp (lh, lb)): void = "mac#%"

(* ****** ****** *)

fun evhttp_bind_socket
  (http: !evhttp1, address: Stropt, port: uint16): interr = "mac#%"

(* ****** ****** *)

/*
struct
evhttp_request
*evhttp_request_new
(void (*cb)(struct evhttp_request *, void *), void *arg);
*/
(*
fun
evhttp_request_new0{a:vt0p}{l:addr}
  (cb: evhttp_callback0 (a, l), arg: cptr(a, l)): evhttp0_request = "mac#%"
*)
fun
evhttp_request_new1
  {a:vt0p}{l:addr}
  (cb: evhttp_callback1 (a, l), arg: cptr(a, l)): evhttp0_request = "mac#%"
fun
evhttp_request_new1_ref{a:vt0p}
  (cb: evhttp_callback1_ref (a), arg: &(a) >> _): evhttp0_request = "mac#%"
//
(* ****** ****** *)

fun evhttp_request_free (req: evhttp0_request): void = "mac#%"

(* ****** ****** *)

fun
evhttp_request_get_input_buffer
  {l:agz} (req: !evhttp_request(l))
: [l2:agz] vtget1(evhttp_request(l), evbuffer(l2)) = "mac#%"

(* ****** ****** *)
  
fun
evhttp_request_get_response_code
  (req: !evhttp1_request): int(*code*) = "mac#%"

(* ****** ****** *)
//
fun
evhttp_request_get_host
  (req: !evhttp1_request): vStrptr1(*host*) = "mac#%"
//
(* ****** ****** *)
//
fun
evhttp_request_get_input_headers
  {l:agz} (req: !evhttp_request(l))
: [l2:agz]
  vtget1(evhttp_request(l), evkeyvalq(l2)) = "mac#%"
// end of [evhttp_request_get_input_headers]
//
fun
evhttp_request_get_output_headers
  {l:agz} (req: !evhttp_request(l))
: [l2:agz]
  vtget1(evhttp_request(l), evkeyvalq(l2)) = "mac#%"
// end of [evhttp_request_get_output_headers]
//
(* ****** ****** *)
//
fun evhttp_add_header
(
  headers: !evkeyvalq1, key: NSH(string), value: NSH(string)
) : interr = "mac#%" // end-of-fun
fun evhttp_find_header
  (headers: !evkeyvalq1, key: NSH(string)): vStrptr0 = "mac#%"
fun evhttp_remove_header
  (headers: !evkeyvalq1, key: NSH(string)): interr = "mac#%"
// 
fun evhttp_clear_headers (headers: !evkeyvalq1): void = "mac#%"
//
(* ****** ****** *)

fun
evhttp_connection_base_new
(
  evb: !event1_base, dnsbase: ptr, address: string, port: uint16
) : evhttp0_connection = "mac#%" // end-of-fun

fun
evhttp_connection_free (evhttp0_connection): void = "mac#%"

(* ****** ****** *)
//
// HX-2014-05: [req] is owned by [cnn] after this call!
//  
fun evhttp_make_request
(
  cnn: !evhttp1_connection
, req: evhttp1_request, type: evhttp_cmd_type, uri: string
) : interr = "mac#%" // end-of-fun

fun evhttp_cancel_request (req: evhttp1_request): void = "mac#%"
  
(* ****** ****** *)

fun evhttp_uri_get_port (uri: !evhttp1_uri): int = "mac#%"
fun evhttp_uri_get_host (uri: !evhttp1_uri): vStrptr0 = "mac#%"
fun evhttp_uri_get_path (uri: !evhttp1_uri): vStrptr0 = "mac#%"
fun evhttp_uri_get_query (uri: !evhttp1_uri): vStrptr0 = "mac#%"

(* ****** ****** *)
//
fun evhttp_uri_free (uri: evhttp0_uri): void = "mac#%"
fun evhttp_uri_parse (uri: string): evhttp0_uri = "mac#%"
//
(* ****** ****** *)

(* end of [http.sats] *)
