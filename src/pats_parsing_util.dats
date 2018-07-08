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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_symbol.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_lexing.sats" // for tokenizing
staload "./pats_tokbuf.sats" // for token buffering

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

implement
tokbuf_set_ntok_null
  (buf, n0) = let
  val () = tokbuf_set_ntok (buf, n0) in synent_null ()
end // end of [tokbuf_set_ntok_null]

(* ****** ****** *)

implement
ptoken_fun
(
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
    $UN.cast{token}(null)
  end // end of [_]
//
end // end of [ptoken_fun]

(* ****** ****** *)

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
ptokentopt_fun
  (buf, f1, f2) = let
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
in
  if f1 (tok.token_node) then let
    val () = tokbuf_incby1 (buf)
    var err: int = 0
    val ent = f2 (buf, 0(*bt*), err)
  in
    if err = 0 then
      Some_vt (ent) else let
      val () = tokbuf_set_ntok (buf, n0) in None_vt ()
    end (* end of [if] *)
  end else None_vt ()
end // end of [ptokentopt_fun]

(* ****** ****** *)
//
// HX: looping if [f] is nullable!
//
implement
pstar_fun{a}
  (buf, bt, f) = let
//
  vtypedef res_vt = List_vt (a)
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
    | _ => let
        val () =
        res := list_vt_cons{a}{0}(x, ?)
        val+list_vt_cons (_, !p_res1) = res
        val ((*void*)) = loop (buf, !p_res1, err)
        prval ((*void*)) = fold@ (res)
      in
        // nothing
      end (* end of [_] *)
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
  vtypedef res_vt = List_vt (a)
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
            res := list_vt_cons{a}{0}(x, ?)
          // end of [val]
          val+list_vt_cons (_, !p_res1) = res
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
| _ when
    err > 0 => list_vt_nil () // HX: normal
| _ => let
    val xs = pstar_sep_fun (buf, 1(*bt*), sep, f)
  in
    list_vt_cons (x0, xs)
  end // end of [_]
//
end // end of [pstar_fun0_sep]

(* ****** ****** *)

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
pstar_fun1_sep
(
  buf, bt, err, f, sep
) = let
  val x0 = f (buf, bt, err)
in
//
case+ 0 of
| _ when
    synent_isnot_null(x0) => let
    val xs =
      pstar_sep_fun (buf, 1(*bt*), sep, f)
    // end of [val]
  in
    list_vt_cons (x0, xs)
  end
| _ => let
    val () = err := err + 1 in list_vt_nil((*error*))
  end (* end of [_] *)
//
end // end of [pstar_fun1_sep]

(* ****** ****** *)

implement
pstar_fun1_AND
  (buf, bt, err, f) =
  pstar_fun1_sep (buf, bt, err, f, p_AND_test)
// end of [pstar_fun1_AND]

(* ****** ****** *)

implement
pstar1_fun
(
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
popt_fun{a}
  (buf, bt, f) = let
  var err: int = 0
  val x = f (buf, 1(*bt*), err)
in
  if err = 0 then Some_vt (x) else None_vt ()
end // end of [popt_fun]

(* ****** ****** *)

implement
pseq2_fun{a1,a2}
(
  buf, bt, err, f1, f2
) = let
//
val
err0 = err
//
val n0 =
  tokbuf_get_ntok (buf)
//
val ent1 = f1(buf, bt, err)
//
val bt = 0
//
val ent2 =
(
  if err <= err0
    then f2(buf, bt, err) else synent_null()
  // end of [if]
) : a2 // end of [val]
//
val () =
  if (err > err0) then tokbuf_set_ntok(buf, n0)
// end of [val]
//
in
  SYNENT2 (ent1, ent2)
end // end of [pseq2_fun]

(* ****** ****** *)

implement
pseq3_fun{a1,a2,a3}
(
  buf, bt, err, f1, f2, f3
) = let
//
val
err0 = err
//
val n0 =
  tokbuf_get_ntok (buf)
//
val ent1 = f1(buf, bt, err)
//
val bt = 0
//
val ent2 =
(
  if err <= err0
    then f2 (buf, bt, err) else synent_null()
  // end of [if]
) : a2 // end of [val]
val ent3 =
(
  if err <= err0
    then f3 (buf, bt, err) else synent_null()
  // end of [if]
) : a3 // end of [val]
//
val ((*error*)) =
  if (err > err0) then tokbuf_set_ntok(buf, n0)
// end of [val]
//
in
  SYNENT3 (ent1, ent2, ent3)
end // end of [pseq3_fun]

(* ****** ****** *)

implement
ptest_fun{a}
  (buf, f, ent) = let
  var err: int = 0
  val () = ent := synent_encode (f (buf, 1(*bt*), err))
in
  err = 0
end // end of [ptest_fun]

(* ****** ****** *)

implement
list12_free
  (ent) = (
  case+ ent of
  | ~LIST12one xs => list_vt_free (xs)
  | ~LIST12two (xs1, xs2) => (list_vt_free (xs1); list_vt_free (xs2))
) (* end of [list12_free] *)

(* ****** ****** *)

implement
plist12_fun
  {a}(buf, bt, f) = let
//
val xs1 =
  pstar_fun0_COMMA{a}(buf, bt, f)
//
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
| T_BAR () => let
    val () = incby1 ()
    val xs2 = pstar_fun0_COMMA{a}(buf, bt, f)
  in
    LIST12two (xs1, xs2)
  end
| _ => LIST12one (xs1)
//
end // end of [plist12_fun]

(* ****** ****** *)

implement
p1list12_fun{a}
  (x, buf, bt, f) = let
//
val xs1 =
pstar_sep_fun{a}
  (buf, bt, p_COMMA_test, f)
//
val xs1 = list_vt_cons{a}(x, xs1)
//
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
| T_BAR () => let
    val () = incby1 ()
    val xs2 = pstar_fun0_COMMA{a}(buf, bt, f)
  in
    LIST12two (xs1, xs2)
  end
| _ (*non-BAR*) => LIST12one (xs1)
//
end // end of [p1list12_fun]

(* ****** ****** *)

implement
pif_fun (
  buf, bt, err, f, err0
) = (
//
if err <= err0
  then f (buf, bt, err) else synent_null ((*void*))
//
) (* end of [pif_fun] *)

(* ****** ****** *)

implement
ptokwrap_fun
(
  buf, bt, err, f, enode
) = x where {
  val err0 = err
  val () = err := 0
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val x = f (buf, bt, err, tok)
  val () =
  if err > 0
    then let
      val () = tokbuf_set_ntok (buf, n0)
    in
      the_parerrlst_add_ifnbt (bt, tok.token_loc, enode)
    end // end of [then]
  // end of [val]
  val () = err := err + err0
} (* end of [ptokwrap_fun] *)

(* ****** ****** *)

(* end of [pats_parsing_util.dats] *)
