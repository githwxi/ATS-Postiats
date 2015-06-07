(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: June, 2015 *)

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.funmap_rbtree"
//
#define
ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "libats/SATS/funmap_rbtree.sats"

(* ****** ****** *)

implement
{key}
compare_key_key
  (k1, k2) = gcompare_val_val<key> (k1, k2)
// end of [compare_key_key]

(* ****** ****** *)
//
#define BLK 0; #define RED 1
//
sortdef two = {c:nat | c < 2}
sortdef clr = {c:nat | c < 2}
//
typedef color(c:int) = int(c)
typedef color = [c:clr] color(c)
//
(* ****** ****** *)
//
// HX-2012-12-26:
// the file should be included here
// before [map_type] is assumed
//
#include "./SHARE/funmap.hats" // code reuse
//
(* ****** ****** *)
//
datatype rbtree
(
  key:t@ype, itm: t@ype
, int(*color*), int(*bheight*), int(*violation*)
) =
  | E (key, itm, BLK, 0, 0)
  | {c,cl,cr:clr}{bh:nat}{v:int}
    {c == BLK && v == 0 ||
     c == RED && v == cl+cr}
    T (key, itm, c, bh+1-c, v) of
    (
      color c, key, itm
    , rbtree0 (key, itm, cl, bh), rbtree0 (key, itm, cr, bh)
    ) (* end of [T] *)
// end of [datatype rbtree]
//
where
rbtree0
(
  key:t@ype, itm:t@ype, c:int, bh:int
) =
  rbtree (key, itm, c, bh, 0(*violation*))
// end of [rbtree0]
//
(* ****** ****** *)
//
assume
map_type
(
  key:t0p, itm:t0p
) = [c:clr;bh:nat] rbtree0 (key, itm, c, bh)
// end of [map_type]
//
(* ****** ****** *)

implement{} funmap_nil () = E ()
implement{} funmap_make_nil () = E ()

(* ****** ****** *)

implement
{}(*tmp*)
funmap_is_nil (map) =
  case+ map of E _ => true | T _ => false
// end of [funmap_is_nil]

implement
{}(*tmp*)
funmap_isnot_nil (map) =
  case+ map of T _ => true | E _ => false
// end of [funmap_isnot_nil]

(* ****** ****** *)

implement
{key,itm}
funmap_size
  (map) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
aux
{c:clr}
{bh:nat}
(
  t0: rbtree0(c, bh), res: size_t
) : size_t = let
in
//
case+ t0 of
| E((*void*)) => res
| T(_, _, _, tl, tr) => let
    val res = succ(res)
    val res = aux (tl, res)
    val res = aux (tr, res)
  in
    res
  end // end of [T]
//
end // end of [aux]
//
in
  $effmask_all (aux (map, i2sz(0)))
end // end of [funmap_size]

(* ****** ****** *)

implement
{key,itm}
funmap_search
  (map, k0, res) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
search
{c:clr}
{bh:nat} .<bh,c>.
(
  t0: rbtree0(c, bh)
, res: &itm? >> opt (itm, b)
) :<!wrt> #[b:bool] bool(b) = let
in
//
case+ t0 of
| E (
  ) => let
    prval () = opt_none{itm}(res)
  in
    false
  end // end of [E]
| T (
    _(*h*), k, x, tl, tr
  ) => let
    val sgn =
      compare_key_key<key> (k0, k)
    // end of [val]
  in
    case+ 0 of
    | _ when sgn < 0 => search (tl, res)
    | _ when sgn > 0 => search (tr, res)
    | _ => let
        val () = res := x
        prval () = opt_some{itm}(res) in true
      end // end of [_]
  end // end of [T]
//
end // end of [search]
//
in
  search (map, res)
end // end of [funmap_search]

(* ****** ****** *)
//
// HX: right rotation
//
fn{
key,
itm:t0p
} insfix_l
  {cl,cr:clr}
  {bh:nat}{v:nat}
