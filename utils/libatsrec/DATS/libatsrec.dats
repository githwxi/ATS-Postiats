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
  (line, kend) = (
//
if
(kend >= 3)
then let
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
) (* end of [line_get_key] *)

(* ****** ****** *)

implement
line_is_nsharp
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
      if
      (c = '#')
      then loop0(ptr_succ<char>(p), n-1)
      else false
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

implement
line_add_value
(
  line, kend, buf
) = let
//
fun
loop0
(
 p: ptr, buf: !stringbuf
) : int = let
//
val c =
$UN.ptr0_get<char>(p)
//
in
ifcase
| isspace(c) =>
  loop0(ptr_succ<char>(p), buf)
| _(* else *) =>
  loop1(c, ptr_succ<char>(p), buf)
end // end of [loop0]
//
and
loop1
(
 c: char, p1: ptr, buf: !stringbuf
) : int = let
//
val c = g1ofg0_char(c)
//
in
//
ifcase
| (c = '\\') => let
    val c1 = 
    $UN.ptr0_get<char>(p1)
    val c1 = g1ofg0_char(c1)
  in
    if
    isneqz(c1)
    then let
      val _1_ =
      stringbuf_insert_char<>
        (buf, c)
      // end of [val]
    in
      loop1
      (c1, ptr_succ<char>(p1), buf)
    end // end of [then]
    else (1) // end of [else]
  end // end of [BACKSLASH]
| _(* else *) =>
  (
    if
    isneqz(c)
    then let
      val _1_ =
      stringbuf_insert_char<>
        (buf, c)
      // end of [val]
      val c1 =
      $UN.ptr0_get<char>(p1)
    in
      loop1(c1, ptr_succ<char>(p1), buf)
    end // end of [then]
    else (0) // end of [else]
  ) // end of [else]
//
end // end of [loop1]
//
in
//
loop0
(ptr_add<char>(string2ptr(line), kend), buf)
//
end (* end of [line_add_value] *)

(* ****** ****** *)

implement
line_add_value_cont
  (line, buf) = let
//
fun
loop1
(
 c: char, p1: ptr, buf: !stringbuf
) : int = let
//
val c = g1ofg0_char(c)
//
in
//
ifcase
| (c = '\\') => let
    val c1 = 
    $UN.ptr0_get<char>(p1)
    val c1 = g1ofg0_char(c1)
  in
    if
    isneqz(c1)
    then let
      val _1_ =
      stringbuf_insert_char<>
        (buf, c)
      // end of [val]
    in
      loop1
      (c1, ptr_succ<char>(p1), buf)
    end // end of [then]
    else (1) // end of [else]
  end // end of [BACKSLASH]
| _(* else *) =>
  (
    if
    isneqz(c)
    then let
      val _1_ =
      stringbuf_insert_char<>
        (buf, c)
      // end of [val]
      val c1 =
      $UN.ptr0_get<char>(p1)
    in
      loop1(c1, ptr_succ<char>(p1), buf)
    end // end of [then]
    else (0) // end of [else]
  ) // end of [else]
//
end // end of [loop1]
//
val p = string2ptr(line)
val c = $UN.ptr0_get<char>(p)
//
in
  loop1(c, ptr_succ<char>(p), buf)
end // end of [line_add_value_cont]

(* ****** ****** *)

(* end of [libatsrec.dats] *)
