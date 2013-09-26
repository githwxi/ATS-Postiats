(*
**
** Start with GTK3
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: September, 2013
**
*)

(* ****** ****** *)

#include "share/atspre_define.hats"

(* ****** ****** *)

staload "./../SATS/gtk.sats"
staload "{$GLIB}/SATS/glib-object.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

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
val win =
  gtk_window_new (GTK_WINDOW_TOPLEVEL)
//
val () = assertloc (ptrcast(win) > 0)
//
val ((*void*)) = gtk_widget_show (win)
//
val ((*void*)) = gtk_main ()
//
val ((*void*)) = gtk_widget_destroy0 (win) // can never be reached!!!
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
