//
// Ordering words according to the numbers
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
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/string.sats"

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
vtypedef
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

(* end of [wordcnt.dats] *)
