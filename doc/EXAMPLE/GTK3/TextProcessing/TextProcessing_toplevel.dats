(*
**
** A simple GTK example
** involving textview and textbuffer
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: April 18, 2014
**
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME "TextProcessing"
//
(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

staload
TOPWIN = {
//
typedef T = ptr
//
fun
initize (x: &T? >> T): void = x := the_null_ptr
//
#include "share/atspre_define.hats"
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [TOPWIN] *)

(* ****** ****** *)

staload
KEYPRESSED = {
//
#include "share/atspre_define.hats"
#include "{$LIBATSHWXI}/globals/HATS/gcount.hats"
//
} (* end of [KEYPRESSED] *)

(* ****** ****** *)

staload
TEXTBUF = {
//
typedef T = ptr
//
fun
initize (x: &T? >> T): void = x := the_null_ptr
//
#include "share/atspre_define.hats"
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [TEXTBUF] *)

(* ****** ****** *)

staload
TEXTBUF2 = {
//
typedef T = ptr
//
fun
initize (x: &T? >> T): void = x := the_null_ptr
//
#include "share/atspre_define.hats"
#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"
//
} (* end of [TEXTBUF2] *)

(* ****** ****** *)

(* end of [TextProcessing_toplevel.dats] *)
