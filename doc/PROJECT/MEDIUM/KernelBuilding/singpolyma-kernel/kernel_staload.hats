(* ****** ****** *)
//
// Templates for kernel programming 
//
(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/bool.dats"
staload _ = "prelude/DATS/char.dats"
staload _ = "prelude/DATS/string.dats"

(* ****** ****** *)

staload UNSAFE = "prelude/SATS/unsafe.sats"
staload _(*UNSAFE*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

(* end of [kernel_staload.hats] *)
