(*
** Copyright (C) 2010 Chris Double.
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

(*
** Some modification by Hongwei Xi (September 2012)
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "jansson/SATS/jansson.sats"

(* ****** ****** *)

implement
main () = let
//
  var err: json_err? 
//
  val rt = json_loads ("{\"one\":1}", 0, err)
  val () = assertloc (JSONptr_isnot_null (rt))
  val (fpf | one) = json_object_get_exnloc (rt, "one")
  val ji = json_integer_value (one)
  val () = printf ("int = %i\n", @($UN.cast2int(ji)))
  prval () = minus_addback (fpf, one | rt) 
//
  val _(*err*) =
    json_dumpf (rt, stdout_ref, 0)
  // end of [val]
  val () = fprint_newline (stdout_ref)
//
  val () = json_decref(rt)
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
