(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

staload "contrib/atshwxi/testing/SATS/fprint.sats"

(* ****** ****** *)
//
// HX-2012-05:
// Compiling this is a challenge right now!
//
implement{a}
fprint_listlist_sep
  (out, xss, sep1, sep2) = let
//
implement
fprint_val<List(a)>
  (out, xs) = fprint_list_sep<a> (out, xs, sep1)
// end of [fprint_val]
//
in
//
fprint_list_sep<List(a)> (out, xss, sep2)
//
end // end of [fprint_listlist_sep]

(* ****** ****** *)

local

staload IT = "prelude/SATS/iterator.sats"

in // in of [local]

implement
{knd}{x}
fprint_iterator_sep
  {kpm}{f,r}
  (out, itr, sep) = let
//
val () = $IT.lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = $IT.iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  out: FILEref
, itr: !iter (f, r) >> iter (f+r, 0)
, sep: string
, notbeg: bool
) : void = let
  val test = $IT.iter_isnot_atend (itr)
in
  if test then let
    val (fpf | x) = $IT.iter_vttake_inc (itr)
    val () = if notbeg then fprint_string (out, sep)
    val () = fprint_val<x> (out, x)
    prval () = fpf (x)
  in
    loop (out, itr, sep, true)
  end else ()
end // end of [loop]
//
in
  loop (out, itr, sep, false(*notbeg*))
end // end of [fprint_iterator_sep]

end // end of [local]

(* ****** ****** *)

(* end of [fprint.dats] *)
