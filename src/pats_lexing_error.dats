(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_lexing.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location
overload fprint with $LOC.fprint_location

(* ****** ****** *)

implement
lexerr_make
  (loc, node) = '{
  lexerr_loc= loc, lexerr_node= node
} // end of [lexerr_make]

(* ****** ****** *)

viewtypedef lexerrlst_vt = List_vt (lexerr)

(* ****** ****** *)
//
// HX-2011-03-12:
// [n] stores the total number of errors, some of
// which may not be recorded
//
extern
fun the_lexerrlst_get (n: &int? >> int): lexerrlst_vt

(* ****** ****** *)

local
//
// HX-2011-03-12:
// MAXLEN is the max number of errors to be reported
//
#define MAXLEN 100
#assert (MAXLEN > 0)
val the_length = ref<int> (0)
val the_lexerrlst = ref<lexerrlst_vt> (list_vt_nil)

in // in of [local]

implement
the_lexerrlst_clear
  () = () where {
  val () = !the_length := 0
  val () = () where {
    val (vbox pf | p) = ref_get_view_ptr (the_lexerrlst)
    val () = list_vt_free (!p)
    val () = !p := list_vt_nil ()
  } // end of [val]
} // end of [the_lexerrlst_clear]

implement
the_lexerrlst_add
  (err) = () where {
  val n = let
    val (vbox pf | p) = ref_get_view_ptr (the_length)
    val n = !p
    val () = !p := n + 1
  in n end // end of [val]
  val () = if n < MAXLEN then let
    val (vbox pf | p) = ref_get_view_ptr (the_lexerrlst)
  in
    !p := list_vt_cons (err, !p)
  end // end of [val]
} // end of [the_lexerrlst_add]

implement
the_lexerrlst_get
  (n) = xs where {
  val () = n := !the_length
  val () = !the_length := 0
  val (vbox pf | p) = ref_get_view_ptr (the_lexerrlst)
  val xs = !p
  val xs = list_vt_reverse (xs)
  val () = !p := list_vt_nil ()
} // end of [the_lexerrlst_get]

end // end of [local]

(* ****** ****** *)

implement
fprint_lexerr
  (out, x) = let
  val loc = x.lexerr_loc
  val () = fprint (out, loc)
in
//
case+ x.lexerr_node of
| LE_CHAR_oct () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the char format (oct) is incorrect.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_CHAR_hex () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the char format (hex) is incorrect.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_CHAR_unclose () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the char consant is unclosed.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_STRING_char_oct () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the string-char format (oct) is incorrect.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_STRING_char_hex () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the string-char format (hex) is incorrect.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_STRING_unclose () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the string constant is unclosed.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_COMMENT_block_unclose
  (
  ) => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the comment block is unclosed.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_EXTCODE_unclose () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the external code block is unclosed.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_DIGIT_oct_89 (c) => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": illegal digit (oct): %c", @(c))
    val ((*void*)) = fprint_newline (out)
  }
| LE_FEXPONENT_empty () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the floating exponent is empty.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_QUOTE_dangling () => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": the quote symbol (') is dangling.", @())
    val ((*void*)) = fprint_newline (out)
  }
| LE_UNSUPPORTED_char (c) => () where {
    val () = fprintf (out, ": error(lexing)", @())
    val () = fprintf (out, ": unsupported char: %c", @(c))
    val ((*void*)) = fprint_newline (out)
  }
(*
| _ => () where {
    val () = fprintf (out, ": error(lexing): unspecified", @())
    val () = fprint_newline (out)
  }
*)
//
end // end of [fprint_lexerr]

(* ****** ****** *)

implement
fprint_the_lexerrlst
  (out) = let
  var n: int?
  val xs = the_lexerrlst_get (n)
//
  fun loop (
    out: FILEref, xs: lexerrlst_vt, n: int
  ) : int =
    case+ xs of
    | ~list_vt_cons (x, xs) => let
        val () = fprint_lexerr (out, x) in loop (out, xs, n-1)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => n
  (* end of [loop] *)
//
in
//
case+ xs of
| list_vt_cons _ => let
    prval () = fold@ (xs)
    val n = loop (out, xs, n)
    val () = if n > 0 then {
      val () = fprint_string
        (out, "There are possibly some additional errors.")
      val () = fprint_newline (out)
    } // end of [if]
  in
    1 (* containing errors *)
  end // end of [list_vt_cons]
| ~list_vt_nil () => 0 (* free of errors *)
//
end // end of [fprint_the_lexerrlst]

(* ****** ****** *)

(* end of [pats_lexing_error.dats] *)
