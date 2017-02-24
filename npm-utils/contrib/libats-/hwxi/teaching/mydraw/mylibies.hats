(*
** For teaching some basic
** drawing involving cairo and canvas-2d
*)

(* ****** ****** *)
//
// HX-2017-02-13
//
(* ****** ****** *)
//
#staload
MYDRAW = "./SATS/mydraw.sats"
//
(* ****** ****** *)
//
#ifdef
MYDRAW_CAIRO
#staload
MYDRAW_cairo = "./SATS/mydraw_cairo.sats"
#endif // #ifdef(MYDRAW_CAIRO)
//
(* ****** ****** *)
//
#ifdef
MYDRAW_CANVAS2D
#staload
MYDRAW_canvas2d = "./SATS/mydraw_HTML5_canvas2d.sats"
#endif // #ifdef(MYDRAW_CAIRO)
//
(* ****** ****** *)

(* end of [mylibies.hats] *)
