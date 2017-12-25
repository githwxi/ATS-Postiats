(* ****** ****** *)
(*
** HX-2017-12-25:
** Polyglot is inspired by
** https://github.com/vmchale/polyglot
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
// HX: for hashtable
//
#staload
HT = "libats/SATS/hashtbl_chain.sats"
#staload
_(*HT*) = "libats/DATS/linmap_list.dats"
#staload
_(*HT*) = "libats/DATS/hashtbl_chain.dats"
//
(* ****** ****** *)

datavtype
fcount = FCOUNT of @{
  type= string
,
  nfile= uint
,
  nline= uint64
,
  nblnk= uint64
,
  ncmnt= uint64
}

vtypedef fcountopt = Option_vt(fcount)

(* ****** ****** *)
//
extern
fun
add_fcount_fcount
  (fcount, fcount): fcount
//
overload + with add_fcount_fcount
//
implement
add_fcount_fcount
  (fc1, fc2) = let
//
val+@FCOUNT(rec1) = fc1
val+@FCOUNT(rec2) = fc2
//
val () =
rec1.nfile := rec1.nfile + rec2.nfile
val () =
rec1.nline := rec1.nline + rec2.nline
val () =
rec1.nblnk := rec1.nblnk + rec2.nblnk
val () =
rec1.ncmnt := rec1.ncmnt + rec2.ncmnt
//
in
  fold@(fc1); free@(fc2); fc1
end // end of [add_fcount_fcount]
//
(* ****** ****** *)

absvtype fcountlst_vtype = ptr
vtypedef fcountlst = fcountlst_vtype

(* ****** ****** *)
//
extern
fun
fcountlst_make_nil
  (cap: intGte(1)): fcountlst
//
extern
fun
fcountlst_listize0
  (fcountlst): List0_vt(fcount)
//
(* ****** ****** *)
//
extern
fun
fcountlst_add_fcount
  (fcs: !fcountlst, fc0: fcount): void
//
(* ****** ****** *)

local

typedef key = string
vtypedef itm = fcount

assume
fcountlst_vtype = $HT.hashtbl(key, itm)

in (* in-of-local *)

(* ****** ****** *)
//
implement
fcountlst_make_nil
  (cap) =
  $HT.hashtbl_make_nil<key,itm>(i2sz(cap))
//  
(* ****** ****** *)

implement
fcountlst_listize0
  (fcs) = let
//
vtypedef ki2 = itm
//
in
//
$HT.hashtbl_flistize<key,itm><ki2>
(
  fcs
) where
{
  implement
  $HT.hashtbl_flistize$fopr<key,itm><ki2>(k, x) = x
}
//
end // end of [fcountlst_listize0]

(* ****** ****** *)

implement
fcountlst_add_fcount
  (fcs, fc0) = let
//
val+
FCOUNT(@{type=type, ...}) = fc0
//
val
cp0 =
$HT.hashtbl_search_ref<key,itm>(fcs, type)
//
in
//
if
(cp0 > 0)
then let
//
val
fc1 =
$UN.cptr_get<itm>(cp0)
val () =
$UN.cptr_set<itm>(cp0, fc1 + fc0)
//
in
  // nothing
end // end of [then]
else
$HT.hashtbl_insert_any<key,itm>(fcs, type, fc0)
//
end // end of [fcountlst_add_fcount]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)
//
vtypedef
fline = Strptr1
vtypedef
flines = stream_vt(fline)
//
extern
fun
fline_stream_count
(type: string, xs: flines): fcount
//
implement
fline_stream_count
  (type, xs) = let
//
fun
loop
( xs: flines
, nline: uint
, nblnk: uint
, ncmnt: uint
) : fcount =
(
case+ !xs of
| ~stream_vt_nil() =>
  (
    FCOUNT(@{
      type=type
    , nfile=1u
    , nline=g0uint2uint(nline)
    , nblnk=g0uint2uint(nblnk)
    , ncmnt=g0uint2uint(ncmnt)
    }) (* FCOUNT *)
  )
| ~stream_vt_cons(x0, xs) =>
  (
    free(x0);
    loop(xs, succ(nline), nblnk, ncmnt)
  )
)
//
in
  loop(xs, 0u, 0u, 0u)
end // end of [fline_stream_count]
//
(* ****** ****** *)



(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println! ("Hello from [polyglot]!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [polyglot.dats] *)
