(* ****** ****** *)
(*
** HX-2017-12-25:
** For testing polyglot
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
"libats/libc/SATS/fnmatch.sats"

(* ****** ****** *)

implement
main0(argc, argv) = () where
{
//
val () =
println! ("Hello from [polyglot]!")
//
val dir =
(
if argc >= 2 then argv[1] else "."
) : string // end of [val]
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
theFCS =
fcountlst_make_nil(1024)
val
((*void*)) =
fcountlst_add_fnames(theFCS, fnames)
//
val
theFCS =
fcountlst_listize0
(theFCS)
val
theFCS =
list_vt_mergesort<fcount>
(
theFCS
) where
{
implement
list_vt_mergesort$cmp<fcount>(x, y) = compare(x.type(), y.type())
} (* end of [val] *)
//
val ((*void*)) =
fprintfree_fcountlst(stdout_ref, theFCS)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
