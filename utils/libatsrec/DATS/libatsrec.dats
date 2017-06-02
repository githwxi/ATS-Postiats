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
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"prelude/SATS/string.sats"
#staload
"prelude/SATS/stream.sats"
#staload
"prelude/SATS/stream_vt.sats"
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
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/gvalue.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/libatsrec.sats"
//
(* ****** ****** *)
//
local
#staload
FILEBAS =
"prelude/SATS/filebas.sats"
in (* in-of-local *)
macdef
streamize_fileref_line =
$FILEBAS.streamize_fileref_line
end // end of [local]
//
(* ****** ****** *)
//
implement
line_is_key(line) = let
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
if (
c != '\['
) then (~1)
  else loop1(ptr_succ<char>(p), 1(*pos*))
// end of [if]
) (* end of [then] *)
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
| _ (*rest-of-char*) => loop1(ptr_succ<char>(p), i+1)
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
  (line, kend) = let
//
val () = assertloc(kend >= 3)
//
val key =
string_make_substring
  (line, i2sz(1), i2sz(kend-3))
//
prval() = lemma_strnptr_param(key)
//
in
  strnptr2strptr(key)
end (* end of [line_get_key] *)

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
if (
c != '#'
) then false
  else loop0(ptr_succ<char>(p), n-1)
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
val c = $UN.ptr0_get<Char>(p)
//
in
//
if
(c = '\\')
then let
//
val p1 = ptr_succ<char>(p)
val c1 = $UN.ptr0_get<Char>(p1)
//
in
//
ifcase
| c1 = '#' => let
    val _1_ =
    stringbuf_insert_char<>
      (buf, c1)
    // end of [val]
    val p2 = ptr_succ<char>(p1)
    val c2 = $UN.ptr0_get<char>(p2)
  in
    loop1(c2, ptr_succ<char>(p2), buf)
  end // end of [c1==#]
| c1 = '\\' => let
    val _1_ =
    stringbuf_insert_char<>
      (buf, c1)
    // end of [val]
    val p2 = ptr_succ<char>(p1)
    val c2 = $UN.ptr0_get<char>(p2)
  in
    loop1(c2, ptr_succ<char>(p2), buf)
  end // end of [c1==\]
| _(*rest-of-char*) =>
  (
    if
    isneqz(c1)
    then let
      val _1_ =
      stringbuf_insert_char<>
        (buf, c)
      // end of [val]
    in
      loop1(c1, ptr_succ<char>(p1), buf)
    end else (1)
  ) (* rest-of-char *)
end else (
  loop1(c, ptr_succ<char>(p), buf)
) (* end of [else] *)
//
end // end of [line_add_value_cont]

(* ****** ****** *)

fun
linenum_free
(
  line: linenum_vt
) : void = let
//
val+
~LINENUM(_, line) = line
//
in
  strptr_free(line)
end // end of [linenum_free]

(* ****** ****** *)

fun
linenum_is_nil
(
  line: !linenum_vt
) : bool = let
//
val LINENUM(_, line) = line
//
in
//
string_is_empty
  ($UN.strptr2string(line))
//
end // end of [linenum_is_nil]

fun
linenum_is_delim
(
  line: !linenum_vt
) : bool = let
//
val LINENUM(_, line) = line
//
in
//
line_is_nsharp
  ($UN.strptr2string(line), 6)
//
end // end of [linenum_is_delim]

fun
linenum_is_cmmnt
(
  line: !linenum_vt
) : bool = let
//
val LINENUM(_, line) = line
//
in
//
line_is_nsharp
  ($UN.strptr2string(line), 1)
//
end // end of [linenum_is_cmmnt]

(* ****** ****** *)

fun
lines_drop_nil
(
xs: List_vt(linenum_vt)
) : List0_vt(linenum_vt) =
(
case+ xs of
| ~list_vt_nil
    () => list_vt_nil()
| @list_vt_cons
    (x, xs_tl) => let
    val
    isnil = linenum_is_nil(x)
  in
    if isnil
      then let
        val xs_tl = xs_tl
        val ((*void*)) = linenum_free(x)
        val ((*freed*)) = free@{..}{0}(xs)
      in
        lines_drop_nil(xs_tl)
      end else (fold@(xs); xs)
    // end of [if]
  end // end of [list_vt_cons]
) (* end of [lines_drop_nil] *)

(* ****** ****** *)

implement
lines_grouping
  (xs) = let
//
fun
auxmain
(
xs:
stream_vt(linenum_vt)
,
ys: List0_vt(linenum_vt)
) : stream_vt_con(linenumlst_vt) =
(
//
case+ !xs of
//
| ~stream_vt_nil
    () => let
    val ys =
      list_vt_reverse(ys)
    // end of [val]
    val ys = lines_drop_nil(ys)
  in
    stream_vt_cons
    ( ys
    , stream_vt_make_nil()
    ) (* stream_vt_cons *)
  end // end of [stream_vt_nil]
//
| ~stream_vt_cons
    (x, xs) => (
    if
    linenum_is_delim(x)
    then let
      val () =
        linenum_free(x)
      val ys =
        list_vt_reverse(ys)
      // end of [val]
      val ys = lines_drop_nil(ys)
    in
      stream_vt_cons
        (ys, lines_grouping(xs))
      // end of [stream_vt_cons]
    end // end of [then]
    else (
      if
      linenum_is_cmmnt(x)
      then let
        val () =
          linenum_free(x) in auxmain(xs, ys)
        // end of [val]
      end // end of [then]
      else let
        val ys =
          list_vt_cons(x, ys) in auxmain(xs, ys)
        // end of [val]
      end // end of [else]
    ) (* end of [else] *)
  ) (* end of [stream_vt_cons] *)
//
) (* end of [auxmain] *)
//
in
//
$ldelay
(
  auxmain(xs, list_vt_nil(*void*)), (~xs)
) (* $ldelay *)
//
end // end of [lines_grouping]

