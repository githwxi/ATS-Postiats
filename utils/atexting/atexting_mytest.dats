(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)

(*
local

fun
loop_tokenizing
(
  buf: &lexbuf >> _
) : void = let
//
val
out = stdout_ref
//
val
tok =
lexbuf_get_token_any(buf)
//
in
//
case+
tok.token_node
of // case+
| TOKeof() => ()
| _(*rest*) => let
//
(*
    val () =
    fprintln! (out, tok.token_loc)
*)
//
    val () = fprintln!(out, "tok = ", tok)
//
  in
    loop_tokenizing(buf)
  end (* end of [rest] *)
//
end // end of [loop]

in (* in-of-local *)

implement
test_tokenizing_fileref
  (inp) = let
//
var buf: lexbuf
val ((*void*)) =
  lexbuf_initize_fileref(buf, inp)
//
val ((*void*)) =
  the_filename_push(filename_stdin)
//
val ((*void*)) = loop_tokenizing(buf)
//
val _(*stdin*) = the_filename_pop()

//
val ((*void*)) = lexbuf_uninitize(buf)
//
in
  // nothing
end // end of [test_tokenizing_fileref]

end // end of [local]
*)

(* ****** ****** *)

local

fun
loop_tokenizing
(
  buf: &tokbuf >> _
) : void = let
//
val
out = stdout_ref
//
val
tok =
tokbuf_getinc_token(buf)
//
in
//
case+
tok.token_node
of // case+
| TOKeof() => ()
| _(*rest*) => let
//
(*
    val () =
    fprintln! (out, tok.token_loc)
*)
//
    val () = fprintln!(out, "tok = ", tok)
//
  in
    loop_tokenizing(buf)
  end (* end of [rest] *)
//
end // end of [loop]

in (* in-of-local *)

implement
test_tokenizing_fileref
  (inp) = let
//
var buf: tokbuf
val ((*void*)) =
  tokbuf_initize_fileref(buf, inp)
//
val ((*void*)) =
  the_filename_push(filename_stdin)
//
val ((*void*)) = loop_tokenizing(buf)
//
val _(*stdin*) = the_filename_pop()

//
val ((*void*)) = tokbuf_uninitize(buf)
//
in
  // nothing
end // end of [test_tokenizing_fileref]

end // end of [local]

(* ****** ****** *)

(* end of [atexting_mytest.dats] *)
