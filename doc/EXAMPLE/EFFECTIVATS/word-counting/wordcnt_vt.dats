//
// Ordering words according to the numbers
// of their occurrences of in a given file
//

(* ****** ****** *)
//
// HX-2013-08: this is a memory-clean implemenation
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload _ = "libats/DATS/hashfun.dats"
staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/hashtbl_chain.dats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

absvtype wcmap_vtype = ptr
vtypedef wcmap = wcmap_vtype

(* ****** ****** *)

extern fun word_get (): Strptr0

(* ****** ****** *)

extern fun wcmap_create (): wcmap
extern fun wcmap_incby1 (map: !wcmap, w: Strptr1): void
extern fun wcmap_listize (map: wcmap): List0_vt @(Strptr1, int)

(* ****** ****** *)

extern fun WordCounting (): wcmap

(* ****** ****** *)

implement
WordCounting () = let
//
fun loop
  (map: !wcmap): void = let
//
val str = word_get ()
val isnot = strptr_isnot_null (str)
//
in
  if isnot then let
    val () = wcmap_incby1 (map, str) in loop (map)
  end else let
    prval () = strptr_free_null (str) in // nothing
  end (* end of [if] *)
end // end of [loop]
//
val map = wcmap_create ()
val ((*void*)) = loop (map)
//
in
  map
end // end of [WordCounting]

(* ****** ****** *)

extern fun char_get (): int

(* ****** ****** *)

implement
word_get () = let
//
vtypedef
charlst = List0_vt(char)
//
fnx loop
(
// argmentless
) : charlst = let
  val i = char_get ()
in
//
if i >= 0 then
(
  if isalpha (i) then
    loop2 (cons_vt{char}(int2char0(i), nil_vt))
  else loop () // end of [if]
) else nil_vt((*void*))
//
end // end of [loop]

and loop2
(
  res: charlst
) : charlst = let
  val i = char_get ()
in
  if isalpha (i) then
    loop2 (cons_vt{char}(int2char0(i), res)) else res
  // end of [if]
end // end of [loop2]
//
val cs = loop ()
//
in
//
case+ cs of
| cons_vt _ => let
    val str =
      string_make_rlist ($UN.castvwtp1{List0(charNZ)}(cs))
    val () = list_vt_free (cs)
  in
    strnptr2strptr (str)
  end // end of [cons_vt]
| ~nil_vt () => strptr_null ((*none*))
//
end // end of [word_get]

(* ****** ****** *)

local

#define H0 i2sz(1024)

staload
LHT = "libats/SATS/hashtbl_chain.sats"

assume
wcmap_vtype = $LHT.hashtbl (string, int)

in (* in of [local] *)

implement
wcmap_create () = $LHT.hashtbl_make_nil<string,int> (H0)

implement
wcmap_incby1 (tbl, w) = let
//
local
val w1 = $UN.strptr2string(w)
in(*in of [local]*)
val cp = $LHT.hashtbl_search_ref (tbl, w1)
end(*in of [local]*)
//
val isnot = cptr2ptr(cp) > (0)
//
in
//
if isnot then {
  val () = strptr_free (w)
  val (pf, fpf | p) = $UN.cptr_vtake (cp)
  val () = !p := !p + 1
  prval () = fpf (pf)
} else {
  val w = strptr2string (w)
  val () = $LHT.hashtbl_insert_any (tbl, w, 1)
} (* end of [if] *)
//
end // end of [wcmap_incby1]

implement
wcmap_listize (tbl) = let
//
vtypedef wc = @(Strptr1, int)
//
val wcs = $LHT.hashtbl_listize<string,int> (tbl)
//
in
  $UN.castvwtp0{List0_vt(wc)}(wcs)
end // end [wcmap_lisize]

end // end of [local]

(* ****** ****** *)

local

staload STDIO = "libc/SATS/stdio.sats"

in (* in of [local] *)

implement char_get () = $STDIO.getchar0 ()

end // end of [local]

(* ****** ****** *)

implement
main0 () =
{
//
val map = WordCounting ()
val wcs = wcmap_listize (map)
//
// for sorting the results
//
vtypedef ki = @(Strptr1, int)
//
local
implement
list_vt_mergesort$cmp<ki>
  (wc1, wc2) = let
  val sgn1 = compare (wc2.1, wc1.1)
in
  if sgn1 != 0 then sgn1 else compare (wc1.0, wc2.0)
end // end of [cmp]
in (*in of [local]*)
val wcs = list_vt_mergesort<ki> (wcs)
end // end of [local]
//
val n = list_vt_length (wcs)
val n2 = min (n, 500)
val (wcs1, wcs2) = list_vt_split_at (wcs, n2)
//
// for listing the top 100
// most frequently encountered words
//
local
fun fprint_wordcnt
  (out: FILEref, wc: &ki): void = fprint! (out, wc.0, "\t->\t", wc.1)
overload fprint with fprint_wordcnt
implement(env)
list_vt_iforeach$fwork<ki><env> (i, wc, env) = fprintln! (stdout_ref, i+1, ".\t", wc)
in (*in of [local]*)
val _(*len*) = list_vt_iforeach<ki> (wcs1)
end // end of [local]
//
val () = fprint_newline (stdout_ref)
//
local
implement
list_vt_freelin$clear<ki> (wc) = strptr_free (wc.0)
in (* in of [local] *)
val () = list_vt_freelin (wcs1)
val () = list_vt_freelin (wcs2)
end // end of [local]
//
} // end of [main0]

(* ****** ****** *)

(* end of [wordcnt_vt.dats] *)
