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

(* end of [unicode.sats] *)
