(*
** htmlgendecl:
** For generating html file describing declarations
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

local

fn HR (sz: int): atext = let
  val str = sprintf (
    "<hr style=\"background-color: #E0E0E0; height: %ipx;\"></hr>", @(sz)
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
  val head = atext_apptxt2
    (H3 ("Synopsis"), atext_newline)
  val name = theDeclname_get ()
  val synop = declname_find_synopsis (0(*sta*), name)
  val synop1 = $UN.castvwtp1 {string} (synop)
  val synop2 = sprintf ("<pre class=\"patsyntax\">\n%s</pre>\n", @(synop1))
  val () = strptr_free (synop)
in
  atext_apptxt2 (head, atext_strptr (synop2))
end // end of [aux_synop]

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
| DITMname (name) => aux_name (name)
//
| DITMsynopsis () => aux_synop ((*void*))
| DITMsynopsis2
    (synop) => let
    val head = atext_apptxt2
      (H3 ("Synopsis"), atext_newline)
  in
    atext_apptxt2 (head, atext_strsub (synop))
  end // end of [DITMsynopsis2]
//
| DITMnamesynop (name) => let
    val res1 = aux_name (name)
    val res2 = aux_synop ((*void*))
  in
    atext_apptxt2 (res1, res2)
  end // end of [DITMnamesynop]
//
| DITMdescript
    (descript) => let
    val head = atext_apptxt2
      (H3 ("Description"), atext_newline)
  in
    atext_apptxt2 (head, atext_strsub (descript))
  end // end of [DITMdescript]
//
| DITMexample
    (example) => let
    val head =
      atext_apptxt2 (H3 ("Example"), atext_newline)
    // end of [val]
  in
    atext_apptxt2 (head, atext_strsub (example))
  end // end of [DITMexample]
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
val xs = theDeclitemLst_get ()
val ys = auxlst (xs, 0)
//
in
  atext_concatxt (ys)
end // end of [theDeclitemLst_make_menu]

end // end of [local]

(* ****** ****** *)

(* end of [htmlgendecl.dats] *)
