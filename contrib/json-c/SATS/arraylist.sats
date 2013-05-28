(*
** API for json-c in ATS
*)

(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
**
** Time: May, 2013
** Author Hongwei Xi (gmhwxi AT gmail DOT com)
**
*)

(* ****** ****** *)

(*
struct
array_list
*array_list_new (array_list_free_fn *free_fn)

void  array_list_free (struct array_list *al)
void *array_list_get_idx (struct array_list *al, int i)
int   array_list_put_idx (struct array_list *al, int i, void *data)
int   array_list_add (struct array_list *al, void *data)
int   array_list_length (struct array_list *al)
void  array_list_sort (struct array_list *arr, int(*compar)(const void *, const void *))
*)

(* ****** ****** *)

absvtype array_list_vtype (l:addr) = ptr
vtypedef array_list (l) = array_list_vtype (l)
vtypedef array_list1 = [l:addr | l > null] array_list (l)

(* ****** ****** *)
//
fun array_list_new
  (free_fn: (array_list1) -<0,!wrt> void): array_list1
//
(* ****** ****** *)

fun array_list_free (al: array_list1):<!wrt> void

(* ****** ****** *)

fun array_list_length (al: !array_list1):<> int

(* ****** ****** *)

fun array_list_add (al: !array_list1, data: Ptr0):<!wrt> int(*err*)

(* ****** ****** *)

fun array_list_get_idx (al: !array_list1):<> Ptr0
fun array_list_set_idx (al: !array_list1, i: int, data: Ptr0):<!wrt> int(*err*)

(* ****** ****** *)

fun array_list_sort (al: !array_list1, cmp: (ptr, ptr) -<fun> int):<!wrt> void

(* ****** ****** *)

(* end of [arraylist.sats] *)
