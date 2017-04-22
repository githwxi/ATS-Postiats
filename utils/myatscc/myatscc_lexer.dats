(*
** HX-2017-04-22:
** For turning string into tokens
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
#include
"$PATSHOMELOCS/atscntrb-hx-parcomb/mylibies.hats"
//
(* ****** ****** *)
//
#define :: list_cons
#define i2c int2char0
//
(* ****** ****** *)
//
abst@ype
ichar_t0ype = @(int, char)
//
typedef ichar = ichar_t0ype
//
local
assume ichar_t0ype = @(intGte(0), charNZ)
in (*nothing*) end
//
(* ****** ****** *)
//
extern
fun
string2icharlst
  (cs: string): stream(ichar)
//
implement
string2icharlst
  (cs) = let
//
reassume ichar_t0ype
//
fun
auxmain
(
 i: intGte(0), p: ptr
) : stream(@(intGte(0), charNZ)) = $delay
(
let
  val c = $UN.ptr0_get<Char>(p) 
in
  if isneqz(c)
    then
    (
    stream_cons(@(i, c), auxmain(i+1, ptr_succ<char>(p)))
    ) else stream_nil() // end of [else]
  // end of [if]
end // end of [let]
)
//
in
  auxmain(0, string2ptr(cs))
end // end of [string2icharlst]

(* ****** ****** *)

(* end of [myatscc_lexer.dats] *)
