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

staload "pats_lexing.sats" // for tokens
staload "pats_tokbuf.sats" // for tokenizing

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

implement
sep_COMMA (buf) = let
  val tok = tokbuf_get_token (buf)
in
  case+ tok.token_node of
  | T_COMMA () => let
      val () = tokbuf_incby1 (buf) in true
    end
  | _ => false
end // end of [sep_COMMA]

implement
sep_SEMICOLON (buf) = let
  val tok = tokbuf_get_token (buf)
in
  case+ tok.token_node of
  | T_SEMICOLON () => let
      val () = tokbuf_incby1 (buf) in true
    end
  | _ => false
end // end of [sep_SEMICOLON]

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
  ) :<cloref1> void =
    if sep (buf) then let
      val x = f (buf, 1(*bt*), err)
    in
      case+ 0 of
      | _ when
          synent_is_null (x) => let
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
  // end of [loop]
  var res: res_vt
  var err: int = 0
  val () = loop (buf, res, err)
in
  res (* properly ordered *)
end // end of [pstar_sep_fun]

(* ****** ****** *)

implement
pstar_fun0_COMMA
  (buf, bt, f) = let
  var err: int = 0
  val x0 = f (buf, bt, err)
in
//
case+ 0 of
| _ when
    synent_is_null (x0) => list_vt_nil ()
| _ => let
    val xs = pstar_sep_fun (buf, bt, sep_COMMA, f)
  in
    list_vt_cons (x0, xs)
  end // end of [_]
//
end // end of [pstar_fun0_COMMA]

(* ****** ****** *)

(* end of [pats_parsing_util.dats] *)
