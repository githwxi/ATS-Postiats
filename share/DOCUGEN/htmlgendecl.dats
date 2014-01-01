(*
** htmlgendecl:
** For generating html files describing declarations
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "declatext.sats"
staload "htmlgendecl.sats"

(* ****** ****** *)

#define
ATSCODEROOT "http://www.ats-lang.org/DOCUMENT/ATS-Postiats"

implement
myatscodelink
  (codepath, linkname) = let
//
val res = sprintf
(
  "<a href=\"%s/%s\">%s</a>", @(ATSCODEROOT, codepath, linkname)
) // end of [val]
//
in
  $LDOC.atext_strptr (res)
end // end of [myatscodelink]

(* ****** ****** *)

viewtypedef
stringlst_vt = List_vt (string)
viewtypedef
declitemlst_vt = List_vt (declitem)

(* ****** ****** *)

local

typedef charlst = List (char)
staload SYM = "src/pats_symbol.sats"

fun auxlst
(
  stadyn: int, css: List_vt (charlst), i: int
) : List_vt (strptr1) = let
in
//
case+ css of
| ~list_vt_cons
    (cs, css) => let
    val str =
      $LSYNMK.charlst_pats2xhtmlize_bground (stadyn, cs)
    // end of [val]
    val strlst = auxlst (stadyn, css, i+1)
  in
    list_vt_cons (str, strlst)
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_vt_nil ()
//
end // end of [auxlst]

in (* in of [local] *)

implement
declname_find_synoplst
  (stadyn, name) = let
(*
val (
) = println! ("declname_find_synopsis: stadyn = ", stadyn)
val () = println! ("declname_find_synopsis: name = ", name)
*)
//
val sym =
  $SYM.symbol_make_string (name)
val xs = theDeclrepLst_get ()
val css = $LSYNMK.d0eclreplst_find_synop (xs, sym)
//
in
//
auxlst (stadyn, css, 0)
//
end // end of [declname_find_synoplst]

end // end of [local]

(* ****** ****** *)

implement
theDeclnameLst_make_menu () = let
//
fun aux (
  x: string
) : atext = let
  val str = sprintf ("<li><a href=\"#%s\">%s</a></li>\n", @(x, x))
in
  $LDOC.atext_strptr (str)
end // end of [aux]
fun auxlst (
  xs: stringlst_vt
) : atextlst = let
in
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val y = aux (x); val ys = auxlst (xs)
    in
      list_cons (y, ys)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => list_nil ()
end // end of [auxlst]
//
val xs =
  theDeclnameLst_get ()
val ys = auxlst (xs)
//
in
//
$LDOC.atext_apptxt3 (
  $LDOC.atext_strcst "<menu>\n"
, $LDOC.atext_concatxt (ys)
, $LDOC.atext_strcst "</menu>"
) // end of [atext_apptxt3]
end // end of [theDeclnameLst_make_menu]

(* ****** ****** *)

#include "utils/atsdoc/HATS/xhtmlatxt.hats"

(* ****** ****** *)

datatype paramadd =
  PMADD of (string(*name*), string(*desc*))
// end of [paramadd]

viewtypedef paramaddlst_vt = List_vt (paramadd)

extern
fun theParamaddLst_add (x: paramadd): void
extern
fun theParamaddLst_add2 (name: string, desc: string): void
extern
fun theParamaddLst_get (): paramaddlst_vt

local

val theParamaddLst = ref<paramaddlst_vt> (list_vt_nil)

in

implement
theParamaddLst_add (x) = let
  val (vbox pf | p) = ref_get_view_ptr (theParamaddLst)
in
  !p := list_vt_cons (x, !p)
end // end of [theParamaddLst_add]

implement
theParamaddLst_add2
  (name, desc) = theParamaddLst_add (PMADD (name, desc)) 
// end of [theParamaddLst_add2]

implement
theParamaddLst_get () = let
  val (vbox pf | p) = ref_get_view_ptr (theParamaddLst)
  val xs = !p
  val () = !p := list_vt_nil ()
in
  list_vt_reverse (xs)
end // end of [theParamaddLst_get]

end // end of [local]

(* ****** ****** *)

fun synoplst2atext
(
  name: string, xs: List_vt (strptr1)
) : atext = let
//
fun auxlst
  (xs: List_vt (strptr1)): atextlst = let
in
//
case+ xs of
| ~list_vt_cons (x, xs) => let
    val x1 = $UN.castvwtp1{string}(x)
    val x2 = sprintf ("<pre class=\"patsyntax\">\n%s</pre>\n", @(x1))
    val () = strptr_free (x)
    val atxt = $LDOC.atext_strptr (x2)
    val atxtlst = auxlst (xs)
  in
    list_cons (atxt, atxtlst)
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_nil ()
//
end // end of [auxlst]
//
val atxtlst = auxlst (xs)
//
in
//
case+ atxtlst of
| list_cons _ => $LDOC.atext_concatxt (atxtlst)
| list_nil () => let
    val x = sprintf ("Synopsis for [%s] is unavailable.", @(name))
    val x1 = $UN.castvwtp1{string}(x)
    val x2 = sprintf ("<pre class=\"patsyntax\">\n%s</pre>\n", @(x1))
    val () = strptr_free (x)
  in
    $LDOC.atext_strptr (x2)
  end // end of [list_nil]
//
end // end of [synoplst2atext]

(* ****** ****** *)

local

fn HR (sz: int): atext = let
  val str = sprintf (
    "<hr style=\"background-color: #E0E0E0; height: %ipx;\"></hr>\n", @(sz)
  ) // end of [val]
in
  $LDOC.atext_strptr (str)
end // end of [HR]

fn aux_name
  (name: string): atext = let
(*
  val () = println! ("aux_name: name = ", name)
*)
  val () = theDeclname_set (name)
  val str = sprintf ("<h2><a id=\"%s\">%s</a></h2>\n", @(name, name))
in
  $LDOC.atext_strptr (str)
end // end of [aux_name]

fn aux_name2
  (name: string, href: string): atext = let
(*
  val () = println! ("aux_name2: name = ", name)
  val () = println! ("aux_name2: href = ", href)
*)
  val () = theDeclname_set (name)
  val str = sprintf ("<h2><a id=\"%s\" href=\"%s\">%s</a></h2>\n", @(name, href, name))
in
  $LDOC.atext_strptr (str)
end // end of [aux_name2]

fn aux_synop () = let
(*
val () = println! ("aux_synop")
*)
val head =
  atext_apptxt2 (H3 ("Synopsis"), atext_newline())
// end of [val]
val name = theDeclname_get ()
val strlst = declname_find_synoplst (0(*sta*), name)
val synop = synoplst2atext (name, strlst)
//
in
  atext_apptxt2 (head, synop)
end // end of [aux_synop]

fn aux_synop2 (synop) = let
  val head =
    atext_apptxt2 (H3 ("Synopsis"), atext_newline())
  // end of [val]
in
  atext_apptxt2 (head, atext_strsub (synop))
end // end of [aux_synop2]

fn aux_descrpt (cntnt) = let
  val head =
    atext_apptxt2 (H3 ("Description"), atext_newline())
  // end of [val]
in
  atext_apptxt2 (head, atext_strsub (cntnt))
end // end of [aux_descrpt]

fn aux_example (cntnt) = let
  val head = atext_apptxt2 (H3 ("Example"), atext_newline())
in
  atext_apptxt2 (head, atext_strsub (cntnt))
end // end of [aux_example]

fun aux_paramadd
  (name, desc) = let
  val () = theParamaddLst_add2 (name, desc)
in
  atext_nil ()
end // end of [aux_paramadd]

fun aux_paramlist () = let
//
val head = atext_apptxt2 (H3 ("Parameters"), atext_newline())
//
val ul_beg = atext_strcst "<ul>"
val ul_body = let
//
fun auxlst
  (xs: paramaddlst_vt): atext = let
in
  case+ xs of
  | ~list_vt_cons (x, xs) => let
      val li_beg = atext_strcst "<li>"
      val li_end = atext_strcst "</li>"
      val PMADD (name, desc) = x
      val itm1 = atext_strsub name
      val itm2 = atext_strcst " : "
      val itm3 = atext_strsub desc
      val li_body = atext_apptxt3 (itm1, itm2, itm3)
      val li_one = atext_apptxt3 (li_beg, li_body, li_end)
      val li_rest = auxlst (xs)
    in
      atext_apptxt2 (li_one, li_rest)
    end
  | ~list_vt_nil () => atext_nil ()
end // end of [auxlst]
//
in
  auxlst (theParamaddLst_get ())
end // end of [val]
//
val ul_end = atext_strcst "</ul>"
//
val ul_all = atext_apptxt3 (ul_beg, ul_body, ul_end)
//
in
  atext_apptxt2 (head, ul_all)
end // end of [aux_funretval]

fun aux_funretval (cntnt) = let
  val head = atext_apptxt2 (H3 ("Return Value"), atext_newline())
in
  atext_apptxt2 (head, atext_strsub (cntnt))
end // end of [aux_funretval]

in (* in of [local] *)

implement
theDeclitemLst_make_content () = let
//
fun aux
  (x: declitem): atext = let
in
//
case+ x of
//
| DITMname (name) => aux_name (name)
| DITMname2 (name, href) => aux_name2 (name, href)
//
| DITMsynop () => aux_synop ((*void*))
| DITMsynop2 (synop) => aux_synop2 (synop)
//
| DITMdescrpt (cntnt) => aux_descrpt (cntnt)
//
| DITMexample (cntnt) => aux_example (cntnt)
//
| DITMparamadd
    (name, desc) => aux_paramadd (name, desc)
| DITMparamlist () => aux_paramlist ()
//
| DITMfunretval (cntnt) => aux_funretval (cntnt)
//
end // end of [aux]
//
fun auxlst
(
  xs: declitemlst_vt, i: int
) : atextlst = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val y = aux (x)
    val ys = auxlst (xs, i+1)
    val res = list_cons {atext} (y, ys)
    val sep = (
      if i > 0 then
      (
        case+ x of
        | DITMname _ => true
        | DITMname2 _ => true
        | _(*non-name-entry*) => false
      ) else false
    ) : bool // end of [val]
  in
    if sep then list_cons (HR(1), res) else res
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_nil ()
//
end // end of [auxlst]
//
val itmlst = theDeclitemLst_get ()
//
val atxtlst = auxlst (itmlst, 0(*i*))
//
in
  atext_concatxt (atxtlst)
end // end of [theDeclitemLst_make_content]

end // end of [local]

(* ****** ****** *)

(* end of [htmlgendecl.dats] *)
