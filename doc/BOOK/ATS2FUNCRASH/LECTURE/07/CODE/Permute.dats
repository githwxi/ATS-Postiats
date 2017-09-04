(* ****** ****** *)
(*
** Permute
*)
(* ****** ****** *)
(*
##myatsccdef=\
patsopt -d $1 | atscc2js -o $fname($1)_dats.js -i -
*)
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"Permute__dynload"
//
#define
ATS_STATIC_PREFIX "Permute__"
//
(* ****** ****** *)
//
// HX: for accessing LIBATSCC2JS 
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib\
/libatscc2js/ATS2-0.3.2" // latest stable release
//
#include
"{$LIBATSCC2JS}/staloadall.hats" // for prelude stuff
#staload
"{$LIBATSCC2JS}/SATS/print.sats" // for print into a store
//
(* ****** ****** *)
//
#include
"./../../MYLIB/mylib.dats"
//
(* ****** ****** *)
//
abstype xmldoc
//
%{^
//
function
document_getElementById
  (id)
{
  return document.getElementById(id);
}
//
function
xmldoc_set_innerHTML
  (xmldoc, text)
  { xmldoc.innerHTML = text; return; }
//
%} // end of [%{^] 
//
extern
fun
document_getElementById
  (id: string): xmldoc = "mac#"
//
extern
fun
xmldoc_set_innerHTML
(xmldoc, text: string): void = "mac#"
//
(* ****** ****** *)
//
fun
{a:t@ype}
list0_permute
(xs: list0(a)): list0(list0(a)) =
(
case+ xs of
| list0_nil() =>
  list0_cons(nil0(), nil0())
| list0_cons _ => let
    typedef xs = list0(a)
    typedef out = list0(xs)
    typedef inp = $tup(xs, xs)
  in
    list0_concat<xs>
    (
     list0_map<inp><out>
     ( list0_nchoose_rest<a>(xs, 1)
     , lam($tup(ys, zs)) => list0_mapcons<a>(ys[0], list0_permute<a>(zs))
     )
    ) (* list0_concat *)
  end (* end of [list0_cons] *)
)
//
(* ****** ****** *)
//
extern
fun
funarg1_get(): int = "mac#"
//
%{^
function
funarg1_get()
{
  return parseInt(document.getElementById("funarg1").value);
}
%} (* end of [%{^] *)
//
(* ****** ****** *)
//
extern
fun
Permute__evaluate
  ((*void*)): void = "mac#"
//
(* ****** ****** *)

implement
Permute__evaluate
  ((*void*)) = let
  val () =
  the_print_store_clear()
  val arg = funarg1_get()
  val res = list0_permute<int>(list0_make_intrange(0, arg))
  val () =
  println!("Permute(", arg, "):")
//
  val () =
  list0_foreach<list0(int)>
  ( res
  , lam(xs) =>
    (
    print("(");
    list0_iforeach
    ( xs
    , lam(i, x) => (if i > 0 then print ", "; print x));
    println!(")")
    ) (* list0_iforeach *)
  )
//
  val theOutput =
    document_getElementById("theOutput")
  // end of [val]
//
in
  xmldoc_set_innerHTML(theOutput, the_print_store_join())
end // end of [Permute__evaluate]

(* ****** ****** *)

%{$
//
function
Permute__initize()
{
//
Permute__dynload(); return;
//
} // end of [Permute_initize]
%}

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){Permute__initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Permute.dats] *)