(
  k: key, x: itm
, tl: rbtree (key, itm, cl, bh, v)
, tr: rbtree (key, itm, cr, bh, 0)
) :<> [c:clr] rbtree0 (key, itm, c, bh+1) =
(
//
let
  #define B BLK; #define R RED
in
  case+ (tl) of
  | T (R, kl, xl, T (R, kll, xll, tlll, tllr), tlr) =>
      T (R, kl, xl, T (B, kll, xll, tlll, tllr), T (B, k, x, tlr, tr))
  | T (R, kl, xl, tll, T (R, klr, xlr, tlrl, tlrr)) =>
      T (R, klr, xlr, T (B, kl, xl, tll, tlrl), T (B, k, x, tlrr, tr))
  | _ (*non-R-rooted*) =>> T (B, k, x, tl, tr)
end
//
) (* end of [insfix_l] *)
//
(* ****** ****** *)
//
// HX: left rotation
//
fn{
key,
itm:t0p}
insfix_r
  {cl,cr:clr}
  {bh:nat}{v:nat}
(
  k: key, x: itm
, tl: rbtree (key, itm, cl, bh, 0)
, tr: rbtree (key, itm, cr, bh, v)
) :<> [c:clr] rbtree0 (key, itm, c, bh+1) =
(
//
let
  #define B BLK; #define R RED
in
  case+ (tr) of
  | T (R, kr, xr, trl, T (R, krr, xrr, trrl, trrr)) =>
      T (R, kr, xr, T (B, k, x, tl, trl), T (B, krr, xrr, trrl, trrr))
  | T (R, kr, xr, T (R, krl, xrl, trll, trlr), trr) =>
      T (R, krl, xrl, T (B, k, x, tl, trll), T (B, kr, xr, trlr, trr))
  | _ (*non-R-rooted*) =>> T (B, k, x, tl, tr)
end
//
) (* end of [insfix_r] *)
//
(* ****** ****** *)
  
  
implement
{key,itm}
funmap_insert
(
  map, k0, x0, res2
) = res where {
//
#define B BLK; #define R RED
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
insert
{c:clr}
{bh:nat} .<bh,c>.
(
  t0: rbtree0 (c, bh)
, res: &bool? >> bool (b)
, res2: &itm? >> opt (itm, b)
) :<!wrt> #[b:bool]
[
  c1:clr; v:nat | v <= c
] rbtree (key, itm, c1, bh, v) =
(
case+ t0 of
//
| E((*void*)) => let
    val () = res := false
    prval () = opt_none{itm}(res2)
  in
    T{..}{..}{..}{0} (R, k0, x0, E, E)
  end // end of [E]
//
| T (c, k, x, tl, tr) => let
    val sgn = compare_key_key<key> (k0, k)
  in
    if sgn < 0 
      then let
        val [cl:int,v:int] tl = insert (tl, res, res2) in
        if c = B
          then insfix_l(k, x, tl, tr) else T{..}{..}{..}{cl}(R, k, x, tl, tr)
        // end of [if]
      end // end of [then]
      else (
        if sgn > 0
          then let
            val [cr:int,v:int] tr = insert (tr, res, res2) in
            if c = B
              then insfix_r(k, x, tl, tr) else T{..}{..}{..}{cr}(R, k, x, tl, tr)
            // end of [if]
          end // end of [then]
          else let
            val () = res := true
            val () = res2 := x;
            prval () = opt_some{itm}(res2)
          in
            T{..}{..}{..}{0}(c, k, x0, tl, tr)
          end // end of [else]
        // end of [if]
      ) (* end of [else] *)
    // end of [if]
  end // end of [let] // end of [T]
//
) (* end of [insert] *)
//
var res: bool
val map1 = insert (map, res, res2)
val () =
(
case+ map1 of
| T (R, k, x, tl, tr) => map := T (B, k, x, tl, tr) | _ =>> map := map1
) (* end of [val] *)
//
} (* end of [funmap_insert] *)
  
(* ****** ****** *)

fn
{key
,itm:t0p
} rbtree_redden
  {bh:pos}
(
  t0: rbtree0 (key, itm, BLK, bh)
) :<>
[
  v:nat | v <= 2
] rbtree (key, itm, RED, bh-1, v) = let
  val+T{..}{c,cl,cr}(_, k, x, tl, tr) = t0 in T{..}{..}{..}{cl+cr} (RED, k, x, tl, tr)
end // end of [let] // end of [rbtree_redden]

(* ****** ****** *)

fn
{key
,itm:t0p
} remfix_l
  {cl,cr:clr}
  {bh:nat}{v:nat}
