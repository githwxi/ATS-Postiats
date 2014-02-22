(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
STDLIB = "libc/SATS/stdlib.sats"
staload
_(*STDLIB*) = "libc/DATS/stdlib.dats"
//
(* ****** ****** *)

staload "libats/SATS/stringbuf.sats"
staload _ = "libats/DATS/stringbuf.dats"

(* ****** ****** *)

staload "./falcon.sats"
staload "./falcon_tokener.dats"

(* ****** ****** *)

extern
fun
gene_read
  (inp: &string >> ptr): Strptr1
implement
gene_read (inp) = let
//
fun skipWS
  (p: ptr): ptr = let
  val c =
  $UN.ptr0_get<char> (p)
in
  if isspace (c) then skipWS (ptr_succ<char> (p)) else p
end // end of [skipWS]
//
fun skipID
  (p: ptr): ptr = let
  val c =
  $UN.ptr0_get<char> (p)
  val i = char2u2int0 (c)
in
  if i > 0 then
    if test_ide1 (i) then skipID (ptr_succ<char> (p)) else p
  else (p) // end of [if]
end // end of [skipID]
//
val p0 =
  string2ptr(inp)
//
val p1 = skipWS(p0)
val p2 = skipID(p1)
val () = inp := p2
//
val [ln:int] ln = $UN.cast{Size}(p2-p1)
//
val res =
string_make_substring
  ($UN.cast{stringGte(ln)}(p1), i2sz(0), ln)
prval () = lemma_strnptr_param (res)
//
in
  strnptr2strptr(res)
end // end of [gene_read]

(* ****** ****** *)

extern
fun
mean_read
  (inp: &string >> ptr): double
implement
mean_read
  (inp) = let
  val str = inp
  prval () = topize (inp) in $STDLIB.strtod1 (str, inp)
end // end of [mean_read]

(* ****** ****** *)

extern
fun
stdev_read
  (inp: &string >> ptr): double
implement
stdev_read
  (inp) = let
  val str = inp
  prval () = topize (inp) in $STDLIB.strtod1 (str, inp)
end // end of [stdev_read]

(* ****** ****** *)

extern
fun gmeanvar_read
  (line: string, emap: GDMap, smap: GDMap): void

(* ****** ****** *)

local

(* ****** ****** *)

typedef key = gene and itm = double

(* ****** ****** *)

implement
gequal_val<key> (x1, x2) = (compare (x1, x2) = 0)

(* ****** ****** *)
//
staload "libats/ML/SATS/hashtblref.sats"
//
implement
hash_key<key> (x) = $effmask_all(gene_hash(x))
//
(* ****** ****** *)
//
staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/hashtbl_chain.dats"
staload _ = "libats/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)

assume GDMap_type = hashtbl (key, itm)

(* ****** ****** *)

in (* in-of-local *)

(* ****** ****** *)

implement
GDMap_find
  (map, gn, res) = let
//
val p = hashtbl_search_ref<key,itm> (map, gn)
//
in
//
if isneqz(p) then let
  val (pf, fpf | p) = $UN.cptr_vtake (p)
  val () = res := !p
  prval () = fpf (pf)
  prval () = opt_some{itm}(res) in true
end else let
  prval () = opt_none{itm}(res) in false
end // end of [if]
//
end // end of [GDMap_find]

(* ****** ****** *)

implement
GDMap_insert (map, gn, gval) =
  hashtbl_insert_any<key,itm> (map, gn, gval)

(* ****** ****** *)

implement
gmeanvar_read
  (line, emap, smap) = let
//
var nerr: int = 0
//
var line: string = line
val line0 = string2ptr(line)
val gene = gene_read (line)
val () =
if line = line0 then nerr := nerr + 1
//
val line0 = line
val () = line := $UN.cast{string}(line)
val mean = mean_read (line)
val () =
if line = line0 then nerr := nerr + 1
//
val line0 = line
val () = line := $UN.cast{string}(line)
val stdev = stdev_read (line)
val () =
if line = line0 then nerr := nerr + 1
//
val gene = gene_make_name(strptr2string(gene))
//
(*
val () =
if nerr = 0 then println! ("gmeanvar_read: ", gene, " -> ", mean)
val () =
if nerr = 0 then println! ("gmeanvar_read: ", gene, " -> ", stdev)
*)
//
val () =
if nerr = 0 then GDMap_insert (emap, gene, mean)
val () =
if nerr = 0 then GDMap_insert (smap, gene, stdev)
//
in
  // nothing
end // end of [gmeanvar_read]

(* ****** ****** *)

implement
gmeanvar_initize (inp) = let
//
fun loop
(
  sbf: !stringbuf, emap: GDMap, smap: GDMap
) : void = let
//
var last: char = '\000'
val nget = stringbuf_insert_fgets (sbf, inp, last)
//
in
//
if nget > 0 then let
  val (fpf | str) = stringbuf_get_strptr (sbf)
  val () = gmeanvar_read ($UN.strptr2string(str), emap, smap)
  prval () = fpf (str)
  val-true = stringbuf_truncate (sbf, i2sz(0))
in
  loop (sbf, emap, smap)
end else ((*void*)) // end of [if]
//
end // end of [loop]
//
val sbf = stringbuf_make_nil (i2sz(1024))
val emap = hashtbl_make_nil<key,itm> (i2sz(1024))
val smap = hashtbl_make_nil<key,itm> (i2sz(1024))
val ((*void*)) = loop (sbf, emap, smap)
val ((*freed*)) = stringbuf_free (sbf)
//
in
  (emap, smap)
end // end of [gmeanvar_initize]

end // end of [local]

(* ****** ****** *)

(* end of [falcon_gmeanvar.dats] *)
