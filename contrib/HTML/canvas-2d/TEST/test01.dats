(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: October, 2013
*)
(* ****** ****** *)
//
// Hello, world!
// A simple example of ATS/HTML5-canvas-2d
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "./../SATS/canvas2d.sats"
//
(* ****** ****** *)

val W = 600.0
and H = 100.0
val WH = min (W, H)

(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val id = "Hello"
//
val ctx = canvas2d_make (id)
val p_ctx = ptrcast (ctx)
val () = assertloc (p_ctx > 0)
//
val (pf | ())= canvas2d_save (ctx)
//
(*
val () =
canvas2d_set_fillStyle_string (ctx, "gray")
val () = canvas2d_fillRect (ctx, 0.0, 0.0, W, H)
*)
//
val (
) = canvas2d_translate (ctx, W/2, H/2)
val () = canvas2d_scale (ctx, 1.25, 1.25)
//
val w = 200.0 and h = 50.0
//
val grad =
canvas2d_createLinearGradient (ctx, ~w/2, ~h/2, w/2, h/2)
val () = canvas2d_gradient_addColorStop (grad, 0.0, "rgb(0,0,64)")
val () = canvas2d_gradient_addColorStop (grad, 1.0, "rgb(100,100,255)")
val () = canvas2d_set_fillStyle_gradient (ctx, grad)
val () = canvas2d_gradient_free (grad)
val () = canvas2d_fillRect (ctx, ~w/2, ~h/2, w, h)
val () =
canvas2d_set_strokeStyle_string (ctx, "black")
val () = canvas2d_strokeRect (ctx, ~w/2, ~h/2, w, h)
//
val () = canvas2d_set_font_string (ctx, "20pt Ariel")
val () = canvas2d_set_fillStyle_string (ctx, "yellow")
val () = canvas2d_fillText (ctx, "Hello, world!", ~178.0/2, 8.0)
//
val ((*void*))= canvas2d_restore (pf | ctx)
//
val () = canvas2d_free (ctx)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
