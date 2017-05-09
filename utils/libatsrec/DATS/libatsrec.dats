(* ****** ****** *)
(*
**
** Author: Hongwei Xi
** Start Time: May, 2017
** Authoremail: gmhwxiATgmailDOTcom
**
*)
(* ****** ****** *)
//
#staload
"prelude/SATS/string.sats"
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"libats/SATS/stringbuf.sats"
//
#staload _ =
"libats/DATS/stringbuf.dats"
//
(* ****** ****** *)
//
#staload "./../SATS/libatsrec.sats"
//
(* ****** ****** *)
//
implement
line_is_key
  (line) = let
//
fnx
loop0
(
 p: ptr
) : int = let
//
  val c =
  $UN.ptr0_get<char>(p)
//
in
//
if
isneqz(c)
then
(
if c = '\['
  then
  loop1
    (ptr_succ<char>(p), 1)
  // then
  else (~1)
// end of [if]
)
else (~1) // end of [else]
//
end // end of [loop0]
//
and
loop1
(
 p: ptr, i: int
) : int = let
//
  val c =
  $UN.ptr0_get<char>(p)
//
in
//
if
isneqz(c)
then
(
ifcase
| c = ']' => let
    val p =
    ptr_succ<char>(p)
    val c =
    $UN.ptr0_get<char>(p)
  in
    if (c = ':') then (i+2) else (~1)
  end // end of [RBRACKET]
| c = '\\' => let
    val p =
    ptr_succ<char>(p)
    val c =
    $UN.ptr0_get<char>(p)
  in
    if isneqz(c)
      then loop1(ptr_succ<char>(p), i+2) else (~1)
    // end of [if]
  end // end of [BACKSLASH]
| _ (* rest-of-char *) => loop1(ptr_succ<char>(p), i+1)
)
else (~1) // end of [else]
//
end // end of [loop1]
//
in
  $UN.cast(loop0(string2ptr(line)))
end // end of [list_is_key]

(* ****** ****** *)

implement
line_get_key
  (line) = let
//
val line = g1ofg0(line)
val kend = line_is_key(line)
//
in
//
if
(kend >= 0)
then let
//
val () =
assertloc(kend >= 3)
//
val key =
string_make_substring
  (line, i2sz(1), i2sz(kend-3))
//
prval() =
  lemma_strnptr_param(key)
//
in
//
  Some_vt(strnptr2strptr(key))
//
end // end of [then]
else None_vt((*void*))
//
end // end of [line_get_key]

(* ****** ****** *)

implement
line_is_comment
  (line, nsharp) = let
//
fun
loop0
(
 p: ptr, n: int
) : bool = (
//
if
(n > 0)
then let
  val c =
  $UN.ptr0_get<char>(p)
in
  if isneqz(c)
    then (
      if c = '#'
        then loop0(ptr_succ<char>(p), n-1)
        else false
      // end of [if]
    ) else false // end of [if]
end // end of [then]
else true // end of [else]
//
) (* end of [loop0] *)
//
in
  loop0(string2ptr(line), nsharp)
end // end of [line_is_comment]

(* ****** ****** *)

(* end of [libatsrec.dats] *)
