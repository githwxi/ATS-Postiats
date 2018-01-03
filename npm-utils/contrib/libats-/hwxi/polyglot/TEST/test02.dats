(* ****** ****** *)
(*
** HX-2017-12-25:
** For testing polyglot
*)
(* ****** ****** *)
//
%{^
//
#include <pthread.h>
//
#ifdef ATS_MEMALLOC_GCBDW
#undef GC_H
#define GC_THREADS
#include <gc/gc.h>
#endif // #if(ATS_MEMALLOC_GCBDW)
//
%} // end of [%{^]
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
_(*HF*) = "libats/DATS/hashfun.dats"
#staload
_(*LM*) = "libats/DATS/linmap_list.dats"
#staload
_(*HT*) = "libats/DATS/hashtbl_chain.dats"
//
(* ****** ****** *)
//
#staload
_(*anon*) = "libats/libc/DATS/dirent.dats"
#staload
_(*anon*) = "prelude/DATS/filebas_dirent.dats"
//
(* ****** ****** *)
//
#include
"libats/BUCS520/StreamPar/mydepies.hats"
#include
"libats/BUCS520/StreamPar/mylibies.hats"
//
#include
"$PATSHOMELOCS/atscntrb-hx-find-cli/mylibies.hats"
//
(* ****** ****** *)
//
#include
"./../mylibies.hats"
#include
"./../mylibies_link.hats"
//
#staload $Polyglot // opening it
//
(* ****** ****** *)

#staload
FWS = $FWORKSHOP_chanlst

(* ****** ****** *)

#staload
"libats/libc/SATS/fnmatch.sats"

(* ****** ****** *)

implement
main0(argc, argv) = () where
{
//
val () =
println!
("Hello from [polyglot]!")
//
val dir =
(
if argc >= 2 then argv[1] else "."
) : string // end of [val]
//
val
theFCS =
fcountlst_make_nil(1024)
//
val-
~Some_vt(fnames) =
$FindCli.streamize_dirname_fname<>
(
  dir
) where
{
//
implement
$FindCli.streamize_dirname_fname$ignore<>
  (l0, dir, fname) =
(
  fnmatch_null(".*", fname) = 0
)
//
} // $FindCli.streamize_dirname_fname
//
val
fws = fws where
{
val fws =
$FWS.fworkshop_create_exn()
val err =
$FWS.fworkshop_add_worker(fws)
val err =
$FWS.fworkshop_add_worker(fws)
} (* end of [val] *)
//
vtypedef
a = fname
and
b = fcountopt
and
r = fcountlst
//
val
theFCS =
$StreamPar.streampar_mapfold<a><b><r>
(
fws, fnames, theFCS
) where
{
//
implement
$StreamPar.streampar_mapfold$map<a><b>
  (x0) = let
//
val
fnm = $UN.strptr2string(x0)
//
val opt = fname_get_type(fnm)
//
val type =
(
case+ opt of
| ~Some_vt(type) => type
| ~None_vt((*void*)) => "(EXTLESS)"
) : string // end of [val]
//
val opt = fileref_open_opt(fnm, file_mode_r)
//
in
//
case+ opt of
| ~Some_vt(inp) => let
    val inp =
    $UN.castvwtp0{FILEptr1}(inp)
    val fc0 =
    fline_stream_count
      (type, streamize_fileptr_line(inp))
    // end of [val]
  in
    strptr_free(x0); Some_vt(fc0)
  end // end of [then]
| ~None_vt((*void*)) =>
  (
    prerrln!
    ("Warning: Cannot open the file: ", fnm);
    strptr_free(x0); None_vt(*void*)
  )
//
end // end of [$StreamPar.streampar_mapfold$map]
//
implement
$StreamPar.streampar_mapfold$fold<b><r>
  (opt, fcs) = let
//
in
//
case+ opt of
| ~None_vt() =>
  (
    fcs
  )
| ~Some_vt(fc0) =>
  (
    fcs
  ) where
  {
    val () = fcountlst_add_fcount(fcs, fc0)
  } (* end of [Some_vt] *)
//
end // end of [$StreamPar.streampar_mapfold$fold]
//
} (* end of [where] *) // end of [$StreamPar.streampar_mapfold]
//
val
theFCS =
fcountlst_listize0(theFCS)
//
val
theFCS =
list_vt_mergesort<fcount>
(
theFCS
) where
{
implement
list_vt_mergesort$cmp<fcount>
  (x, y) = compare(x.type(), y.type())
} (* end of [val] *)
//
val ((*void*)) =
fprintfree_fcountlst(stdout_ref, theFCS)
//
} (* end of [main0] *)

(* ****** ****** *)

(*
Support the following?

polyglot --exclude "./src/*"
polyglot --include "*.{s,d,c,h}?ats" "*.{c,h}" "*.js"

*)

(* ****** ****** *)

(* end of [test02.dats] *)
