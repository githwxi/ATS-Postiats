(*
**
** Unicode encoding/decoding functions
**
*)

(* ****** ****** *)

(*
** Author: Artyom Shalkhakov
** Authoremail: 
** Start Time: February 2013
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: 
** Start Time: April 2, 2013
*)

(* ****** ****** *)

abstype
ustring_type (a:t@ype, n:int) = ptr
stadef ustring = ustring_type
//
typedef
Ustring (a:t@ype) = [n:int] ustring_type (a, n)
typedef
Ustring0 (a:t@ype) = [n: int | n >= 0] ustring (a, n)
typedef
Ustring1 (a:t@ype) = [n: int | n >= 1] ustring (a, n)
//
(* ****** ****** *)
//
absvtype
ustrptr_vtype (a:t@ype, l:addr) = ptr
stadef ustrptr = ustrptr_vtype
//
vtypedef
Ustrptr (a:t@ype) = [l:addr] ustrptr_vtype (a, l)
vtypedef
Ustrptr0 (a:t@ype) = [l:addr | l >= null] ustrptr (a, l)
vtypedef
Ustrptr1 (a:t@ype) = [l:addr | l >  null] ustrptr (a, l)
//
(* ****** ****** *)

castfn
ustring2ptr {a:t@ype}{n:int} (x: ustring (a, n)):<> Ptr1
castfn
ustrptr2ptr {a:t@ype}{l:addr} (x: !ustrptr (a, l)):<> ptr (l)

(* ****** ****** *)

exception MalformedExn of ()
exception InvalidCodepointExn of int

(* ****** ****** *)

#define CODEPOINT_MAX 0x10ffff

(* ****** ****** *)

datatype byte_order = BOlittle | BObig | BOmalformed

(* ****** ****** *)

fun char2_get_byte_order (c1: int, c2: int):<> byte_order

(* ****** ****** *)

abst@ype intcpw (i:int, w:int) = int (w)

fun utf8_get_cpw {i:int} (cp: int i): [w:int] intcpw (i, w)

(* ****** ****** *)

fun{}
utf8_encode$fput (u: uint): void
fun{}
utf8_encode_err (cp: uint, err: &int? >> int): void

(* ****** ****** *)

fun{}
utf8_decode$fget (): int
fun{}
utf8_decode_err (err: &int? >> int): int

(* ****** ****** *)
    
(* end of [unicode.sats] *)
