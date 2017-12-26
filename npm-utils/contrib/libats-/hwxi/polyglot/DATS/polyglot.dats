(* ****** ****** *)
(*
** HX-2017-12-25:
** Polyglot is inspired by
** https://github.com/vmchale/polyglot
*)
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB.HX.polyglot"
//
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
fcount_get_type(!fcount):<> string
//
overload .type with fcount_get_type
//
(* ****** ****** *)

implement
fcount_get_type
  (fc0) = type where
{
  val+FCOUNT(@{type=type, ...}) = fc0
} (* end of [fcount_get_type] *)

(* ****** ****** *)
//
extern
fun
fprintfree_fcount
(out: FILEref, fc0: fcount): void
extern
fun
fprintfree_fcountlst
(out: FILEref, fcs: List0_vt(fcount)): void
//
(* ****** ****** *)

implement
fprintfree_fcount
  (out, fc0) = let
//
val+~FCOUNT(rec0) = fc0
//
in
//
fprintln!(out, rec0.type, ": ", "nfile(", rec0.nfile, ")");
fprintln!(out, rec0.type, ": ", "nline(", rec0.nline, ")");
fprintln!(out, rec0.type, ": ", "nblnk(", rec0.nblnk, ")");
//
end // end of [fprintfree_fcount]

implement
fprintfree_fcountlst
  (out, fcs) =
  loop(out, fcs) where
{
fun
loop
( out: FILEref,
  fcs: List0_vt(fcount)): void =
(
case+ fcs of
| ~list_vt_nil() => ()
| ~list_vt_cons(fc0, fcs) =>
  (
    fprintfree_fcount(out, fc0); loop(out, fcs)
  )
)
} (* end of [fprintfree_fcountlst] *)

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
  (fcs: fcountlst): List0_vt(fcount)
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
    , nline=$UN.cast{uint64}(nline)
    , nblnk=$UN.cast{uint64}(nblnk)
    , ncmnt=$UN.cast{uint64}(ncmnt)
    }) (* FCOUNT *)
  )
| ~stream_vt_cons(x0, xs) => let
    val
    nline = succ(nline)
    val
    nblnk = (
      if
      iseqz
      ($UN.strptr2string(x0))
      then succ(nblnk) else nblnk
    ) : uint // end of [val]
  in
    free(x0);
    loop(xs, nline, nblnk, ncmnt)
  end // end of [val]
)
//
in
  loop(xs, 0u, 0u, 0u)
end // end of [fline_stream_count]
//
(* ****** ****** *)
//
extern
fun
fname_get_type
(fname: string): Option_vt(string)
//
local
//
#staload
FT = "./filetype.dats"
//
in (* in-of-local *)

implement
fname_get_type
  (fname) = let
//
val
(fstr|str) =
filename_get_ext(fname)
//
in
//
if
isneqz(str)
then
Some_vt(type) where
{
//
val
type =
$FT.theExtMap_search
(
  $UN.strptr2string(str)
)
//
prval ((*returned*)) = fstr(str)
//
} (* end of [then] *)
else None_vt() where
{
prval ((*returned*)) = fstr(str)
} (* end of [else] *)
//
end // end of [fname_get_type]

end // end of [local]

(* ****** ****** *)

vtypedef fname = Strptr1
vtypedef fnames = stream_vt(fname)

(* ****** ****** *)
//
extern
fun
fcountlst_add_fname
  (fcs: !fcountlst, x0: fname): void
extern
fun
fcountlst_add_fnames
  (fcs: !fcountlst, xs: fnames): void
//
(* ****** ****** *)

implement
fcountlst_add_fname
  (fcs, x0) = let
//
val x0_ =
(
  $UN.strptr2string(x0)
)
//
val opt = fname_get_type(x0_)
//
val type =
(
case+ opt of
| ~Some_vt(type) => type
| ~None_vt((*void*)) => "(EXTLESS)"
) : string // end of [val]
//
(*
val () = println! ("fcountlst_add_fname: x0 = ", x0_)
val () = println! ("fcountlst_add_fname: type = ", type)
*)
//
val
opt =
fileref_open_opt(x0_, file_mode_r)
//
in
//
case+ opt of
| ~None_vt() =>
  (
    prerrln!
    ("Warning: Cannot open the file: ", x0_);
    strptr_free(x0)
  )
| ~Some_vt(inp) => let
    val inp =
    $UN.castvwtp0{FILEptr1}(inp)
    val fc0 =
    fline_stream_count
      (type, streamize_fileptr_line(inp))
    // end of [val]
  in
    strptr_free(x0); fcountlst_add_fcount(fcs, fc0)
  end // end of [then]
//
end // end of [fcountlst_add_fname]

(* ****** ****** *)

implement
fcountlst_add_fnames
  (fcs, xs) =
(
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x0, xs) =>
  (
    fcountlst_add_fname(fcs, x0); 
    fcountlst_add_fnames(fcs, xs);
  )
)

(* ****** ****** *)

(* end of [polyglot.dats] *)
