(*
** source: gdkcairo.h
*)

(* ****** ****** *)
//
staload
XR = "{$CAIRO}/SATS/cairo.sats"
//
vtypedef cairo_ref1 = $XR.cairo_ref1
//
(* ****** ****** *)

fun
gdk_cairo_create
  {c:cls |
   c <= GdkDrawable}
  {l:agz} (
  drawable: !gobjref (c, l)
) : cairo_ref1 = "mac#%"

(* ****** ****** *)

(* end of [gdkcairo.sats] *)
