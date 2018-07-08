(* ****** ****** *)
(*
//
For mylib of ATS2FUNCRASH
//
*)
(* ****** ****** *)
//
#define
ATEXTING_targetloc
"$PATSHOME/utils/atexting"
#define
LIBATSREC_targetloc
"$PATSHOME/utils/libatsrec"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSREC}/mylibies.hats"
#include
"{$LIBATSREC}/mylibies_link.hats"
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

val () = the_nsharp_set(2)

(* ****** ****** *)

fun
html_print
(cs: string): void = let
//
fun
charpr(c: char): void =
(
ifcase
//
| c = '<' => print("&lt;")
| c = '>' => print("&gt;")
//
| _(*else*) => print_char(c)
//
)
//
in
string_foreach(cs, lam(c) => charpr(c))
end // end of [html_print]

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
//
local
//
typedef
key = string and itm = myentry
//
implement
fprint_val<myentry>
(out, x0) =
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
} (* end of [theDB_insert] *)
//
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
(x0: myentry): void = let
//
val gv = x0["name"]
//
val () = 
fprintln!
(stderr_ref, "fwork: gv = ", gv)
//
in
case+ gv of
| GVstring(key) =>
  (
    theDB_insert(key, x0)
  )
| _(*non-GVstring*) => () where
  {
(*
    val () =
    fprintln! (stderr_ref, "fwork: x0 = ", x0)
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

local
//
macdef
uns(x) =
GVstring_uncons(,(x))
//
reassume myentry_type
//
(* ****** ****** *)

fun
__interface__
(
l0: location
,
xs: atextlst
) : atext = res where
{
//
val-
cons0(x0, _) = xs
//
val x0 = atext_strngfy(x0)
val-
~Some_vt(ent) = theDB_search(x0)
//
val () =
print!("extern\n")
val () =
print!(uns(ent["interface"]))
//
val res = atext_make_nil(l0)
//
} (* end of [__interface__] *)

fun
__implement__
(
l0: location
,
xs: atextlst
) : atext = res where
{
//
val-
cons0(x0, _) = xs
//
val x0 = atext_strngfy(x0)
val-
~Some_vt(ent) = theDB_search(x0)
//
val () =
print!(uns(ent["implement"]))
//
val res = atext_make_nil(l0)
//
} (* end of [__implement__] *)

(* ****** ****** *)

fun
__html_dynfun__
(
l0: location
,
xs: atextlst
) : atext = res where
{
//
val-
cons0(x0, _) = xs
//
val x0 = atext_strngfy(x0)
val-
~Some_vt(ent) = theDB_search(x0)
//
val () =
print!("\
<div
 style=\"margin-top:20px;margin-bottom:20px\">\n")
//
val () =
print!("<center>\n")
val () =
print!
("<dynfun>", x0, "</dynfun>\n")
val () =
print!("</center>\n")
//
val () =
print!("\
<h2>Interface</h2>\n")
val () =
print!("<sats2xhtml>")
val () =
html_print(uns(ent["interface"]))
val () = println!("</sats2xhtml>")
//
val () =
print!("\
<h2>Implementation</h2>\n")
val () =
print!("<dats2xhtml>")
val () =
html_print(uns(ent["implement"]))
val () = println!("</dats2xhtml>")
//
val () =
print!("\
<h2>Description</h2>\n")
val () =
print!("<description>")
val () =
println!(uns(ent["description"]))
val () = println!("</description>")
//
val () = println!("</div>")
//
val ((*separator*)) = println!("<hr></hr>")
//
val res = atext_make_nil(l0)
//
} (* end of [__html_dynfun__] *)

(* ****** ****** *)

in (* in-of-local *)

(* ****** ****** *)

val () =
the_atextmap_insert
(
"interface"
,
TEXTDEFfun(lam(loc, xs) => __interface__(loc, xs))
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
(
"implement"
,
TEXTDEFfun(lam(loc, xs) => __implement__(loc, xs))
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
(
"html_dynfun"
,
TEXTDEFfun(lam(loc, xs) => __html_dynfun__(loc, xs))
) (* the_atextmap_insert *)

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
  gvhashtbl_make_nil(10)
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
val atxts =
parsing_from_stdin()
val ((*void*)) =
atextlst_topeval(stdout_ref, atxts)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mylib_atexting.dats] *)
