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

viewtypedef
stringlst_vt = List_vt (string)
viewtypedef
declitemlst_vt = List_vt (declitem)

(* ****** ****** *)

local

staload SYM = "src/pats_symbol.sats"

in // in of [local]

implement
declname_find_synopsis
  (stadyn, name) = let
//
val sym =
  $SYM.symbol_make_string (name)
val xs = theDeclrepLst_get ()
val opt = $LSYN.declreplst_find_synop (xs, sym)
//
in
//
case+ opt of
| ~Some_vt (synop) =>
    $LSYN.charlst_pats2xhtmlize_bground (0(*sta*), synop)
| ~None_vt () =>
    sprintf ("Synopsis for [%s] is unavailable.", @(name))
  (* end of [None_vt] *)
//
end // end of [declname_find_synopsis]

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
  val () = theDeclname_set (name)
  val str = sprintf ("<h2><a id=\"%s\">%s</a></h2>\n", @(name, name))
in
  $LDOC.atext_strptr (str)
end // end of [aux_name]

fn aux_synop () = let
  val head =
    atext_apptxt2 (H3 ("Synopsis"), atext_newline())
  // end of [val]
  val name = theDeclname_get ()
  val synop = declname_find_synopsis (0(*sta*), name)
  val synop1 = $UN.castvwtp1 {string} (synop)
  val synop2 = sprintf ("<pre class=\"patsyntax\">\n%s</pre>\n", @(synop1))
  val () = strptr_free (synop)
in
  atext_apptxt2 (head, atext_strptr (synop2))
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
  fun aux (xs: paramaddlst_vt): atext =
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
         val li_rest = aux (xs)
       in
         atext_apptxt2 (li_one, li_rest)
       end
    | ~list_vt_nil () => atext_nil ()
  // end of [aux]
in
  aux (theParamaddLst_get ())
end // end of [val]
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

in // in of [local]

implement
theDeclitemLst_make_content () = let
//
fun aux (
  x: declitem
) : atext = let
in
//
case+ x of
//
| DITMname (name) => aux_name (name)
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
fun auxlst (
  xs: declitemlst_vt, i: int
) : atextlst = let
in
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val y = aux (x)
      val ys = auxlst (xs, i+1)
      val res = list_cons {atext} (y, ys)
      val sep = (
        if i > 0 then (
          case+ x of DITMname _ => true | _ => false
        ) else false
      ) : bool // end of [val]
    in
      if sep then list_cons (HR(1), res) else res
    end // end of [list_vt_cons]
  | ~list_vt_nil () => list_nil ()
end // end of [auxlst]
//
val itms =
  theDeclitemLst_get ()
val txts = auxlst (itms, 0)
//
in
  atext_concatxt (txts)
end // end of [theDeclitemLst_make_content]

end // end of [local]

(* ****** ****** *)

(* end of [htmlgendecl.dats] *)
