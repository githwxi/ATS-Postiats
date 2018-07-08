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
"ATSLIB.libats.ML.COMPILE"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/list0.sats"
//
(* ****** ****** *)
//
#staload HT =
"libats/ML/SATS/hashtblref.sats"
#staload _(*HT*) =
"libats/ML/DATS/hashtblref.dats"
//
#staload
_(*HT*) = "libats/DATS/qlist.dats"
#staload
_(*HT*) = "libats/DATS/hashfun.dats"
#staload
_(*HT*) = "libats/DATS/linmap_list.dats"
#staload
_(*HT*) = "libats/DATS/hashtbl_chain.dats"
//
(* ****** ****** *)
//
// HX: Interface
//
(* ****** ****** *)
//
// HX: invariant
//
abstype
hashtbl_type(itm:t@ype)
//
typedef
hashtbl
(itm:t@ype) = hashtbl_type(itm)
//
(* ****** ****** *)
//
extern
fun
hashtbl_make_nil
{itm:type}
  (cap: intGte(1)): hashtbl(itm)
//
(* ****** ****** *)
//
extern
fun
hashtbl_get_size
{itm:type}
(kxs: hashtbl(itm)): intGte(0)
and
hashtbl_get_capacity
{itm:type}
(kxs: hashtbl(itm)): intGte(1)
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
{itm:type}
(
  kxs: hashtbl(INV(itm)), k0: string
) : Option_vt(itm) // end-of-function
//
overload .search with hashtbl_search
//
(* ****** ****** *)
//
extern
fun
hashtbl_search_ref
{itm:type}
(
  kxs: hashtbl(INV(itm)), k0: string
) : cPtr0(itm) // end-of-function
//
overload .search_ref with hashtbl_search_ref
//
(* ****** ****** *)
//
extern
fun
hashtbl_insert
{itm:type}
( kxs: hashtbl(INV(itm))
, key: string, itm: itm): Option_vt(itm)
//
overload .insert with hashtbl_insert
//
(* ****** ****** *)
//
extern
fun
hashtbl_insert_any
{itm:type}
( kxs: hashtbl(INV(itm))
, key: string, itm: itm): void
//
overload .insert_any with hashtbl_insert_any
//
(* ****** ****** *)
//
extern
fun
hashtbl_takeout
{itm:type}
(
  kxs: hashtbl(INV(itm)), k0: string
) : Option_vt(itm) // end-of-function
//
overload .takeout with hashtbl_takeout
//
(* ****** ****** *)
//
extern
fun
hashtbl_listize0
{itm:type}
(kxs: hashtbl(itm)): list0(@(string, itm))
extern
fun
hashtbl_listize1
{itm:type}
(kxs: hashtbl(itm)): list0(@(string, itm))
//
overload listize0 with hashtbl_listize0
overload listize1 with hashtbl_listize1
//
(* ****** ****** *)
//
extern
fun
hashtbl_foreach_cloref
{itm:type}
( kxs: hashtbl(itm)
, fwork: (string, &itm >> _) -<cloref1> void
) : void // end of [hashtbl_foreach_cloref]
//
extern
fun
hashtbl_foreach_method
{itm:type}
(
  kxs: hashtbl(itm)
)
(
  fwork: (string, &itm >> _) -<cloref1> void
) : void // end of [hashtbl_foreach_method]
//
overload .foreach with hashtbl_foreach_method
//
(* ****** ****** *)
//
// HX: Implementation
//
(* ****** ****** *)
//
assume
hashtbl_type
(itm:t@ype) = $HT.hashtbl(string, itm)
//
(* ****** ****** *)
//
implement
hashtbl_make_nil
{itm}(cap) = let
  val cap = i2sz(cap)
in
  $HT.hashtbl_make_nil<string,itm>(cap)
end // end of [hashtbl_make_nil]
//
(* ****** ****** *)
//
implement
hashtbl_get_size
{itm}(kxs) = sz2i(sz) where
{
  val sz =
  $HT.hashtbl_get_size<>(kxs)
} (* end of [hashtbl_get_size] *)
//
(* ****** ****** *)
//
implement
hashtbl_get_capacity
{itm}(kxs) = sz2i(cap) where
{
  val cap =
  $HT.hashtbl_get_capacity<>(kxs)
} (* end of [hashtbl_get_capacity] *)
//
(* ****** ****** *)
//
implement
hashtbl_search
{itm}(kxs, k0) =
(
$HT.hashtbl_search<string,itm>(kxs, k0)
)
//
implement
hashtbl_search_ref
{itm}(kxs, k0) =
(
$HT.hashtbl_search_ref<string,itm>(kxs, k0)
)
//
(* ****** ****** *)
//
implement
hashtbl_insert
{itm}(kxs, k0, x0) =
(
$HT.hashtbl_insert<string,itm>(kxs,k0,x0)
) (* end of [hashtbl_insert] *)
//
implement
hashtbl_insert_any
{itm}(kxs, k0, x0) =
(
$HT.hashtbl_insert_any<string,itm>(kxs,k0,x0)
) (* end of [hashtbl_insert_any] *)
//
(* ****** ****** *)
//
implement
hashtbl_takeout
{itm}(kxs, k0) =
(
  $HT.hashtbl_takeout<string,itm>(kxs, k0)
)
//
(* ****** ****** *)
//
implement
hashtbl_foreach_method
{itm}(kxs) =
(
lam(fwork) =>
  hashtbl_foreach_cloref(kxs, fwork)
) (* end of [hashtbl_foreach_method] *)
//
implement
hashtbl_foreach_cloref
{itm}(kxs, fwork) =
(
//
$HT.hashtbl_foreach_cloref<string,itm>
  (kxs, fwork)
//
) (* end of [hashtbl_foreach_cloref] *)
//
(* ****** ****** *)
//
implement
hashtbl_listize0
{itm}(kxs) =
  $HT.hashtbl_listize0<string,itm>(kxs)
implement
hashtbl_listize1
{itm}(kxs) =
  $HT.hashtbl_listize1<string,itm>(kxs)
//
(* ****** ****** *)

(* end of [hashtblref.dats] *)
