(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
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
          classdec GtkToggleButton : GtkButton_cls
            classdec GtkCheckButton : GtkToggleButton
              classdec GtkRadioButton : GtkCheckButton
            // end of [GtkCheckButton]
          // end of [GtkToggleButton]
          classdec GtkOptionMenu : GtkButton_cls
        // end of [GtkButton]
        classdec GtkWindow_cls : GtkBin_cls
        // end of [GtkWindow]
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
    // end of [GTKContainer]
    classdec GtkCalendar_cls : GtkWidget_cls
    classdec GtkDrawingArea_cls : GtkWidget_cls
      classdec GtkCurve_cls : GtkDrawingArea_cls
    // end of [GtkDrawingArea]
  // end of [GTKWidget]
// end of [GtkObject]

(* ****** ****** *)

#include "./gtk/gtkenums.sats"
#include "./gtk/gtkversion.sats"

(* ****** ****** *)

#include "./gtk/mybasics.sats"

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

#include "./gtk/gtkbox.sats"

(* ****** ****** *)

#include "./gtk/gtkhbox.sats"

(* ****** ****** *)

#include "./gtk/gtktable.sats"

(* ****** ****** *)

#include "./gtk/gtkdrawingarea.sats"

(* ****** ****** *)

(* end of [gtk.sats] *)
