(* ****** ****** *)
(*
** HX-2017-12-24:
** Programming support for
** recursive directory-traversal,
** which can be done in parallel
*)
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB.HX.find_cli"
//
(* ****** ****** *)
//
vtypedef fname = Strptr1
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
#staload
FB = "prelude/SATS/filebas.sats"
//
(* ****** ****** *)
//
extern
fun{}
streamize_dirname_fname
(dir: string): Option_vt(stream_vt(fname))
//
extern
fun{}
streamize_dirname_fname$ignore
(l0: int, dir: string, fname: string): bool
extern
fun{}
streamize_dirname_fname$select
(l0: int, dir: string, fname: string): bool
extern
fun{}
streamize_dirname_fname$recurse
(l0: int, dir: string, fname: string): bool
//
(* ****** ****** *)
//
implement
{}(*tmp*)
streamize_dirname_fname$ignore
  (l0, dir, fname) =
(
  ifcase
  | fname =
    dirname_self<>() => true
  | fname =
    dirname_parent<>() => true
  | _(*else*) => false
)
//
implement
{}(*tmp*)
streamize_dirname_fname$select
  (l0, dir, fname) = true
//
implement
{}(*tmp*)
streamize_dirname_fname$recurse
(
l0, dir, fname
) = (
//
if
(
fname=
dirname_self<>()
)
then false else let
//
  val sep =
  dirsep_gets<>()
  val fpath =
  string0_append3<>
    (dir, sep, fname)
  // end of [val]
  val isdir =
  test_file_isdir
    ($UN.strptr2string(fpath))
  // end of [val]
  val ((*freed*)) = strptr_free(fpath)
//
in
  if isdir > 0 then true else false
end // end of [else]
//
) // end of [streamize_dirname_fname$recurse]
//
(* ****** ****** *)

implement
{}(*tmp*)
streamize_dirname_fname
  (dir) = let
//
fun
add_dir_fname
(
  x0: !fname, x1: fname
) : fname = res where
{
  val sep = dirsep_gets<>()
  val x0_ = $UN.strptr2string(x0)
  val x1_ = $UN.strptr2string(x1)
  val res = string0_append3(x0_, sep, x1_)
  val ((*freed*)) = strptr_free(x1)
}
//
overload + with add_dir_fname
//
fun
auxmain1
(
l0: int, x0: fname
) : stream_vt(fname) = let
//
val x0_ =
$UN.strptr2string(x0)
val
fnames =
$FB.streamize_dirname_fname<>(x0_)
//
in
  auxmain2(l0, x0, fnames)
end // end of [auxmain1]
//
and
auxmain2
(
l0: int, x0: fname,
xs: stream_vt(fname)
) : stream_vt(fname) = $ldelay
(
case+ !xs of
| ~stream_vt_nil() =>
  (
    free(x0); stream_vt_nil()
  )
| ~stream_vt_cons(x1, xs) => let
    val x0_ = $UN.strptr2string(x0)
    val x1_ = $UN.strptr2string(x1)
  in
    ifcase
    | streamize_dirname_fname$ignore<>
        (l0, x0_, x1_) =>
      (
        free(x1); !(auxmain2(l0, x0, xs))
      )
    | streamize_dirname_fname$recurse<>
        (l0, x0_, x1_) => !
      (
        stream_vt_append<fname>
          (auxmain1(l0+1, x0+x1), auxmain2(l0, x0, xs))
        // end of [stream_vt_append]
      )
    | streamize_dirname_fname$select<>
        (l0, x0_, x1_) =>
        stream_vt_cons{fname}(x0+x1, auxmain2(l0, x0, xs))
    | _ (* not-to-be-processed *) =>
      (
        free(x1); !(auxmain2(l0, x0, xs))
      )
  end // end of [stream_vt_cons]
, (strptr_free(x0); lazy_vt_free(xs))
) (* end of [$ldelay] *) // end of [auxmain2]
//
in
//
let
val
isdir =
test_file_isdir(dir)
//
in
  if
  (isdir > 0)
  then let
    val
    dir = string0_copy(dir) in Some_vt(auxmain1(0, dir))
  end else None_vt((*void*))
end // end of [let]
//
end // end of [streamize_dirname_fname]

(* ****** ****** *)

(* end of [find_cli.dats] *)
