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
"ATSLIB.libats.ML.BOXED"
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
#staload FM =
"libats/ML/SATS/funmap.sats"
//
#staload _(*FM*) =
"libats/ML/DATS/funmap.dats"
#staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//
(* ****** ****** *)
//
// HX: Interface
//
(* ****** ****** *)
//
// HX: covariant
//
abstype
map_type(itm:t@ype+)
//
typedef
map(a:t@ype) = map_type(a)
//
(* ****** ****** *)
//
extern
fun
funmap_nil
{itm:type}((*void*)):<> map(itm)
and
funmap_make_nil
{itm:type}((*void*)):<> map(itm)
//
(* ****** ****** *)
//
extern
fun
funmap_size
{itm:type}(map(itm)):<> intGte(0)
//
overload size with funmap_size
//
extern
fun
funmap_is_nil
{itm:type}(kxs: map(itm)):<> bool
and
funmap_isnot_nil
{itm:type}(kxs: map(itm)):<> bool
//
overload iseqz with funmap_is_nil
overload isneqz with funmap_isnot_nil
//
(* ****** ****** *)
//
extern
fun
funmap_search
{itm:type}
(
  kxs: map(INV(itm)), k0: string
) : Option_vt(itm) // end of [funmap_search]
//
overload .search with funmap_search
//
(* ****** ****** *)
//
extern
fun
funmap_insert
{itm:type}
(
  &map(INV(itm)) >> _, k0: string, x0: itm
) : Option_vt(itm) // end of [funmap_insert]
//
overload .insert with funmap_insert
//
(* ****** ****** *)
//
extern
fun
funmap_remove
{itm:type}
(kxs: &map(INV(itm)) >> _, k0: string): bool
and
funmap_takeout
{itm:type}
(kxs: &map(INV(itm)) >> _, k0: string): Option_vt(itm)
//
overload .remove with funmap_remove
overload .takeout with funmap_takeout
//
(* ****** ****** *)
//
extern
fun
funmap_foreach_cloref
{itm:type}
( kxs: map(INV(itm))
, fwork: (string, itm) -<cloref1> void
) : void // end of [funmap_foreach_cloref]
//
extern
fun
funmap_foreach_method
{itm:type}
(
  kxs: map(INV(itm))
)
(
  fwork: (string, itm) -<cloref1> void
) : void // end of [funmap_foreach_method]
//
overload .foreach with funmap_foreach_method
//
(* ****** ****** *)
//
// HX: Implementation
//
(* ****** ****** *)
//
assume
map_type
(itm:t@ype) = $FM.map(string, itm)
//
(* ****** ****** *)
//
implement
funmap_nil
{itm}((*void*)) =
$FM.funmap_nil<>{string,itm}()
//
implement
funmap_make_nil
{itm}((*void*)) =
$FM.funmap_make_nil<>{string,itm}()
//
(* ****** ****** *)
//
implement
funmap_size
{itm}(kxs) =
sz2i(g1ofg0(msz)) where
{
  val msz =
    $FM.funmap_size<string,itm>(kxs)
  // end of [val]
} (* funmap_size *)
//
(* ****** ****** *)
//
implement
funmap_is_nil
{itm}(kxs) =
$FM.funmap_is_nil<>{string,itm}(kxs)
implement
funmap_isnot_nil
{itm}(kxs) =
$FM.funmap_isnot_nil<>{string,itm}(kxs)
//
(* ****** ****** *)
//
implement
funmap_search
{itm:type}
(kxs, k0) =
$FM.funmap_search<string,itm>(kxs, k0)
//
(* ****** ****** *)
//
implement
funmap_insert
{itm:type}
(kxs, k0, x0) =
$FM.funmap_insert<string,itm>(kxs, k0, x0)
//
(* ****** ****** *)
//
implement
funmap_remove
{itm:type}
(kxs, k0) =
(
  $FM.funmap_remove<string,itm>(kxs, k0)
)
implement
funmap_takeout
{itm:type}
(kxs, k0) =
(
  $FM.funmap_takeout<string,itm>(kxs, k0)
)
//
(* ****** ****** *)
//
implement
funmap_foreach_method
{itm}(kxs) =
(
lam(fwork) =>
  funmap_foreach_cloref(kxs, fwork)
) (* end of [funmap_foreach_method] *)
//
implement
funmap_foreach_cloref
{itm}(kxs, fwork) =
(
$FM.funmap_foreach_cloref<string,itm>
  (kxs, fwork)
) (* end of [funmap_foreach_cloref] *)
//
(* ****** ****** *)

(* end of [funmap.dats] *)
