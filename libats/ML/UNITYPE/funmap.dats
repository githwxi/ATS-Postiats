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
#staload FM =
  "libats/ML/SATS/funmap.sats"
//
(* ****** ****** *)
//
// HX: Interface
//
(* ****** ****** *)
//
abstype map_type
typedef map = map_type
//
(*
typedef fset = set(gvalue)
*)
//
(* ****** ****** *)
//
extern
fun
funmap_nil():<> map
and
funmap_make_nil():<> map
//
(* ****** ****** *)
//
extern
fun
funmap_size(map):<> intGte(0)
//
overload size with funmap_size
//
extern
fun
funmap_is_nil(map):<> bool
and
funmap_isnot_nil(map):<> bool
//
overload iseqz with funmap_is_nil
overload isneqz with funmap_isnot_nil
//
(* ****** ****** *)
//
extern
fun
funmap_foreach_cloref
( kxs: map
, fwork: (string, gvalue) -<cloref1> void
) : void // end of [funmap_foreach_cloref]
//
extern
fun
funmap_foreach_method
(
  kxs: map
)
(
  fwork: (string, gvalue) -<cloref1> void
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
map_type =
$FM.map(string, gvalue)
//
(* ****** ****** *)
//
implement
funmap_nil() =
$FM.funmap_nil<>{string,gvalue}()
implement
funmap_make_nil() =
$FM.funmap_make_nil<>{string,gvalue}()
//
(* ****** ****** *)
//
implement
funmap_size(kxs) =
  sz2i(g1ofg0(msz)) where
{
  val msz =
    $FM.funmap_size<string,gvalue>(kxs)
  // end of [val]
}
//
(* ****** ****** *)
//
implement
funmap_is_nil(kxs) =
$FM.funmap_is_nil<>{string,gvalue}(kxs)
implement
funmap_isnot_nil(kxs) =
$FM.funmap_isnot_nil<>{string,gvalue}(kxs)
//
(* ****** ****** *)
//
implement
funmap_foreach_method
  (kxs) =
(
lam(fwork) =>
  funmap_foreach_cloref(kxs, fwork)
) (* end of [funmap_foreach_method] *)
//
implement
funmap_foreach_cloref
  (kxs, fwork) =
(
$FM.funmap_foreach_cloref<string,gvalue>
  (kxs, fwork)
) (* end of [funmap_foreach_cloref] *)
//
(* ****** ****** *)

(* end of [funmap.dats] *)
