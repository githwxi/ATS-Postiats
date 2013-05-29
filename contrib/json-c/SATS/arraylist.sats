(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./json_header.sats"

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

castfn
array_list2ptr {l:addr} (al: !array_list (l)):<> ptr (l)
overload ptrcast with array_list2ptr

(* ****** ****** *)

fun array_list_new
  (free_fn: free_fn_type): array_list0 = "mac#%"
// end of [array_list_new]

(* ****** ****** *)

fun array_list_free (al: array_list1):<!wrt> void = "mac#%"

(* ****** ****** *)

fun array_list_length (al: !array_list1):<> intGte(0) = "mac#%"

(* ****** ****** *)

fun array_list_add
  (al: !array_list1, data: Ptr0):<!wrt> int(*err*) = "mac#%"

(* ****** ****** *)

fun array_list_get_idx
  (al: !array_list1, i: intGte(0)):<> Ptr0 = "mac#%"
fun array_list_set_idx
  (al: !array_list1, i: intGte(0), data: Ptr0):<!wrt> int(*err*) = "mac#%"

(* ****** ****** *)

fun array_list_sort
  (al: !array_list1, cmp: (ptr, ptr) -<fun> int):<!wrt> void = "mac#%"

(* ****** ****** *)

(* end of [arraylist.sats] *)
