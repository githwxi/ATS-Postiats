(* ****** ****** *)
(*
** HX-2018-01-10:
** A simple-minded funcitonal
** implementation of MP arithmetic
** What I have in mind is to handle
** something as large as 2^1000000
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
abstype
uintinf_type(i:int) = ptr
typedef
uintinf(i:int) = uintinf_type(i)
typedef
uintinf(*void*) = [i:int] uintinf(i)
//
(* ****** ****** *)
//
extern
praxi
lemma_uintinf_param
{i:int}
(x: uintinf(i)): [i>=0] void
//
(* ****** ****** *)
//
extern
fun
int2uintinf
{i:nat}
(x: int(i)): uintinf(i)
//
extern
fun
uint2uintinf_0
{i:int}
(x: uint): uintinf
extern
fun
uint2uintinf_1
{i:int}
(x: uint(i)): uintinf(i)
//
overload uint2uintinf with uint2uintinf_0
overload uint2uintinf with uint2uintinf_1
//
(* ****** ****** *)

extern
fun
succ_uintinf
{i:int}
(x: uintinf(i)): uintinf(i+1)

extern
fun
pred_uintinf
{i:pos}
(x: uintinf(i)): uintinf(i-1)

overload succ with succ_uintinf
overload pred with pred_uintinf

(* ****** ****** *)
//
extern
fun
add_uint_uintinf
{i,j:int}
(x: uint(i), y: uintinf(j)): uintinf(i+j)
extern
fun
add_uintinf_uint
{i,j:int}
(x: uintinf(i), y: uint(j)): uintinf(i+j)
extern
fun
add_uintinf_uintinf
{i,j:int}
(x: uintinf(i), y: uintinf(j)): uintinf(i+j)
//
(* ****** ****** *)
//
extern
fun
sub_uintinf_uint
{i,j:int | i >= j}
(x: uintinf(i), y: uint(j)): uintinf(i-j)
extern
fun
sub_uintinf_uintinf
{i,j:int | i >= j}
(x: uintinf(i), y: uintinf(j)): uintinf(i-j)
//
(* ****** ****** *)
//
extern
fun
mul_uintinf_uint
{i,j:int}
(x: uintinf(i), y: uint(j)): uintinf(i*j)
extern
fun
mul_uintinf_uintinf
{i,j:int}
(x: uintinf(i), y: uintinf(j)): uintinf(i*j)
//
extern
fun
muladd_uintinf_uint_uint
{i,j,k:int | j > 0}
(x: uintinf(i), y: uint(j), z: uint(k)): uintinf(i*j+k)
//
(* ****** ****** *)
//
overload + with add_uintinf_uint
overload + with add_uint_uintinf
overload + with add_uintinf_uintinf
//
overload * with mul_uintinf_uint
overload * with mul_uintinf_uintinf
//
(* ****** ****** *)

extern
fun
lt_uint_uintinf
{i,j:int}
(x: uint(i), y: uintinf(j)): bool(i <= j)
extern
fun
lte_uint_uintinf
{i,j:int}
(x: uint(i), y: uintinf(j)): bool(i <= j)

overload < with lt_uint_uintinf
overload <= with lte_uint_uintinf

(* ****** ****** *)
//
extern
fun
fprint_uintinf: fprint_type(uintinf)
extern
fun
fprint_uintinf_raw: fprint_type(uintinf)
//
(* ****** ****** *)
//
#staload UN = $UNSAFE
//
(* ****** ****** *)
//
macdef
DIGITMAX = $UN.cast2uint(~1)
//
(* ****** ****** *)
//
local
assume
uintinf_type(i) = list0(uint) in (*nil*) end
//
(* ****** ****** *)

implement
fprint_uintinf_raw
  (out, us) = let
//
val sep = "|"
//
fun
auxlst
(
us:
list0(uint)
) : int =
(
case+ us of
| list0_nil
    () => (0)
| list0_cons
    (u0, us) => n0+1 where
  {
    val n0 = auxlst(us)
    val () =
    if n0 > 0
      then fprint(out, sep)
    // end of [if]
    val () = fprint(out, u0)
  } (* end of [list0_cons] *)
)
//
reassume uintinf_type
//
in
  fprint(out, "U(");
  ignoret(auxlst(us));fprint(out, ")")
end // end of [fprint_uintinf_raw]

(* ****** ****** *)

local

reassume uintinf_type

in (* in-of-local *)

implement
int2uintinf(x) =
(
  if (x > 0)
  then list0_sing(g1int2uint(x))
  else list0_nil()
)

implement
uint2uintinf_0(x) =
(
  if (x > 0u)
  then list0_sing(x) else list0_nil()
)
implement
uint2uintinf_1(x) =
(
  if (x > 0u)
  then list0_sing(x) else list0_nil()
)

implement
succ_uintinf
  {i}(us) =
(
case+ us of
| list0_nil() =>
  list0_sing(1u)
| list0_cons(u0, us) =>
  let
    val v0 = succ(u0)
  in
    if v0 > 0
      then list0_cons(v0, us)
      else list0_cons(v0, succ_uintinf(us))
    // end of [if]
  end // end of [list0_cons]
)

implement
pred_uintinf
  {i}(us) =
(
case- us of
(*
| list0_nil() => ...
*)
| list0_cons(u0, us) =>
  (
    if u0 > 0
      then let
        val u0 = pred(u0)
      in
        case+ us of
        | list0_nil _ =>
          if u0 = 0u
          then list0_nil() else list0_sing(u0)
        | list0_cons(_, _) => list0_cons(u0, us)
      end // end of [then]
      else let
        val us =
        pred_uintinf{i}(us) in list0_cons(DIGITMAX, us)
      end // end of [else]
    // end of [if]
  ) (* end of [list0_cons] *)
)

end // end of [local]

(* ****** ****** *)

local

reassume uintinf_type

in (* in-of-local *)

implement
lt_uint_uintinf
  (x, y) = (
//
case+ y of
| list0_nil() =>
  $UN.cast(false)
| list0_cons(u, us) =>
  (
    case+ us of
    | list0_nil() =>
      $UN.cast(x < u)
    | list0_cons _ => $UN.cast(true)
  )
//
) // end of [lt_uint_uintinf]

implement
lte_uint_uintinf
  (x, y) = (
//
case+ y of
| list0_nil() =>
  $UN.cast
  (if x > 0u
   then false else true
  )
| list0_cons(u, us) =>
  (
    case+ us of
    | list0_nil() =>
      $UN.cast(x <= u)
    | list0_cons _ => $UN.cast(true)
  )
//
) // end of [lte_uint_uintinf]

end // end of [local]

(* ****** ****** *)
//
extern
fun
uint64_lower(uint64): uint
and
uint64_upper(uint64): uint
//
implement
uint64_lower(x) =
  $UN.cast{uint}(x)
implement
uint64_upper(x) =
  $UN.cast{uint}(x >> 32)
//
overload .lower with uint64_lower
overload .upper with uint64_upper
//
(* ****** ****** *)
//
extern
fun
add64_uint_uint
(x: uint, y: uint): uint64
//
extern
fun
mul64_uint_uint
(x: uint, y: uint): uint64
extern
fun
muladd64_uint_uint_uint
( x: uint
, y: uint, z: uint): uint64
//
local
//
macdef
uint64(i) =
$UN.cast{uint64}(,(i))
//
in

implement
add64_uint_uint
  (x, y) =
(
  uint64(x) + uint64(y)
)
implement
mul64_uint_uint
  (x, y) =
(
  uint64(x) * uint64(y)
)
implement
muladd64_uint_uint_uint
  (x, y, z) =
(
  uint64(x) * uint64(y) + uint64(z)
)

end // end of [local]
//
(* ****** ****** *)
//
implement
add_uintinf_uint
  (x, y) = let
//
reassume uintinf_type
//
in
//
case+ x of
| list0_nil() =>
  (if y > 0u
   then list0_sing(y) else list0_nil())
| list0_cons(u0, us) => let
    val vv =
      add64_uint_uint(u0, y)
    // end of [val]
    val v0 = uint64_lower(vv)
    val v1 = uint64_lower(vv)
  in
    if v1 = 0u
    then list0_cons(v0, us)
    else list0_cons(v0, succ_uintinf(us))
  end // end of [list0_cons]
//
end // end of [add_uintinf_uint]
//
implement
add_uint_uintinf
  (x, y) = add_uintinf_uint(y, x)
//
(* ****** ****** *)

implement
mul_uintinf_uint
  (x, y) = let
//
reassume uintinf_type
//
fun
auxlst
{i,j:int | j > 0}
(us: uintinf(i), y: uint(j)): uintinf(i*j) =
(
case+ us of
| list0_nil() =>
  list0_nil()
| list0_cons(u0, us) => let
    val vv =
    mul64_uint_uint(u0, y)
    val v0 = vv.lower()
    val v1 = g1ofg0(vv.upper())
  in
    list0_cons
    (v0, muladd_uintinf_uint_uint(us, y, v1))
  end // end of [list0_cons]
)
//
in
  if y > 0u then auxlst(x, y) else list0_nil()
end (* end of [mul_uintinf_uint] *)

(* ****** ****** *)
//
// HX: [y] is positive!
//
implement
muladd_uintinf_uint_uint
  (x, y, z) =
  auxlst(x, y, z) where
{
//
reassume uintinf_type
//
fun
auxlst
{i,j,k:int|j > 0}
(
us: uintinf(i), y: uint(j), z: uint(k)
) : uintinf(i*j+k) =
(
case+ us of
//
| list0_nil() =>
  if z > 0u
  then list0_sing(z) else list0_nil(*void*)
//
| list0_cons(u0, us) => let
    val vv =
    mul64_uint_uint(u0, y)
  in
    list0_cons
    (vv.lower(), auxlst(us, y, g1ofg0(vv.upper())))
  end // end of [list0_cons]
//
)
//
} (* end of [muladd_uintinf_uint_uint] *)

(* ****** ****** *)

(* end of [myintinf_t.dats] *)
