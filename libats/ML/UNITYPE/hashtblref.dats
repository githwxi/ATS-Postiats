(* ****** ****** *)
//
// HX-2017-10-28:
// For supporting
// "unityped" programming
//
(* ****** ****** *)
//
(*
#define
ATS_DYNLOADFLAG 1
*)
#define
ATS_PACKNAME
"ATSLIB.libats.ML.UNITYPE"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload HT =
"libats/ML/SATS/hashtblref.sats"
//
(* ****** ****** *)
//
// HX-2017-10-28: Interface
//
(* ****** ****** *)
//
abstype
hashtbl_type
typedef
hashtbl = hashtbl_type
(*
typedef
hashtbl =
$HT.hashtbl(string, gvalue)
*)
//
(* ****** ****** *)
//
typedef
keyitm = @(string, gvalue)
//
(* ****** ****** *)
//
typedef
gvopt = Option(gvalue)
vtypedef
gvopt_vt = Option_vt(gvalue)
//
(* ****** ****** *)
//
extern
fun
hashtbl_make_nil
  (cap: intGte(1)): hashtbl
//
(* ****** ****** *)
//
extern
fun
hashtbl_get_size
  (kxs: hashtbl): intGte(0)
and
hashtbl_get_capacity
  (kxs: hashtbl): intGte(1)
//
overload
.size with hashtbl_get_size
overload
.capacity with hashtbl_get_capacity
//
(* ****** ****** *)
//
extern
fun
hashtbl_search
(kxs: hashtbl, key: string): gvopt_vt
//
overload .search with hashtbl_search
//
(* ****** ****** *)
//
extern
fun
hashtbl_insert
( hashtbl
, key: string, itm: gvalue): gvopt_vt
//
overload .insert with hashtbl_insert
//
(* ****** ****** *)
//
extern
fun
hashtbl_takeout
(kxs: hashtbl, key: string): gvopt_vt
//
overload .takeout with hashtbl_takeout
//
(* ****** ****** *)
//
extern
fun
hashtbl_listize0
  (kxs: hashtbl): list0(keyitm)
extern
fun
hashtbl_listize1
  (kxs: hashtbl): list0(keyitm)
//
overload listize0 with hashtbl_listize0
overload listize1 with hashtbl_listize1
//
(* ****** ****** *)
//
extern
fun
hashtbl_foreach_cloref
( tbl: hashtbl
, fwork:
  (string, &gvalue >> _) -<cloref1> void
) : void // end of [hashtbl_foreach_cloref]
//
extern
fun
hashtbl_foreach_method
(
  tbl: hashtbl
)
(
  fwork:
  (string, &gvalue >> _) -<cloref1> void
) : void // end of [hashtbl_foreach_method]
//
overload .foreach with hashtbl_foreach_method
//
(* ****** ****** *)
//
// HX-2017-10-28: Implementation
//
(* ****** ****** *)

assume
hashtbl_type =
$HT.hashtbl(string, gvalue)

(* ****** ****** *)
//
implement
hashtbl_make_nil
  (cap) = let
  val cap = i2sz(cap)
in
  $HT.hashtbl_make_nil<string,gvalue>(cap)
end // end of [hashtbl_make_nil]
//
(* ****** ****** *)
//
implement
hashtbl_get_size
  (kxs) = sz2i(sz) where
{
  val sz = $HT.hashtbl_get_size<>(kxs)
} (* end of [hashtbl_get_size] *)
//
(* ****** ****** *)
//
implement
hashtbl_get_capacity
  (kxs) = sz2i(cap) where
{
  val cap = $HT.hashtbl_get_capacity<>(kxs)
} (* end of [hashtbl_get_capacity] *)
//
(* ****** ****** *)
//
implement
hashtbl_search(kxs, k0) =
$HT.hashtbl_search<string,gvalue>(kxs, k0)
//
(* ****** ****** *)
//
implement
hashtbl_insert(kxs, k0, x0) =
(
$HT.hashtbl_insert<string,gvalue>(kxs, k0, x0)
) (* end of [hashtbl_insert] *)
//
(* ****** ****** *)
//
implement
hashtbl_takeout(kxs, k0) =
$HT.hashtbl_takeout<string,gvalue>(kxs, k0)
//
(* ****** ****** *)
//
implement
hashtbl_foreach_cloref
  (kxs, fwork) =
(
//
$HT.hashtbl_foreach_cloref<string,gvalue>
  (kxs, fwork)
//
) (* end of [hashtbl_foreach_cloref] *)
//
implement
hashtbl_foreach_method
  (kxs) =
(
lam(fwork) => hashtbl_foreach_cloref(kxs, fwork)
) (* end of [hashtbl_foreach_method] *)
//
(* ****** ****** *)
//
implement
hashtbl_listize0(kxs) =
  $HT.hashtbl_listize0<string,gvalue>(kxs)
implement
hashtbl_listize1(kxs) =
  $HT.hashtbl_listize1<string,gvalue>(kxs)
//
(* ****** ****** *)

(* end of [hashtblref.dats] *)
