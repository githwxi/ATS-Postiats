(* ****** ****** *)
//
// HX-2013-11-29:
// bugs in handling initialization
// of flat record of boxed-singleton
//
(* ****** ****** *)
//
// Status: fixed by HX-2013-11-29
//
(* ****** ****** *)

typedef x_ptr = @{ x= ptr }

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
in (* in of [local] *)

fun foo (): ptr = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<x_ptr> ()
//
prval() = showlvaltype (pfat)
//
val ((*void*)) = p->x := the_null_ptr
//
in
  $UN.castvwtp0{ptr}((pfat, pfgc | p))
end // end of [foo]

end // end of [local]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2013-11-29.dats] *)
