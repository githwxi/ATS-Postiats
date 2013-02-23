//
// Author: Hongwei Xi (February 2013)
//

(* ****** ****** *)

staload "prelude/DATS/basics.dats"
staload "prelude/DATS/integer.dats"
staload "prelude/DATS/bool.dats"
staload "prelude/DATS/char.dats"
staload "prelude/DATS/float.dats"

(* ****** ****** *)

staload "prelude/DATS/tuple.dats"

(* ****** ****** *)

implement
fprint_tup$beg<> (out) = fprint_string (out, "[")
implement
fprint_tup$end<> (out) = fprint_string (out, "]")
implement
fprint_tup$sep<> (out) = fprint_string (out, "; ")

(* ****** ****** *)

implement
main0 () = let
//
val out = stdout_ref
val () = fprint_tupval2<int,char> (out, @(0, 'a'))
val () = fprint_tupval2<int,tup(bool,char)> (out, @(0, (true, 'a')))
//
in
end // end of [main0]

(* ****** ****** *)

(* end of [fprtuple.dats] *)
