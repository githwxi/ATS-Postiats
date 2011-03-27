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
is_BAR (x) = case+ x of
  | T_BAR () => true | _ => false
// end of [is_BAR]

implement
is_COMMA (x) = case+ x of
  | T_COMMA () => true | _ => false
// end of [is_COMMA]

implement
is_SEMICOLON (x) = case+ x of
  | T_SEMICOLON () => true | _ => false
// end of [is_SEMICOLON]

implement
is_RPAREN (x) = case+ x of
  | T_RPAREN () => true | _ => false
// end of [is_RPAREN]

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
    | _ when
        synent_is_null (x) => let
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
      val x = f (buf, 1(*bt*), err)
    in
      case+ 0 of
      | _ when
          synent_is_null (x) => let
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

(* ****** ****** *)

implement
pstar_fun0_sep
  (buf, bt, f, sep) = let
  var err: int = 0
  val x0 = f (buf, 1(*bt*), err)
in
//
case+ 0 of
| _ when
    synent_is_null (x0) => list_vt_nil ()
| _ => let
    val xs = pstar_sep_fun (buf, bt, sep, f)
  in
    list_vt_cons (x0, xs)
  end // end of [_]
//
end // end of [pstar_fun0_sep]

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

(* ****** ****** *)

implement
pplus_fun {a}
  (buf, bt, f) = let
  var err: int = 0
  val x = f (buf, bt, err)
in
  if synent_isnot_null (x) then let
    val xs = pstar_fun (buf, bt, f) in list_vt_cons (x, xs)
  end else list_vt_nil ()
end // end of [pplus_fun]

(* ****** ****** *)

implement
popt_fun {a}
  (buf, bt, f) = let
  var err: int = 0
  val res = f (buf, 1(*bt*), err)
in
  if synent_isnot_null (res)
    then Some_vt (res) else None_vt ()
  // end of [if]
end // end of [popt_fun]

(* ****** ****** *)

implement
ptest_fun {a}
  (buf, f, ent) = let
  var err: int = 0
  val () = ent := synent_encode (f (buf, 1(*bt*), err))
in
  synent_isnot_null (ent)
end // end of [ptest_fun]

(* ****** ****** *)

(* end of [pats_parsing_util.dats] *)
