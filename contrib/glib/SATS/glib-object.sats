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
