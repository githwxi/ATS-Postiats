(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_symbol.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_lexing.sats" // for tokenizing
staload "pats_tokbuf.sats" // for token buffering

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

implement
is_AND (x) = case+ x of
  | T_AND () => true | _ => false
// end of [is_AND]
implement
p_AND_test (buf) = ptoken_test_fun (buf, is_AND)

implement
is_OF (x) = case+ x of
  | T_OF () => true | _ => false
// end of [is_OF]

(* ****** ****** *)

implement
is_BAR (x) = case+ x of
  | T_BAR () => true | _ => false
// end of [is_BAR]
implement
p_BAR_test (buf) = ptoken_test_fun (buf, is_BAR)

implement
is_COLON (x) = case+ x of
  | T_COLON () => true | _ => false
// end of [is_COLON]
implement
p_COLON_test (buf) = ptoken_test_fun (buf, is_COLON)

implement
is_COMMA (x) = case+ x of
  | T_COMMA () => true | _ => false
// end of [is_COMMA]
implement
p_COMMA_test (buf) = ptoken_test_fun (buf, is_COMMA)

implement
is_SEMICOLON (x) = case+ x of
  | T_SEMICOLON () => true | _ => false
// end of [is_SEMICOLON]
implement
p_SEMICOLON_test
  (buf) = ptoken_test_fun (buf, is_SEMICOLON)
// end of [p_SEMICOLON_test]

implement
is_BARSEMI (x) = case+ x of
  | T_BAR () => true | T_SEMICOLON () => true | _ => false
// end of [is_BARSEMI]
implement
p_BARSEMI_test (buf) = ptoken_test_fun (buf, is_BARSEMI)

(* ****** ****** *)

implement
is_LPAREN (x) = case+ x of
  | T_LPAREN () => true | _ => false
// end of [is_LPAREN]

implement
is_RPAREN (x) = case+ x of
  | T_RPAREN () => true | _ => false
// end of [is_RPAREN]

implement
is_LBRACKET (x) = case+ x of
  | T_LBRACKET () => true | _ => false
// end of [is_LBRACKET]

implement
is_RBRACKET (x) = case+ x of
  | T_RBRACKET () => true | _ => false
// end of [is_RBRACKET]

implement
is_LBRACE (x) = case+ x of
  | T_LBRACE () => true | _ => false
// end of [is_LBRACE]

implement
is_RBRACE (x) = case+ x of
  | T_RBRACE () => true | _ => false
// end of [is_RBRACE]

(* ****** ****** *)

implement
is_EQ (x) = case+ x of
  | T_EQ () => true | _ => false
// end of [is_EQ]

implement
is_EQGT (x) = case+ x of
  | T_EQGT () => true | _ => false
// end of [is_EQGT]

implement
is_EOF (x) = case+ x of
  | T_EOF () => true | _ => false
// end of [is_EOF]

(* ****** ****** *)

implement
ptoken_fun (
  buf, bt, err, f, enode
) = let
  val tok = tokbuf_get_token (buf)
in
  if f (tok.token_node) then let
    val () = tokbuf_incby1 (buf) in tok
  end else let
    val loc = tok.token_loc
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, enode)
  in
    $UN.cast{token} (null)
  end // end of [_]
//
end // end of [ptoken_fun]

implement
ptoken_test_fun
  (buf, f) = let
  val tok = tokbuf_get_token (buf)
in
  if f (tok.token_node) then let
    val () = tokbuf_incby1 (buf) in true
  end else false
end // end of [ptoken_test_fun]

(* ****** ****** *)
//
// HX: looping if [f] is nullable!
//
implement
pstar_fun{a}
  (buf, bt, f) = let
//
  viewtypedef res_vt = List_vt (a)
//
  fun loop (
    buf: &tokbuf
  , res: &res_vt? >> res_vt
  , err: &int
  ) :<cloref1> void = let
    val x = f (buf, 1(*bt*), err)
  in
    case+ 0 of
    | _ when err > 0 => let
        val () = res := list_vt_nil
      in
        // nothing
      end
    | _ => () where {
        val () =
          res := list_vt_cons {a} {0} (x, ?)
        // end of [val]
        val+ list_vt_cons (_, !p_res1) = res
        val () = loop (buf, !p_res1, err)
        prval () = fold@ (res)
      } // end of [_]
  end // end of [loop]
  var res: res_vt
  var err: int = 0
  val () = loop (buf, res, err)
in
  res (* properly ordered *)
end // end of [pstar_fun]

(* ****** ****** *)
//
// HX: looping if [f] is nullable!
//
implement
pstar_sep_fun{a}
  (buf, bt, sep, f) = let
//
  viewtypedef res_vt = List_vt (a)