(* ****** ****** *)

implement
process_linenumlst<>
  (lines) =
  loop0(lines) where
{
//
vtypedef
xs = linenumlst_vt
//
fun
loop0(xs: xs): void =
(
//
case+ xs of
| ~list_vt_nil() => ()
| ~list_vt_cons(x, xs) => let
    val+
    ~LINENUM(n, lcs) = x
    val cs2 =
    $UN.strptr2string(lcs)
    val kend = line_is_key(cs2)
  in
    if
    kend >= 0
    then let
      val key =
      line_get_key(cs2, kend)
    in
      loop1(lcs, kend, xs, key)
    end // end of [then]
    else let
(*
      val () =
      prerrln!
        ("line(", n+1, ") = (", cs2, ")")
      // end of [val]
*)
      val () =
      prerrln!
        ("line(", n+1, "): key is missing!")
      // end of [val]
      val () = strptr_free(lcs) in loop0(xs)
    end // end of [else]
  end // end of [list_vt_cons]
//
) (* end of [loop0] *)
//
and
loop1
(
lcs: Strptr1,
kend: intGte(0), xs: xs, key: Strptr1
) : void = let
//
val cs2 =
  $UN.strptr2string(lcs)
val buf =
  stringbuf_make_nil(1024)
val neol = let
  extern
  prfun
  __assert__
    {n,k:int}
  (
    cs2: string(n), kend: int(k)
   ) : [k < n] void
  prval () = __assert__(cs2, kend)
in
  line_add_value(cs2, kend, buf)
end (* end of [val] *)
//
in
  strptr_free(lcs); loop2(xs, neol, buf, key)
end // end of [loop1]
//
and
loop2
(
xs: xs, neol: int,
buf: stringbuf, key: Strptr1
) : void =
(
case+ xs of
| ~list_vt_nil() =>
  {
    val
    value =
    stringbuf_getfree_strptr(buf)
    val ((*void*)) =
    process_key_value<>(key, value)
  }
| ~list_vt_cons(x, xs) => let
    val+
    ~LINENUM(n, lcs) = x
    val cs2 =
    $UN.strptr2string(lcs)
    val kend = line_is_key(cs2)
  in
    if
    kend >= 0
    then
    loop1
    (lcs, kend, xs, key) where
    {
//
      val
      value =
      stringbuf_getfree_strptr(buf)
      val ((*void*)) =
      process_key_value<>(key, value)
//
      val key = line_get_key(cs2, kend)
    } (* end of [then] *)
    else let
      val () =
      if
      (neol = 0)
      then () where
      {
        val _1_ =
        stringbuf_insert_char<>
          (buf, '\n')
        // end of [val]
      } (* end of [then] *)
      val cs2 =
        $UN.strptr2string(lcs)
      val neol =
        line_add_value_cont(cs2, buf)
    in
      strptr_free(lcs); loop2(xs, neol, buf, key)
    end (* end of [else] *)
  end // end of [list_vt_cons]
)
//
} (* end of [process_linenumlst] *)

(* ****** ****** *)
//
implement
streamize_fileref_gvhashtbl_0
  (inp) =
(
streamize_fileref_gvhashtbl_cap
  (inp, 8(*default*))
)
//
(* ****** ****** *)
//
implement
streamize_fileref_gvhashtbl_cap
  (inp, cap) =
  auxmain(gxs) where
{
//
vtypedef
gx = linenumlst_vt
fun
auxmain
(
  gxs: stream_vt(gx)
) : stream_vt(gvhashtbl) = $ldelay
(
case+ !gxs of
| ~stream_vt_nil
    () => stream_vt_nil(*void*)
| ~stream_vt_cons
    (gx, gxs) => let
//
    val obj =
    gvhashtbl_make_nil(cap)
//
    local
    implement
    process_key_value<>
      (key, value) =
    {
      val k = strptr2string(key)
      val v = strptr2string(value)
      val () = obj[k] := GVstring(v)
    }
    in
    val () = process_linenumlst<>(gx)
    end // end of [local]
//
  in
    stream_vt_cons(obj, auxmain(gxs))
  end // end of [stream_vt_cons]
, (~gxs) // for freeing the generated stream
)
//
val xs =
streamize_fileref_line(inp)
//
val lns =
stream_vt_imap_fun
  (xs, lam(i, x) => LINENUM(i, x))
//
val gxs = lines_grouping(lns)
//
} (* end of [streamize_fileref_gvhashtbl] *)
//
(* ****** ****** *)

(* end of [libatsrec.dats] *)
