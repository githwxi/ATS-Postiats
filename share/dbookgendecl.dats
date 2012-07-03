(*
** dbookgendecl:
** For generating docbook files describing declarations
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "declatext.sats"
staload "dbookgendecl.sats"

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
| ~Some_vt (synop) => let
    typedef charlst = List (char)
    val n = list_length (synop)
    val sbf = string_make_list_int (synop, n)
  in
    strptr_of_strbuf (sbf)
  end // end of [Some_vt]
| ~None_vt () =>
    sprintf ("Synopsis for [%s] is unavailable.", @(name))
  (* end of [None_vt] *)
//
end // end of [declname_find_synopsis]

end // end of [local]

(* ****** ****** *)

#include "utils/atsdoc/HATS/xhtmlatxt.hats"

(* ****** ****** *)

local

fn aux_name
  (name: string): atext = let
  val () = theDeclname_set (name)
  val str = sprintf ("<section id=\"%s\">", @(name))
  val t1 = atext_strptr (str)
  val str = sprintf ("<title>%s</title>\n", @(name))
  val t2 = atext_strptr (str)
in
  atext_apptxt2 (t1, t2)
end // end of [aux_name]

fn aux_synop () = let
  val name = theDeclname_get ()
  val synop = declname_find_synopsis (0(*sta*), name)
  val _beg = atext_strcst "<formalpara>"
  val _end = atext_strcst "</formalpara>\n"
  val _title = atext_strcst "<title>Synopsis</title>\n"
  val _synop = let
    val t0 =
      atext_strcst "<para><programlisting><![CDATA[\n"
    val t1 = atext_strcst "]]></programlisting></para>\n"
  in
    atext_apptxt3 (t0, atext_strptr (synop), t1)
  end // end of [val]
in
  atext_apptxt3 (_beg, atext_apptxt2 (_title, _synop), _end)
end // end of [aux_synop]

fn aux_synop2
  (synop: string) = let
  val _beg = atext_strcst "<formalpara>"
  val _end = atext_strcst "</formalpara>\n"
  val _title = atext_strcst "<title>Synopsis</title>\n"
  val _synop = atext_strsub (synop)
in
  atext_apptxt3 (_beg, atext_apptxt2 (_title, _synop), _end)
end // end of [aux_synop2]

fn aux_descrpt (cntnt) = let
  val _beg = atext_strcst "<formalpara>"
  val _end = atext_strcst "</formalpara>\n"
  val _title = atext_strcst "<title>Description</title>\n"
  val _cntnt = let
    val t0 = atext_strcst "<para>"
    val t1 = atext_strcst "</para>\n"
  in
    atext_apptxt3 (t0, atext_strsub (cntnt), t1)
  end
in
  atext_apptxt3 (_beg, atext_apptxt2 (_title, _cntnt), _end)
end // end of [aux_descrpt]

fn aux_example (cntnt) = let
  val _beg = atext_strcst "<formalpara>"
  val _end = atext_strcst "</formalpara>\n"
  val _title = atext_strcst "<title>Example</title>\n"
  val _cntnt = let
    val t0 = atext_strcst "<para>"
    val t1 = atext_strcst "</para>\n"
  in
    atext_apptxt3 (t0, atext_strsub (cntnt), t1)
  end
in
  atext_apptxt3 (_beg, atext_apptxt2 (_title, _cntnt), _end)
end // end of [aux_example]

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
end // end of [aux]
fun auxlst (
  xs: declitemlst_vt, i: int
) : atextlst = let
in
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val y = aux (x)
      val isname = (case+ x of
        | DITMname _ => true | _ => false
      ) : bool // end of [val]
      val isname2 = (
        if i > 0 then isname else false
      ) : bool // end of [val]
      val i = (if isname then i + 1 else i): int
      val ys = auxlst (xs, i)
      val res = list_cons {atext} (y, ys)
    in
      if isname2 then let
        val sep = atext_strcst "</section>\n\n"
      in
        list_cons {atext} (sep, res)
      end else res // end of [if]
    end // end of [list_vt_cons]
  | ~list_vt_nil () => let
      val sep = (
        if i > 0 then atext_strcst "</section>\n\n" else atext_nil ()
      ) : atext // end of [val]
    in
      list_sing (sep)
    end // end of [list_vt_nil]
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

(* end of [dbookgendecl.dats] *)
