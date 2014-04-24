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
typedef char **charpp ;
%} ;
abstype charpp = $extype"charpp"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var argc: int = argc
var argv: charpp = $UN.castvwtp1{charpp}(argv)
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
val ((*void*)) = gtk_widget_destroy0 (win) // a type-error if omitted
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [chap_start.dats] *)
