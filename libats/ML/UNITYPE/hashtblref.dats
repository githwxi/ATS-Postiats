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
abstype hashtbl_type
typedef hashtbl = hashtbl_type
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
hashtbl_get_size(hashtbl): intGte(0)
extern
fun
hashtbl_get_capacity(hashtbl): intGte(1)
//
(* ****** ****** *)

assume
hashtbl_type = $HT.hashtbl(string, gvalue)

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
  (kxs) = sz2i(tblsz) where
{
  val tblsz =
  $HT.hashtbl_get_size<>{string,gvalue}(kxs)
} (* end of [hashtbl_get_size] *)
//
(* ****** ****** *)
//
implement
hashtbl_get_capacity
  (kxs) = sz2i(tblcap) where
{
  val tblcap =
  $HT.hashtbl_get_capacity<>{string,gvalue}(kxs)
} (* end of [hashtbl_get_capacity] *)
//
(* ****** ****** *)

(* end of [hashtblref.dats] *)