(
  k: key, x: itm
, tl: rbtree (key, itm, cl, bh  , v)
, tr: rbtree (key, itm, cr, bh+1, 0)
) :<>
[
  c:clr;v:nat | v <= cr
] rbtree (key, itm, c, bh+1, v) = let
  #define B BLK; #define R RED
in
//
case+ tl of
| T(R, kl, xl, tll, tlr) =>
  T{..}{..}{..}{cr}(R, k, x, T (B, kl, xl, tll, tlr), tr)
| _ (*non-red-tree*) =>>
  (
    case+ tr of
    | T{..}{cr,crl,crr}
      (
        B, kr, xr, trl, trr
      ) =>
      insfix_r
      (
        k, x, tl, T{..}{..}{..}{crl+crr}(R, kr, xr, trl, trr)
      ) (* end of [T (B, ...)] *)
    | T(R, kr, xr, trl, trr) => let
        val+T(B, krl, xrl, trll, trlr) = trl
        val [cr2:int] tr2 = insfix_r (kr, xr, trlr, rbtree_redden trr)
      in
        T{..}{..}{..}{cr2}(R, krl, xrl, T (B, k, x, tl, trll), tr2)
      end (* end of [T (R, ...)] *)
  ) (* end of [_(*non-red-tree*)] *)
//
end // end of [remfix_l]

(* ****** ****** *)

fn
{key
,itm:t0p
} remfix_r
  {cl,cr:clr}
  {bh:nat}{v:nat}
(
  k: key, x: itm
, tl: rbtree (key, itm, cl, bh+1, 0)
, tr: rbtree (key, itm, cr, bh  , v)
) :<>
[
  c:clr;v:nat | v <= cl
] rbtree (key, itm, c, bh+1, v) = let
  #define B BLK; #define R RED
in
//
case+ tr of
| T(R, kr, xr, trl, trr) =>
  T{..}{..}{..}{cl}(R, k, x, tl, T (B, kr, xr, trl, trr))
| _(*non-red-tree*) =>>
  (
    case+ tl of
    | T{..}{cl,cll,clr}
      (
        B, kl, xl, tll, tlr
      ) =>
      insfix_l
      (
        k, x, T {..}{..}{..}{cll+clr}(R, kl, xl, tll, tlr), tr
      ) (* end of [T (B, ...)] *)
    | T(R, kl, xl, tll, tlr) => let
        val+ T (B, klr, xlr, tlrl, tlrr) = tlr
        val [cl2:int] tl2 = insfix_l (kl, xl, rbtree_redden tll, tlrl)
      in
        T{..}{..}{..}{cl2}(R, klr, xlr, tl2, T(B, k, x, tlrr, tr))
      end (* end of [T (R, ...)] *)
  ) (* end of [_(*non-red-tree*)] *)
end // end of [remfix_r]

(* ****** ****** *)

fun
{key
,itm:t@ype}
rbtree_remove_min
  {c:clr}
  {bh:nat | bh+c > 0} .<bh,c>.
(
  t0: rbtree0 (key, itm, c, bh)
, k0: &key? >> key, x0: &itm? >> itm
, dfbh: &int? >> int (d)
) :<!wrt>
#[d:two | d <= bh]
 [c1:clr | c1 <= c+d]
 rbtree0 (key, itm, c1, bh-d) =
(
//
let
  #define B BLK; #define R RED
in
  case+ t0 of
  | T (B, k, x, tl, tr) =>
    (
    case+ tl of
    | T _ => let
        val tl =
          rbtree_remove_min(tl, k0, x0, dfbh)
        // end of [val]
      in
        if dfbh = 0
          then
          (
            T{..}{..}{..}{0}(B, k, x, tl, tr)
          ) (* end of [then] *)
          else let
            val t2 = remfix_l (k, x, tl, tr)
          in
            case+ t2 of
            | T (R, k, x, tl, tr) =>
                (dfbh := 0; T (B, k, x, tl, tr))
            | _ (* non-red-tree *) =>> t2
          end (* end of [else] *)
        // end of [if]
      end // end of [T]
    | E _ => (k0 := k; x0 := x; dfbh := 1; tr)
    ) (* end of [T (B, ...)] *) 
  | T (R, k, x, tl, tr) =>
    (
    case+ tl of
    | T _ => let
        val tl =
          rbtree_remove_min(tl, k0, x0, dfbh)
        // end of [val]
      in
        if dfbh = 0
          then
          (
            T{..}{..}{..}{0}(R, k, x, tl, tr)
          ) (* end of [then] *)
          else let // dfbh = 1
            val () = dfbh := 0 in
            insfix_r (k, x, tl, rbtree_redden tr)
          end (* end of [else] *)
        // end of [if]
      end // end of [T (B, ...)]
    | E () => (k0 := k; x0 := x; dfbh := 0; tr)
    ) (* end of [T (R, ...)] *)
end // end of [let]
//
) (* end of [rbtree_remove_min] *)

