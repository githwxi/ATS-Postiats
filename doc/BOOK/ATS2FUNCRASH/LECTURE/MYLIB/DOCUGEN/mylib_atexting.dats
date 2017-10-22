(* ****** ****** *)

(* ****** ****** *)
//
#define
ATEXTING_targetloc
"$PATSHOME/utils/atexting"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
macdef
streamize_fileref_line = streamize_fileref_line
//
(* ****** ****** *)
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include
"utils/libatsrec/mylibies.hats"
#include
"utils/libatsrec/mylibies_link.hats"
//
(* ****** ****** *)
//
#define MAIN_NONE 1
//
#include
"{$ATEXTING}/mylibies.hats"
#include
"{$ATEXTING}/mylibies_link.hats"
//
#staload $ATEXTING // opening it
//
(* ****** ****** *)
//
local
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_pre.dats"
in
  // nothing
end // end of [local]
//
local
(*
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_xhtml.dats"
*)
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
(*
extern
fun
libatsynmark_dynloadall(): void = "ext#"
val () = libatsynmark_dynloadall((*void*))
*)
//
(* ****** ****** *)
//
abstype
myentry_type = ptr
local
assume
myentry_type = gvhashtbl
in (*nothing*) end
//
(* ****** ****** *)

typedef
myentry = myentry_type

(* ****** ****** *)
//
extern
fun
theDB_size
(
// argless
) : intGte(0) // endfun
//
extern
fun
theDB_search
(
  name: string
) : Option_vt(myentry)
//
extern
fun
theDB_insert
  (name: string, myentry): void
//
(* ****** ****** *)
//
extern fun theDB_initize(): void
//
(* ****** ****** *)

local

typedef
key = string and itm = myentry
//
implement
fprint_val<myentry>
  (out, x) =
  fprint_string(out, "<myentry>")
//
#include
"libats/ML/HATS/myhashtblref.hats"
//
val
theDB = myhashtbl_make_nil(1024)
//
in
//
implement
theDB_size() = theDB.size()
//
implement
theDB_search(k) = theDB.search(k)
implement
theDB_insert(k, x) =
{
  val-~None_vt() = theDB.insert(k, x)
}

(* ****** ****** *)

implement
theDB_initize() = let
//
val opt =
fileref_open_opt
("./../mylib.arec", file_mode_r)
val-
~Some_vt(inp) = opt
//
val xs =
$LIBATSREC.streamize_fileref_gvhashtbl(inp, 8)
//
in
//
let
reassume myentry_type
//
fun
fwork
(x: myentry): void = let
//
val gv = x["name"]
//
val () = 
fprintln!
  (stderr_ref, "fwork: gv = ", gv)
//
in
case+ gv of
| GVstring(key) =>
  (
    theDB_insert(key, x)
  )
| _(*non-GVstring*) => () where
  {
(*
    val () =
    fprintln! (stderr_ref, "fwork: x = ", x)
*)
  }
end // end of [fwork]
//
in
stream_vt_foreach_cloptr(xs, lam(x) => fwork(x))
end // end of [let]
//
end // end of [theDB_initize]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)
//
fun
myentry_make_nil
(
// argmentless
) : myentry = let
  reassume myentry_type
in
  gvhashtbl_make_nil(16)
end // end of [myentry_make_nil]
//
(* ****** ****** *)
//
val () = theDB_initize()
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
(*
val txts =
parsing_from_stdin()
val ((*void*)) =
atextlst_topeval(stdout_ref, txts)
*)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mylib_atexting.dats] *)
