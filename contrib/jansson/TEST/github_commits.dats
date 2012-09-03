//
// For testing the ATS API for jansson
// Only the ATS code here is written by Hongwei Xi
//

%{^

/*
 * Copyright (c) 2009-2012 Petri Lehtinen <petri@digip.org>
 *
 * Jansson is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See LICENSE for details.
 */

#include <stdlib.h>
#include <string.h>

#include <jansson.h>
#include <curl/curl.h>

#define BUFFER_SIZE  (256 * 1024)  /* 256 KB */

/* Return the offset of the first newline in text or the length of
   text if there's no newline */

struct write_result
{
    char *data; int pos;
};

static
size_t
write_response (
  void *ptr, size_t size, size_t nmemb, void *stream
) {
  struct write_result *result = (struct write_result *)stream;

  if(result->pos + size * nmemb >= BUFFER_SIZE - 1)
  {
      fprintf(stderr, "error: too small buffer\n");
      return 0;
  }

  memcpy(result->data + result->pos, ptr, size * nmemb);
  result->pos += size * nmemb;

  return size * nmemb;
}

static
char *request(const char *url)
{
    CURL *curl;
    CURLcode status;
    char *data;
    long code;

    curl = curl_easy_init();
    data = malloc(BUFFER_SIZE);
    if(!curl || !data)
        return NULL;

    struct write_result write_result = {
        .data = data,
        .pos = 0
    };

    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_response);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &write_result);

    status = curl_easy_perform(curl);
    if(status != 0)
    {
        fprintf(stderr, "error: unable to request data from %s:\n", url);
        fprintf(stderr, "%s\n", curl_easy_strerror(status));
        return NULL;
    }

    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &code);
    if(code != 200)
    {
        fprintf(stderr, "error: server responded with code %ld\n", code);
        return NULL;
    }

    curl_easy_cleanup(curl);
    curl_global_cleanup();

    /* zero-terminate the result */
    data[write_result.pos] = '\0';

    return data;
}

%} // end of [%{^]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload "jansson/SATS/jansson.sats"

(* ****** ****** *)

extern
fun request (url: string): strptr0 = "mac#request"

(* ****** ****** *)

extern
fun process_root
  {l:addr}
  (root: !JSONptr l, err: &json_err): void
// end of [process_root]

extern
fun process_root_array {l:agz} (root: !JSONptr l): void

implement
process_root
  {l} (root, err) = let
  prval () = addr_is_gtez {l} ()
  val isnz =
    JSONptr_isnot_null (root)
  val () = if ~isnz then let
    val () =
      fprintf (stderr_ref,
      "error: on line %d: %s\n", @(err.line, $UN.cast{string}(err.text))
    ) // end of [val]
  in
    exit (1)
  end
  val () = assert (isnz)
  val isa =
    json_is_array (root)
  val () = if ~isa then let
    val () = fprintf (stderr_ref, "error: root is not an array\n", @())
  in
    exit (1)
  end
in
  process_root_array {l} (root)
end // end of [process_root]

macdef
JPNZ (x) =
  assertloc (JSONptr_isnot_null ,(x))
// end of [JPNZ]

implement
process_root_array
  {l} (root) = let
//
val n = json_array_size (root)
//
fun loop (
  root: !JSONptr l, n: size_t, i: size_t
) : void = let
in
//
if i < n then let
//
  val data =
    json_array_get1_exnloc (root, i)
  // end of [val]
  val () = assertloc (json_is_object (data))
//
  val sha =
    json_object_get1_exnloc (data, "sha")
  // end of [val]
  val () = assertloc (json_is_string (sha))
//
  val commit =
    json_object_get1_exnloc (data, "commit")
  // end of [val]
  val () = assertloc (json_is_object (commit))
//
  val message =
    json_object_get1_exnloc (commit, "message")
  // end of [val]
  val () = assertloc (json_is_string (message))
//
  val (fpf1 | sha_value) = json_string_value (sha)
  val (fpf2 | message_value) = json_string_value (message)
//
  val () = fprintf (stdout_ref, "%s\n", @($UN.linstr2str(sha_value)))
  val () = fprint_newline (stdout_ref)
  val () = fprintf (stdout_ref, "%s\n", @($UN.linstr2str(message_value)))
  val () = fprint_newline (stdout_ref)
//
  prval () = minus_addback (fpf1, sha_value | sha)
  prval () = minus_addback (fpf2, message_value | message)
  val () = json_decref (commit)
  val () = json_decref (sha)
  val () = json_decref (message)
  val () = json_decref (data)
//
in
  loop (root, n, i+1)
end else () // end of [if]
//
end // end of [loop]
//
in
  loop (root, n, 0)
end // end of [process_root_array]

(* ****** ****** *)

#define URL_FORMAT "https://api.github.com/repos/%s/%s/commits"

implement
main (argc, argv) = let
//
  val cmd = argv.[0]
  var arg1: string = "githwxi"
  var arg2: string = "ATS-Postiats"
//
(*
  val () = if (argc < 3) then let
    val () = fprintf(stderr_ref, "usage: %s USER REPOSITORY\n\n", @(cmd))
    val () = fprintf(stderr_ref, "List commits at USER's REPOSITORY.\n\n", @())
  in
    exit (2)
  end // end of [val]
*)
//
  val () = if argc >= 2 then arg1 := argv.[1]
  val () = if argc >= 3 then arg2 := argv.[2]
//
  val url =
    sprintf (URL_FORMAT, @(arg1, arg2))
  val text = request($UN.castvwtp1{string}(url))
  val () = strptr_free (url)
//
  val isnz = strptr_isnot_null (text)
//
in
//
if isnz then let
  var err: json_err
  val root = json_loads ($UN.linstr2str(text), 0, err)
  val () = strptr_free (text)
  val () = process_root (root, err)
  val () = json_decref(root)
in
  exit (0)
end else let
  prval () = strptr_free_null (text) in (*nothing*)
end // end of [if]
//
end // end of [main]

(* ****** ****** *)

(* end of [github_commits.dats] *)
