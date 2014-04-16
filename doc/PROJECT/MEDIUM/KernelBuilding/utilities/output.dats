(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

symintr output

(* ****** ****** *)
//
extern
fun{
} output_char (char): void
//
(* ****** ****** *)

extern
fun{} output_int (int): void
extern
fun{} output_uint (uint): void

(* ****** ****** *)

extern
fun{} output_ptr (ptr): void

(* ****** ****** *)

extern
fun{} output_string (string): void

(* ****** ****** *)

implement{
} output_int (i) =
{
//
val () =
if (i < 0)
  then output_char ('-')
// end of [if]
//
val u = (if i >= 0 then i else ~i): int
val () = output_uint ($UN.cast2uint(u))
//
} (* end of [output_int] *)

(* ****** ****** *)

implement{
} output_uint (u) = let
//
#define N 64
var buf = @[byte][N]((*uninitized*))
//
fun loop
(
  u: uint, p: &ptr >> _, i: intGte(0)
) : intGte(0) =
  if u > 0u then let
    val r = u mod 10u
    val r = g0u2i (r)
    val p1 = ptr_pred<byte> (p)
    val () = $UN.ptr0_set<char> (p1, '0'+r)
    val () = p := p1
  in
    loop (u / 10u, p, i+1)
  end else (i) // end of [if]
//
var p: ptr =
  ptr_add<byte> (addr@buf, N) 
val [i:int] i = loop (u, p, 0)
//
in
//
if u > 0u then
{
//
val ds = $UN.cast{arrayref(char,i)}(p)
//
local
implement(tenv)
array_foreach$fwork<char><tenv> (x, env) = output_char (x)
in(*in-of-local*)
val _(*i*) = arrayref_foreach<char> (ds, i2sz(i))
end // end of [local]
//
} else output_char<> ('0')
//
end (* end of [output_uint] *)

(* ****** ****** *)

implement{
} output_ptr (u) = let
//
val u = $UN.cast{uint}(u)
//
#define N 64
var buf = @[byte][N]((*uninitized*))
//
fun loop
(
  u: uint, p: &ptr >> _, i: intGte(0)
) : intGte(0) =
  if u > 0u then let
    val r = u mod 16u
    val r = g0u2i (r)
    val p1 = ptr_pred<byte> (p)
    val () =
    (
      if r < 10
        then $UN.ptr0_set<char> (p1, '0'+r)
        else $UN.ptr0_set<char> (p1, 'a'+(r-10))
      // end of [if]
    ) : void
    val () = p := p1
  in
    loop (u / 16u, p, i+1)
  end else (i) // end of [if]
//
var p: ptr =
  ptr_add<byte> (addr@buf, N) 
val [i:int] i = loop (u, p, 0)
//
in
//
if u > 0u then
{
//
val ds = $UN.cast{arrayref(char,i)}(p)
//
local
implement(tenv)
array_foreach$fwork<char><tenv> (x, env) = output_char (x)
in(*in-of-local*)
val _(*i*) = arrayref_foreach<char> (ds, i2sz(i))
end // end of [local]
//
} else output_string<> ("NULL")
//
end (* end of [output_ptr] *)

(* ****** ****** *)

implement{
} output_string (str) =
{
//
val str = g1ofg0 (str)
//
implement(env)
string_foreach$fwork<env> (c, env) = output_char (c)
//
val _ = string_foreach<> (str)
//
} (* end of [output_string] *)

(* ****** ****** *)

(* end of [output.dats] *)
