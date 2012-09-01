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
  val () = assertloc (~rt)
  val (pf | one) = json_object_get (rt, "one")
  val () = assertloc (~one)
  prval () = minus_addback (pf, one | rt) 
  val () = printf("test\n", @())
//
  val dump = json_dumps (rt, 0)
  val () = assertloc (strptr_isnot_null (dump))
  val () = printf ("The dump is:\n%s", @($UN.castvwtp1{string}(dump)))
  val () = print_newline ()
  val () = strptr_free (dump)
  val () = json_decref(rt)
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
