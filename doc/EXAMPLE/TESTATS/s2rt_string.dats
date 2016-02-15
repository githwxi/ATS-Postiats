(*
** Simple code
** involving the float sort
** HX-2016-02-14
*)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
stacst
string_append : (string, string) -> string
//
stadef + = string_append
//
(* ****** ****** *)
//
abstype
string_string_type(string) = string
//
stadef mystring = string_string_type
//
(* ****** ****** *)
//
extern
fun
mystring_append
{xs,ys:string}
(
  xs: mystring(xs)
, ys: mystring(ys)
) : mystring(xs+ys)
//
(* ****** ****** *)

val fire = $UN.cast{mystring"fire"}("fire")
val truck = $UN.cast{mystring"truck"}("truck")

(* ****** ****** *)

val firetruck = mystring_append(fire, truck)

(* ****** ****** *)

(* end of [s2rt_string.dats] *)
