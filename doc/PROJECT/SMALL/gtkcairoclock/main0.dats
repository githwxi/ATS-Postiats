//
// HX: a GTK/cairo-clock implementation
//
(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

staload "{$LIBATSHWXI}/teaching/myGTK/SATS/gtkcairoclock.sats"
staload _ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairoclock.dats"

(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)

extern
fun mydraw_clock
  (cr: !cairo_ref1, width: int, height: int): void = "ext#"
// end of [mydraw_clock]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var argc: int = argc
var argv: charptrptr = $UN.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
local
implement
gtkcairoclock_timeout_interval<> () = 100U
implement
gtkcairoclock_mydraw<> (cr, width, height) = mydraw_clock (cr, width, height)
in(* in of [local] *)
val ((*void*)) = gtkcairoclock_main ((*void*))
end // end of [local]
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main.dats] *)
