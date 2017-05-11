(* ****** ****** *)
(*
** For testing libatsrec
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
macdef
streamize_fileref_line =
streamize_fileref_line
//
(* ****** ****** *)
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $LIBATSREC // opening it
#staload $STRINGBUF // opening it
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)
//
extern
fun
line_lines_get_key_value
(
  line: string
, lines: List(string)
) : (Strptr1(*key*), Strptr1(*value*))
//
implement
line_lines_get_key_value
  (x0, xs) =
  (key, value) where
{
//
val x0 = g1ofg0(x0)
//
val
kend = line_is_key(x0)
//
val () = assertloc(kend >= 0)
//
val key = line_get_key(x0, kend)
//
val buf = stringbuf_make_nil(1024)
//
val neol = line_add_value(x0, kend, buf)
//
val value = let
//
fun
loop
(
  neol: int
, lines: List(string), buf: !stringbuf
) : void =
(
case+ lines of
| list_nil() => ()
| list_cons(x, xs) =>
  loop(neol, xs, buf) where
  {
    val () =
    if
    (neol = 0)
    then () where
    {
      val _ =
      stringbuf_insert_char<>(buf, '\n')
    } (* end of [then] *)
    val neol = line_add_value_cont(x, buf)
  } (* end of [loop] *)
)
//
in
  loop(neol, xs, buf); stringbuf_getfree_strptr(buf)
end // end of [val]
//
} (* end of [line_lines_get_key_value] *)

(* ****** ****** *)

val line1 = "[name]: what is my name?\\"
val line2 = " My name is very strange!!!\\"
val line3 = " My name is very strange!!!"

(* ****** ****** *)

implement
main0() = () where
{
//
val ke = line_is_key(line1)
//
val () = assertloc (ke >= 0)
//
val key = line_get_key(line1, ke)
//
val ((*void*)) = println! ("line1: key = ", key)
//
val ((*void*)) = strptr_free(key)
//
val (key, value) =
line_lines_get_key_value(line1, list_pair(line2, line3))
//
val ((*void*)) = println! ("line1: key = (", key, ")")
val ((*void*)) = println! ("line1: value = (", value, ")")
//
val ((*void*)) = strptr_free(key)
val ((*void*)) = strptr_free(value)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
