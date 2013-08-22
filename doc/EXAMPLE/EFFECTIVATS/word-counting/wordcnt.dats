//
// Ordering words according to the numbers
// of their occurrences of in a given file
//

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/linhashtbl_chain.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun fileref_get_word (inp: FILEref): Stropt0
implement
fileref_get_word
  (inp) = let
//
vtypedef
charlst = List0_vt(char)
//
fnx loop
(
  inp: FILEref
) : charlst = let
  val i = fileref_getc (inp)
in
//
if i >= 0 then let
  val c = int2char0 (i)
in
  if isalpha (c) then
    loop2 (inp, cons_vt{char}(c, nil_vt))
  else loop (inp)
end else list_vt_nil((*void*))
//
end // end of [loop]

and loop2
(
  inp: FILEref, res: charlst
) : charlst = let
  val i = fileref_getc (inp)
in
  if isalpha (i) then let
    val res = cons_vt{char}(int2char0(i), res)
  in
    loop2 (inp, res)
  end else res // end of [if]
end // end of [loop2]
//
val cs = loop (inp)
val cs2 = $UN.castvwtp1{List0(charNZ)}(cs)
val opt =
(
case+ cs2 of
| cons _ =>
    strnptr2stropt(string_make_rlist (cs2))
| nil () => stropt_none ()
) : Stropt // end of [val]
//
val () = list_vt_free (cs)
//
in
  opt
end // end of [fileref_get_word]

(* ****** ****** *)

abstype wordcnt_type = ptr
typedef wordcnt = wordcnt_type

extern
fun wordcnt_make (string, int): wordcnt
extern
fun wordcnt_get_cnt (wc: wordcnt): int
extern
fun wordcnt_get_word (wc: wordcnt): string

extern
fun compare_wc_wc : (wordcnt, wordcnt) -<0> int
overload compare with compare_wc_wc

extern
fun fprint_wordcnt (out: FILEref, wc: wordcnt): void
overload fprint with fprint_wordcnt

(* ****** ****** *)

local

datatype
wordcnt = WC of (string, int)
assume wordcnt_type = wordcnt

in (* in of [local] *)

implement
wordcnt_make (w, c) = WC (w, c)

implement
wordcnt_get_cnt
  (wc) = let val+WC (str, cnt) = wc in cnt
end // end of [wordcnt_get_cnt]

implement
wordcnt_get_word
  (wc) = let val+WC (str, cnt) = wc in str
end // end of [wordcnt_get_word]

implement
compare_wc_wc
  (wc1, wc2) = let
  val WC (w1, c1) = wc1
  val WC (w2, c2) = wc2
  val sgn1 = compare (c1, c2)
in
  if sgn1 != 0 then sgn1 else compare (w2, w1)
end // end of [compare_wc_wc]

implement
fprint_wordcnt (out, wc) =
  let val WC (w, c) = wc in fprint! (out, w, "->", c) end
// end of [fprint_wordcnt]

end // end of [local]

(* ****** ****** *)

implement
fprint_val<wordcnt> = fprint_wordcnt

(* ****** ****** *)

absvtype wctable_vtype = ptr
vtypedef wctable = wctable_vtype

extern
fun wctable_make (): wctable
extern
fun wctable_add (tbl: !wctable, w: string): void
extern
fun wctable_listize (tbl: wctable): List_vt (wordcnt)

extern
fun fprint_wctable (out: FILEref, tbl: !wctable): void
overload fprint with fprint_wctable

(* ****** ****** *)

local

staload
LHT = "libats/SATS/linhashtbl_chain.sats"

assume
wctable_vtype = $LHT.hashtbl (string, int)

#define H0 i2sz(1024)

in (* in of [local] *)

implement
wctable_make () =
   $LHT.hashtbl_make_nil<string,int> (H0)
// end of [wctable_make]

implement
wctable_add (tbl, w) = let
//
val cp =
$LHT.hashtbl_search_ref (tbl, w)
//
in
//
if cptr2ptr(cp) > 0 then {
  val (
    pf, fpf | p
  ) = $UN.cptr_vtake (cp)
  val () = !p := !p + 1
  prval () = fpf (pf)
} else {
  val () = $LHT.hashtbl_insert_any (tbl, w, 1)
} (* end of [if] *)
//
end // end of [wctable_add]

implement
wctable_listize (tbl) = let
//
implement
$LHT.hashtbl_flistize$fopr<string,int><wordcnt> (w, c) = wordcnt_make (w, c)
//
in
  $LHT.hashtbl_flistize<string,int><wordcnt> (tbl)
end // end [wctable_lisize]

implement
fprint_wctable (out, tbl) = $LHT.fprint_hashtbl (out, tbl)

end // end of [local]

(* ****** ****** *)

extern
fun fileref_wordcnt
  (inp: FILEref, tbl: !wctable): void
implement
fileref_wordcnt
  (inp, tbl) = let
//
val opt = fileref_get_word (inp)
val issome = stropt_is_some (opt)
//
in
  if issome then let
    val str = stropt_unsome (opt)
    val ((*none*)) = wctable_add (tbl, str)
  in
    fileref_wordcnt (inp, tbl)
  end else () // end of [if]
//  
end // end of [fileref_wordcnt]

(* ****** ****** *)

implement
main0 () =
{
//
val inp = stdin_ref
//
val tbl = wctable_make ()
//
val () = fileref_wordcnt (inp, tbl)
//
val wcs = wctable_listize (tbl)
//
local
implement
list_vt_mergesort$cmp<wordcnt> (wc1, wc2) = ~compare (wc1, wc2)
in (* in of [local] *)
val wcs = list_vt_mergesort (wcs)
end // end of [local]
//
(*
val () = fprint (stdout_ref, "wcs(sorted) =\n")
*)
val () = fprint_list_vt_sep (stdout_ref, wcs, "\n")
val () = fprint_newline (stdout_ref)
//
val () = list_vt_free (wcs)
//
} // end of [main0]

(* ****** ****** *)

(* end of [word-counting.dats] *)