(* ****** ****** *)

fn
{key
,itm:t@ype
} rbtree_join
  {cl,cr:clr}{bh:nat}
(
  tl: rbtree0 (key, itm, cl, bh)
, tr: rbtree0 (key, itm, cr, bh)
) :<!wrt>
[
  c:clr;v:nat | v <= cl+cr
] rbtree (key, itm, c, bh, v) =
(
//
case+ tr of
| E _ => tl
| T _ => let
    var k0: key
    and x0: itm
    var dfbh: int // uninitialized
    val [cr:int] tr = rbtree_remove_min(tr, k0, x0, dfbh)
  in
    if dfbh = 0
      then T{..}{..}{..}{cl+cr}(RED, k0, x0, tl, tr) else remfix_r(k0, x0, tl, tr)
    // end of [if]
  end // end of [T]
//
) (* end of [rbtree_join] *)

(* ****** ****** *)
//
// HX-2011-09-24:
// the pointer [pres] is assumed to be
// associated with a proof of at-view if non-null
//
extern
fun
{key
,itm:t0p}
funmap_takeout_ref
(
  &map (key, itm) >> _, k0: key, pres: ptr
) :<!wrt> bool // end of [funmap_takeout_ref]

implement
{key,itm}
funmap_takeout_ref
(
  map, k0, pres
) = taken where {
//
#define B BLK; #define R RED
//
fun
takeout
{c:clr}
{bh:nat} .<bh,c>.
(
  t0:
  rbtree0
    (key, itm, c, bh)
  // rbtree0
, pres: ptr
, dfbh: &int? >> int(d)
, taken: &bool? >> bool
) :<!wrt>
#[d:two | d <= bh]
 [c1:clr | c1 <= c+d]
 rbtree0 (key, itm, c1, bh-d) =
(
//
case+ t0 of
//
| E () =>
    (dfbh := 0; taken := false; t0)
//
| T (B, k, x, tl, tr) => let
    val sgn =
      compare_key_key<key> (k0, k)
    // end of [val]
  in
    if sgn < 0 then let
      val tl =
        takeout(tl, pres, dfbh, taken)
      // end of [val]
    in
      if dfbh = 0
        then
        (
          T{..}{..}{..}{0}(B, k, x, tl, tr)
        ) (* end of [then] *)
        else let // dfbh = 1
          val t2 = remfix_l (k, x, tl, tr)
        in
          case+ t2 of
          | T (R, k, x, tl, tr) =>
              (dfbh := 0; T (B, k, x, tl, tr))
          | _ (* non-red-tree *) =>> t2
        end (* end of [else] *)
      // end of [if]
    end else if sgn > 0 then let
      val tr =
        takeout (tr, pres, dfbh, taken)
      // end of [val]
    in
      if dfbh = 0
        then
        (
          T{..}{..}{..}{0}(B, k, x, tl, tr)
        ) (* end of [then] *)
        else let // dfbh = 1
          val t2 = remfix_r (k, x, tl, tr)
        in
          case+ t2 of
          | T (R, k, x, tl, tr) =>
              (dfbh := 0; T (B, k, x, tl, tr))
          | _ (* non-red-tree *) =>> t2
        end (* end of [else] *)
    end else let // x0 = x
      val () =
      if (pres > 0) then $UN.ptr0_set<itm>(pres, x)
      val () = taken := true
      val t2 = rbtree_join (tl, tr)
    in
      case+ t2 of
      | T (R, k, x, tl, tr) =>
          (dfbh := 0; T (B, k, x, tl, tr))
      | _ (* non-red-tree *) =>> (dfbh := 1; t2)
    end (* end of [if] *)
  end // end of [T (B, ...)]
//
| T (R, k, x, tl, tr) => let
    val sgn =
      compare_key_key<key> (k0, k)
    // end of [val]
  in
    if sgn < 0 then let
      val tl =
        takeout(tl, pres, dfbh, taken)
      // end of [val]
    in
      if dfbh = 0
        then
        (
          T{..}{..}{..}{0}(R, k, x, tl, tr)
        ) (* end of [then] *)
        else let // dfbh = 1
          val () = dfbh := 0 in remfix_l (k, x, tl, tr)
        end (* end of [else] *)
      // end of [if]
    end else if sgn > 0 then let
      val tr = takeout(tr, pres, dfbh, taken)
    in
      if dfbh = 0
        then
        (
          T{..}{..}{..}{0}(R, k, x, tl, tr)
        ) (* end of [then] *)
        else let // dfbh = 1
          val () = dfbh := 0 in remfix_r (k, x, tl, tr)
        end (* end of [else] *)
      // end of [if]
    end else let // x0 = x
      val () = dfbh := 0
      val () =
      if (pres > 0) then $UN.ptr0_set<itm> (pres, x)
      val () = taken := true
    in
      rbtree_join (tl, tr)
    end (* end of [if] *)
  end // end of [T (R, ...)]
//
) (* end of [takeout] *)
//
var dfbh: int and taken: bool
//
val () =
(
  map := takeout (map, pres, dfbh, taken)
) (* end of [val] *)
//
} (* end of [funmap_takeout_ref] *)

