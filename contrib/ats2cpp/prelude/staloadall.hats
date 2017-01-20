(* ****** ****** *)
//
// Templates for C++
//
(* ****** ****** *)
//
staload _ =
"prelude/DATS/integer.dats"
staload _ =
"prelude/DATS/pointer.dats"
//
(* ****** ****** *)
//
staload _ =
"prelude/DATS/integer_long.dats"
staload _ =
"prelude/DATS/integer_size.dats"
staload _ =
"prelude/DATS/integer_short.dats"
staload _ =
"prelude/DATS/integer_fixed.dats"
//
(* ****** ****** *)

staload _ = "prelude/DATS/bool.dats"
staload _ = "prelude/DATS/char.dats"
staload _ = "prelude/DATS/float.dats"
staload _ = "prelude/DATS/string.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/array.dats"
staload _ = "prelude/DATS/arrayptr.dats"
staload _ = "prelude/DATS/arrayref.dats"

(* ****** ****** *)

staload UNSAFE = "prelude/SATS/unsafe.sats"
staload _(*UNSAFE*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

(* end of [staloadall.hats] *)
