(*
** API in ATS for GTK
*)

(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: April, 2010
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: September, 2013
//
(* ****** ****** *)

%{#
#include "GTK/CATS/gtk.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.GTK"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)
//
#include "share/atspre_define.hats"
//
staload GLIB = "{$GLIB}/SATS/glib.sats"
staload GLIBOBJ = "{$GLIB}/SATS/glib-object.sats"
//
(* ****** ****** *)

typedef gint = $GLIB.gint
typedef guint = $GLIB.guint

(* ****** ****** *)

typedef gboolean = $GLIB.gboolean

(* ****** ****** *)

typedef gchar = $GLIB.gchar
typedef guchar = $GLIB.guchar

(* ****** ****** *)

typedef gstring = $GLIB.gstring
typedef gstropt = $GLIB.gstropt
vtypedef gstrptr(l:addr) = $GLIB.gstrptr (l)
vtypedef gstrptr0 = $GLIB.gstrptr0
vtypedef gstrptr1 = $GLIB.gstrptr1

(* ****** ****** *)

typedef gdouble = $GLIB.gdouble

(* ****** ****** *)

stadef GObject: cls = $GLIBOBJ.GObject
stadef GInitiallyUnowned: cls = $GLIBOBJ.GInitiallyUnowned
stadef GInterface: cls = $GLIBOBJ.GInterface

(* ****** ****** *)

stadef gobjref = $GLIBOBJ.gobjref
stadef gobjref0 = $GLIBOBJ.gobjref0
stadef gobjref1 = $GLIBOBJ.gobjref1

(* ****** ****** *)

staload "./gdk.sats"

(* ****** ****** *)

classdec GtkObject : GInitiallyUnowned
  classdec GtkWidget_cls : GtkObject
    classdec GtkContainer_cls : GtkWidget_cls
      classdec GtkBin_cls : GtkContainer_cls
        classdec GtkButton_cls : GtkBin_cls
          classdec GtkToggleButton_cls : GtkButton_cls
            classdec GtkCheckButton_cls : GtkToggleButton_cls
              classdec GtkRadioButton_cls : GtkCheckButton_cls
            // end of [GtkCheckButton]
          // end of [GtkToggleButton]
          classdec GtkOptionMenu_cls : GtkButton_cls
        // end of [GtkButton]
        classdec GtkWindow_cls : GtkBin_cls
          classdec GtkDialog_cls : GtkWindow_cls
            classdec GtkInputDialog_cls : GtkDialog_cls
            classdec GtkMessageDialog_cls : GtkDialog_cls
          // end of [GtkDialog]
        // end of [GtkWindow]
        classdec GtkViewport_cls : GtkBin_cls
        classdec GtkScrolledWindow_cls : GtkBin_cls
      // end of [GTKBin]
      classdec GtkBox_cls : GtkContainer_cls
        classdec GtkBottonBox_cls : GtkBox_cls
          classdec GtkBottonHBox_cls : GtkBottonBox_cls
          classdec GtkBottonVBox_cls : GtkBottonBox_cls
        // end of [GtkBottonBox]
        classdec GtkVBox_cls : GtkBox_cls
          classdec GtkFontSelection_cls : GtkVBox_cls
          classdec GtkColorSelection_cls : GtkVBox_cls
          classdec GtkGammarCurve_cls : GtkVBox_cls
        // end of [GtkVBox]
        classdec GtkHBox_cls : GtkBox_cls
          classdec GtkCombo_cls : GtkHBox_cls
          classdec GtkStatusbar_cls : GtkHBox_cls
        // end of [GtkHBox]
      // end of [GtkBox]
      classdec GtkTable_cls : GtkContainer_cls
      classdec GtkTextView_cls : GtkContainer_cls
    // end of [GTKContainer]
    classdec GtkSeparator_cls : GtkWidget_cls
      classdec GtkHSeparator_cls : GtkSeparator_cls
      classdec GtkVSeparator_cls : GtkSeparator_cls
    // end of [GtkSeparator]
    classdec GtkCalendar_cls : GtkWidget_cls
    classdec GtkDrawingArea_cls : GtkWidget_cls
      classdec GtkCurve_cls : GtkDrawingArea_cls
    // end of [GtkDrawingArea]
  // end of [GtkWidget]
// end of [GtkObject]

(* ****** ****** *)
//
classdec GtkTextBuffer_cls : GObject
classdec GtkTextTag_cls : GObject
classdec GtkTextTagTable_cls : GObject
classdec GtkTextMark_cls : GObject
//
typedef
GtkTextIter = // HX: it is completely opaque
$extype_struct"GtkTextIter" of { GtkTextIter_rest=undefined_t0ype }
//
(* ****** ****** *)

#include "./gtk/gtkenums.sats"
#include "./gtk/gtkversion.sats"

(* ****** ****** *)

#include "./gtk/mybasis.sats"

(* ****** ****** *)

#include "./gtk/gtkmain.sats"

(* ****** ****** *)

#include "./gtk/gtkwidget.sats"

(* ****** ****** *)

#include "./gtk/gtkcontainer.sats"

(* ****** ****** *)

#include "./gtk/gtkbutton.sats"

(* ****** ****** *)

#include "./gtk/gtkwindow.sats"

(* ****** ****** *)

#include "./gtk/gtkdialog.sats"
#include "./gtk/gtkmessagedialog.sats"

(* ****** ****** *)

#include "./gtk/gtkviewport.sats"
#include "./gtk/gtkscrolledwindow.sats"

(* ****** ****** *)

#include "./gtk/gtkbox.sats"
#include "./gtk/gtkhbox.sats"
#include "./gtk/gtkvbox.sats"

(* ****** ****** *)

#include "./gtk/gtktable.sats"

(* ****** ****** *)

#include "./gtk/gtkseparator.sats"
#include "./gtk/gtkhseparator.sats"
#include "./gtk/gtkvseparator.sats"

(* ****** ****** *)

#include "./gtk/gtkdrawingarea.sats"

(* ****** ****** *)

#include "./gtk/gtktextview.sats"

(* ****** ****** *)

#include "./gtk/gtktextbuffer.sats"
#include "./gtk/gtktexttag.sats"
#include "./gtk/gtktexttagtable.sats"
#include "./gtk/gtktextmark.sats"

(* ****** ****** *)

#include "./gtk/gtktextiter.sats"

(* ****** ****** *)

(* end of [gtk.sats] *)