//
  fun loop (
    buf: &tokbuf
  , res: &res_vt? >> res_vt
  , err: &int
  ) :<cloref1> void = let
    val n0 = tokbuf_get_ntok (buf)
  in
    if sep (buf) then let
      val x = f (buf, 0(*bt*), err)
    in
      case+ 0 of
      | _ when err > 0 => let
          val () = tokbuf_set_ntok (buf, n0)
          val () = res := list_vt_nil ()
        in
          // nothing
        end
      | _ => let
          val () =
            res := list_vt_cons {a} {0} (x, ?)
          // end of [val]
          val+ list_vt_cons (_, !p_res1) = res
          val () = loop (buf, !p_res1, err)
          prval () = fold@ (res)
        in    
          // nothing
        end
     end else (
       res := list_vt_nil ()
     ) // end of [val]
  end // end of [loop]
  var res: res_vt
  var err: int = 0
  val () = loop (buf, res, err)
in
  res (* properly ordered *)
end // end of [pstar_sep_fun]

implement
pstar_COMMA_fun
  (buf, bt, f) =
  pstar_sep_fun (buf, bt, p_COMMA_test, f)
// end of [pstar_COMMA_fun]

(* ****** ****** *)

implement
pstar_fun0_sep
  (buf, bt, f, sep) = let
  var err: int = 0
  val x0 = f (buf, 1(*bt*), err)
in
//
case+ 0 of
| _ when err > 0 => list_vt_nil ()
| _ => let
    val xs = pstar_sep_fun (buf, 1(*bt*), sep, f)
  in
    list_vt_cons (x0, xs)
  end // end of [_]
//
end // end of [pstar_fun0_sep]

(* ****** ****** *)

implement
pstar_fun0_AND
  (buf, bt, f) =
  pstar_fun0_sep (buf, bt, f, p_AND_test)
// end of [pstar_fun0_AND]

implement
pstar_fun0_BAR
  (buf, bt, f) =
  pstar_fun0_sep (buf, bt, f, p_BAR_test)
// end of [pstar_fun0_BAR]

implement
pstar_fun0_COMMA
  (buf, bt, f) =
  pstar_fun0_sep (buf, bt, f, p_COMMA_test)
// end of [pstar_fun0_COMMA]

implement
pstar_fun0_SEMICOLON
  (buf, bt, f) =
  pstar_fun0_sep (buf, bt, f, p_SEMICOLON_test)
// end of [pstar_fun0_SEMICOLON]

implement
pstar_fun0_BARSEMI
  (buf, bt, f) =
  pstar_fun0_sep (buf, bt, f, p_BARSEMI_test)
// end of [pstar_fun0_BARSEMI]

(* ****** ****** *)

implement
pstar_fun1_sep (
  buf, bt, err, f, sep
) = let
  val x0 = f (buf, bt, err)
in
//
case+ 0 of
| _ when
    synent_isnot_null (x0) => let
    val xs = pstar_sep_fun (buf, 1(*bt*), sep, f)
  in
    list_vt_cons (x0, xs)
  end
| _ => let
    val () = err := err + 1 in list_vt_nil ()
  end (* end of [_] *)
//
end // end of [pstar_fun1_sep]

(* ****** ****** *)

implement
pplus_fun (
  buf, bt, err, f
) = let
  val x0 = f (buf, bt, err)
in
//
case+ 0 of
| _ when
    synent_isnot_null (x0) => let
    val xs = pstar_fun (buf, 1(*bt*), f)
  in
    list_vt_cons (x0, xs)
  end
| _ => let
    val () = err := err + 1 in list_vt_nil ()
  end (* end of [_] *)
//
end // end of [pplus_fun]

(* ****** ****** *)

implement
popt_fun {a}
  (buf, bt, f) = let
  var err: int = 0
  val x = f (buf, 1(*bt*), err)
in
  if err = 0 then Some_vt (x) else None_vt ()
end // end of [popt_fun]

(* ****** ****** *)

implement
ptest_fun {a}
  (buf, f, ent) = let
  var err: int = 0
  val () = ent := synent_encode (f (buf, 1(*bt*), err))
in
  err = 0
end // end of [ptest_fun]

(* ****** ****** *)

implement
list12_free (ent) =
  case+ ent of
  | ~LIST12one xs => list_vt_free (xs)
  | ~LIST12two (xs1, xs2) => (list_vt_free (xs1); list_vt_free (xs2))
// end of [list12_free]

implement
plist12_fun {a}
  (buf, bt, f) = let
  val xs1 = pstar_fun0_COMMA {a} (buf, bt, f)
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_BAR () => let
    val () = incby1 ()
    val xs2 = pstar_fun0_COMMA {a} (buf, bt, f)
  in
    LIST12two (xs1, xs2)
  end
| _ => LIST12one (xs1)
//
end // end of [plist12_fun]

(* ****** ****** *)

implement
ptokwrap_fun (
  buf, bt, err, f, enode
) = x where {
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val err0 = err
  val () = err := 0
  val x = f (buf, bt, err, tok)
  val () = if
    err > 0 then let
    val () = tokbuf_set_ntok (buf, n0)
  in
    the_parerrlst_add_ifnbt (bt, tok.token_loc, enode)
  end // end of [val]
  val () = err := err + err0
} // end of [ptokwrap_fun]

(* ****** ****** *)

(* end of [pats_parsing_util.dats] *)
