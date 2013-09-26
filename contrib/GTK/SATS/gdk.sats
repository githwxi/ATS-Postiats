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
#include "GTK/CATS/gdk.cats"
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

stadef gint = $GLIB.gint
stadef guint = $GLIB.guint

(* ****** ****** *)

stadef gint8 = $GLIB.gint8
stadef gint16 = $GLIB.gint16
stadef gint32 = $GLIB.gint32

(* ****** ****** *)

stadef guint8 = $GLIB.guint8
stadef guint16 = $GLIB.guint16
stadef guint32 = $GLIB.guint32

(* ****** ****** *)

stadef GObject: cls = $GLIBOBJ.GObject
stadef GInitiallyUnowned: cls = $GLIBOBJ.GInitiallyUnowned
stadef GInterface: cls = $GLIBOBJ.GInterface

(* ****** ****** *)

stadef gobjref = $GLIBOBJ.gobjref
stadef gobjref0 = $GLIBOBJ.gobjref0
stadef gobjref1 = $GLIBOBJ.gobjref1

(* ****** ****** *)

classdec GdkObject : GObject
  classdec GdkDrawable_cls : GdkObject
    classdec GdkBitmap_cls : GdkDrawable_cls
    classdec GdkPixmap_cls : GdkDrawable_cls
    classdec GdkWindow_cls : GdkDrawable_cls
  // end of [GdkDrawable]
// end of [GdkObject]

classdec GdkPixbuf : GObject
classdec GdkColormap : GObject

(* ****** ****** *)
//
stadef GdkDrawable: cls = GdkDrawable_cls
//
stadef GdkBitmap: cls = GdkBitmap_cls
stadef GdkPixmap: cls = GdkPixmap_cls
stadef GdkWindow: cls = GdkWindow_cls
//
(* ****** ****** *)

#include "./gdk/gdkcairo.sats"

(* ****** ****** *)

#include "./gdk/gdkevents.sats"

(* ****** ****** *)

(* end of [gdk.sats] *)
