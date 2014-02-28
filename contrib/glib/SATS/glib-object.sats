(*
** API in ATS for glib
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
// Start Time: February, 2010
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: September, 2013
//
(* ****** ****** *)

%{#
#include "glib/CATS/glib-object.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.glibobj"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

staload GLIB = "./glib.sats"

(* ****** ****** *)

stadef gint = $GLIB.gint
stadef guint = $GLIB.guint
stadef gboolean = $GLIB.gboolean
stadef gpointer = $GLIB.gpointer

(* ****** ****** *)

absvtype
gobjref_vtype (c:cls, l:addr) = ptr
vtypedef
gobjref (c:cls, l:addr) = gobjref_vtype (c, l)
vtypedef
gobjref0 (c:cls) = [l:agez] gobjref (c, l)
vtypedef
gobjref1 (c:cls) = [l:addr | l > null] gobjref (c, l)

(* ****** ****** *)
//
castfn
gobjref2ptr
  {c:cls}{l:addr} (obj: !gobjref (c, l)):<> ptr (l)
//
overload ptrcast with gobjref2ptr
//
(* ****** ****** *)
//
fun
g_object_is_null
  {c:cls}{l:addr}
  (obj: !gobjref (c, l)):<> bool (l==null) = "mac#atspre_ptr_is_null"
fun
g_object_isnot_null
  {c:cls}{l:addr}
  (obj: !gobjref (c, l)):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
//
(* ****** ****** *)

praxi
g_object_free_null{c:cls} (gobjref (c, null)):<prf> void

(* ****** ****** *)
//
// HX-2010-04-13: this is unsafe but ...
//
castfn
g_object_vref
  {c:cls}{l:addr} (x: !gobjref (c, l)):<> vttakeout0 (gobjref (c, l))
// end of [g_object_vref]
//
(* ****** ****** *)
//
classdec GObject_cls // super: none
  classdec GInitiallyUnowned_cls : GObject_cls // HX: no floating reference
classdec GInterface_cls // super: none
//
(* ****** ****** *)
//
stadef GObject = GObject_cls
stadef GInitiallyUnowned = GInitiallyUnowned_cls
stadef GInterface = GInterface_cls
//
vtypedef
GObject (l:addr) = [c:cls | c <= GObject] gobjref (c, l)
vtypedef GObject0 = [c:cls;l:agez | c <= GObject] gobjref (c, l) 
vtypedef GObject1 = [c:cls;l:addr | c <= GObject; l > null] gobjref (c, l) 
//
(* ****** ****** *)

abstype
GCallback = ptr // = (...) -<fun1> void

(* ****** ****** *)

castfn G_CALLBACK {a:type} (x: a): GCallback // HX: unfortunately ...

(* ****** ****** *)

#include "./gobject/gobject.sats"
#include "./gobject/gsignal.sats"

(* ****** ****** *)

(* end of [glib-object.sats] *)
