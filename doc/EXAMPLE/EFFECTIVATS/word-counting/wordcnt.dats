//
// ordering words according to the numbers
// of their occurrences of in a given file
//

(* ****** ****** *)
//
// HX-2013-08:
// this is largely a functional implementation
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _ = "libats/DATS/hashfun.dats"
staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/hashtbl_chain.dats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/string.sats"

(* ****** ****** *)

staload _ = "libats/ML/DATS/list0.dats"
staload _ = "libats/ML/DATS/string.dats"
staload _ = "libats/ML/DATS/hashtblref.dats"

(* ****** ****** *)

abstype wcmap_type = ptr
typedef wcmap = wcmap_type

(* ****** ****** *)

extern fun word_get (): stropt

(* ****** ****** *)

extern fun wcmap_create (): wcmap
extern fun wcmap_incby1 (map: wcmap, w: string): void
extern fun wcmap_listize (map: wcmap): list0 @(string, int)

(* ****** ****** *)

extern fun WordCounting (): wcmap

(* ****** ****** *)

implement
WordCounting () = let
//
fun loop
  (map: wcmap): void = let
//
val opt = word_get ()
val issome = stropt_is_some (opt)
//
in
  if issome then let
    val () = wcmap_incby1 (map, stropt_unsome (opt)) in loop (map)
  end else () // end of [if]
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
typedef
charlst = list0(char)
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
    loop2 (cons0{char}(int2char0(i), nil0))
  else loop () // end of [if]
) else nil0((*void*))
//
end // end of [loop]

and loop2
(
  res: charlst
) : charlst = let
  val i = char_get ()
in
  if isalpha (i) then
    loop2 (cons0{char}(int2char0(i), res)) else res
  // end of [if]
end // end of [loop2]
//
val cs = loop ()
//
in
//
case+ cs of
| nil0 () => stropt_none ((*void*))
| cons0 _ => stropt_some (string_make_rlist (cs))
//
end // end of [word_get]

(* ****** ****** *)

local

staload
HT = "libats/ML/SATS/hashtblref.sats"

assume wcmap_type = $HT.hashtbl (string, int)

in (* in of [local] *)

implement
wcmap_create () =
  $HT.hashtbl_make_nil (i2sz(1024))
// end of [wcmap_create]

implement
wcmap_incby1
  (map, w) = let
//
val opt = $HT.hashtbl_search (map, w)
//
in
//
case+ opt of
| ~Some_vt (n) =>
  {
    val-~Some_vt _ = $HT.hashtbl_insert (map, w, n+1)
  }
| ~None_vt ((*void*)) => $HT.hashtbl_insert_any (map, w, 1)
//
end // end of [wcmap_incby1]

implement
wcmap_listize (map) = $HT.hashtbl_takeout_all (map)

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
typedef ki = @(string, int)
//
local
fn cmp
(
  wc1: ki, wc2: ki
) :<0> int = let
  val sgn1 = compare (wc2.1, wc1.1)
in
  if sgn1 != 0 then sgn1 else compare (wc1.0, wc2.0)
end // end of [cmp]
in (*in of [local]*)
val wcs2 = list0_mergesort<ki> (wcs, lam (wc1, wc2) => cmp (wc1, wc2))
end // end of [local]
//
val wcs2_100 = list0_take_exn (wcs2, 100)
//
// for listing the top 100
// most frequently encountered words
//
local
implement
fprint_val<ki> (out, wc) = fprint! (out, wc.0, "\t->\t", wc.1)
in (*in of [local]*)
val () = fprint (stdout_ref, wcs2_100, "\n")
end // end of [local]
//
val () = fprint_newline (stdout_ref)
//
} // end of [main0]

(* ****** ****** *)

(* end of [wordcnt.dats] *)
