(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$GTK}/SATS/gdk.sats"
staload "{$GTK}/SATS/gtk.sats"
staload "{$GLIB}/SATS/glib.sats"
staload "{$GLIB}/SATS/glib-object.sats"

(* ****** ****** *)

extern
fun ControlPanel_make (): gobjref1(GtkVBox)

(* ****** ****** *)

implement
ControlPanel_make
(
  // argumentless
) = let
//
val vbox0 =
gtk_vbox_new
(
  GFALSE(*homo*), (gint)10(*spacing*)
) (* end of [val] *)
val () = assertloc (ptrcast (vbox0) > 0)
//
val button_start =
gtk_button_new_with_label ((gstring)"Start")
val () = assertloc (ptrcast (button_start) > 0)
val () =
gtk_box_pack_end
(
  vbox0, button_start, GFALSE(*expand*), GFALSE(*fill*), (guint)4
) (* end of [val] *)
val () = g_object_unref (button_start)
//
val button_finish =
gtk_button_new_with_label ((gstring)"Finish")
val () = assertloc (ptrcast (button_finish) > 0)
val () =
gtk_box_pack_end
(
  vbox0, button_finish, GFALSE(*expand*), GFALSE(*fill*), (guint)4
) (* end of [val] *)
val () = g_object_unref (button_finish)
//
in
  vbox0
end // end of [ControlPanel_make]

(* ****** ****** *)

(* end of [ControlPanel.dats] *)
