(*
** API for json-c in ATS
*)

(* ****** ****** *)

(*
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
**
** Author Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Time: May, 2013
**
*)

(* ****** ****** *)
//
// HX-2013-05:
// mostly for some convenience functions
//
(* ****** ****** *)

staload "json-c/SATS/json.sats"

(* ****** ****** *)

implement{}
not_json_bool (tf) =
  if tf != 0 then json_false else json_true
// end of [not_json_bool]

(* ****** ****** *)
//
implement{}
print_json_object
  (jso) = fprint_json_object (stdout_ref, jso)
implement{}
print_json_object_ext
  (jso, flags) = fprint_json_object_ext (stdout_ref, jso, flags)
//
implement{}
prerr_json_object
  (jso) = fprint_json_object (stderr_ref, jso)
implement{}
prerr_json_object_ext
  (jso, flags) = fprint_json_object_ext (stderr_ref, jso, flags)
//
(* ****** ****** *)

implement{}
fprint_json_object
  (out, jso) = let
  val (fpf | str) = json_object_to_json_string (jso)
  val () = fprint_strptr (out, str)
  prval () = fpf (str)
in
  // nothing
end // end of [fprint_json_object]

implement{}
fprint_json_object_ext
  (out, jso, flags) = let
  val (fpf | str) = json_object_to_json_string_ext (jso, flags)
  val () = fprint_strptr (out, str)
  prval () = fpf (str)
in
  // nothing
end // end of [fprint_json_object_ext]

(* ****** ****** *)

(* end of [json.dats] *)
