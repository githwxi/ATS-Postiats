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
