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

abstype wordcnt_type = ptr
typedef wordcnt = wordcnt_type

absvtype wcmap_vtype = ptr
vtypedef wcmap = wcmap_vtype

(* ****** ****** *)

extern
fun fileref_get_word (inp: FILEref): Stropt0

(* ****** ****** *)

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

extern
fun wcmap_make (): wcmap
extern
fun wcmap_add (tbl: !wcmap, w: string): void
extern
fun wcmap_listize (tbl: wcmap): List0_vt (wordcnt)
extern
fun fprint_wcmap (out: FILEref, tbl: !wcmap): void
overload fprint with fprint_wcmap

(* ****** ****** *)

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
    loop2 (inp, cons_vt{char}(tolower(c), nil_vt))
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

local

staload
LHT = "libats/SATS/linhashtbl_chain.sats"

assume
wcmap_vtype = $LHT.hashtbl (string, int)

#define H0 i2sz(1024)

in (* in of [local] *)

implement
wcmap_make () =
   $LHT.hashtbl_make_nil<string,int> (H0)
// end of [wcmap_make]

implement
wcmap_add (tbl, w) = let
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
end // end of [wcmap_add]

implement
wcmap_listize (tbl) = let
//
implement
$LHT.hashtbl_flistize$fopr<string,int><wordcnt> (w, c) = wordcnt_make (w, c)
//
in
  $LHT.hashtbl_flistize<string,int><wordcnt> (tbl)
end // end [wcmap_lisize]

implement
fprint_wcmap (out, tbl) = $LHT.fprint_hashtbl (out, tbl)

end // end of [local]

(* ****** ****** *)

extern
fun fileref_counting
  (inp: FILEref, tbl: !wcmap): void
implement
fileref_counting (inp, tbl) = let
//
val opt = fileref_get_word (inp)
val issome = stropt_is_some (opt)
//
in
  if issome then let
    val str = stropt_unsome (opt)
    val ((*none*)) = wcmap_add (tbl, str)
  in
    fileref_counting (inp, tbl)
  end else () // end of [if]
//  
end // end of [fileref_counting]

(* ****** ****** *)

local

datatype
wordcnt = WC of (string, int)
assume wordcnt_type = wordcnt

in (* in of [local] *)

implement
wordcnt_make (w, c) = WC (w, c)

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
  let val WC (w, c) = wc in fprint! (out, w, "\t->\t", c) end
// end of [fprint_wordcnt]

end // end of [local]

(* ****** ****** *)

implement
fprint_val<wordcnt> = fprint_wordcnt

(* ****** ****** *)

implement
main0 () =
{
//
val inp = stdin_ref
//
val tbl = wcmap_make ()
//
val () = fileref_counting (inp, tbl)
//
val wcs = wcmap_listize (tbl)
//
local
implement
list_vt_mergesort$cmp<wordcnt> (wc1, wc2) = ~compare (wc1, wc2)
in (* in of [local] *)
val wcs = list_vt_mergesort (wcs)
end // end of [local]
//
val n = list_vt_length (wcs)
val n2 = min (100, n)
//
val wcs2 = list_take ($UN.list_vt2t(wcs), n2)
val () = list_vt_free (wcs)
val () = fprint_list_vt_sep (stdout_ref, wcs2, "\n")
val () = fprint_newline (stdout_ref)
//
val () = list_vt_free (wcs2)
//
} // end of [main0]

(* ****** ****** *)

(* end of [wordcnt2.dats] *)