(* ****** ****** *)

implement
{key,itm}
funmap_takeout
(
  map, k0, res
) = ans where {
//
val ans =
  funmap_takeout_ref<key,itm> (map, k0, addr@res)
//
val [b:bool] ans = g1ofg0(ans)
//
prval
pfres =
__assert
(
  view@ res
) where {
  extern
  praxi __assert{l_res:addr} (pf: itm? @ l_res):<> (opt (itm, b) @ l_res)
} (* end of [prval] *)
//
prval () = view@res := pfres
//
} (* end of [funmap_takeout] *)

(* ****** ****** *)
//
implement
{key,itm}
funmap_remove
  (map, k0) =
  funmap_takeout_ref<key,itm> (map, k0, the_null_ptr)
//
(* ****** ****** *)

implement
{key,itm}{env}
funmap_foreach_env
  (xs, env) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
val p_env = addr@ (env)
//
fun
foreach
{c:clr}
{bh:nat} .<bh,c>.
(
  t0: rbtree0 (c, bh), p_env: ptr
) : void = let
in
//
case+ t0 of
//
| E ((*void*)) => ()
//
| T (_, k, x, tl, tr) => let
//
    val () = foreach (tl, p_env)
//
    val (
      pf, fpf | p_env
    ) = $UN.ptr_vtake (p_env)
    val ((*void*)) =
      funmap_foreach$fwork<key,itm><env> (k, x, !p_env)
    prval ((*void*)) = fpf (pf)
//
    val () = foreach (tr, p_env)
//
  in
    // nothing
  end // end of [T]
//
end // end of [foreach]
//
in
  foreach (xs, p_env)
end // end of [funmap_foreach_env]

(* ****** ****** *)

implement
{key,itm}
funmap_rbtree_height
  (t0) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
aux
{c:clr}
{bh:nat} .<bh,c>.
(
  t0: rbtree0 (c, bh)
) :<> intGte(0) = (
//
case+ t0 of
| E ((*void*)) => 0
| T (_, _, _, tl, tr) => 1 + max (aux(tl), aux(tr))
//
) (* end of [aux] *)
//
in
  aux(t0)
end // end of [funmap_rbtree_height]

(* ****** ****** *)

implement
{key,itm}
funmap_rbtree_bheight
  (t0) = let
//
typedef
rbtree0
(
  c:int, bh:int
) = rbtree0(key, itm, c, bh)
//
fun
aux
{c:clr}
{bh,n:nat} .<bh,c>.
(
  t0: rbtree0 (c, bh), n: int(n)
) :<> int(bh+n) = (
//
case+ t0 of
| E ((*void*)) => n
| T (c, _, _, tl, tr) => aux(tl, n+1-c)
//
) (* end of [aux] *)
//
in
  aux(t0, 0)
end // end of [funmap_rbtree_bheight]

(* ****** ****** *)

(* end of [funmap_rbtree.dats] *)
