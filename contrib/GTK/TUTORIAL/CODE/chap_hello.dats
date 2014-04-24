(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: September, 2013
**
*)

(* ****** ****** *)
//
// HX-2014-04-23: ported from GTK/TEST/test01.dats
//
(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"{$GLIB}/SATS/glib-object.sats"
//
staload "{$GTK}/SATS/gtk.sats"
//
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

(* end of [chap_hello.dats] *)
