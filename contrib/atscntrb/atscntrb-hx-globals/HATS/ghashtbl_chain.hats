(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
abst@ype key
absvt@ype itm
#define CAPACITY
*)

(* ****** ****** *)
//
// HX-2014-03:
// the current number of items
//
extern
fun get_size ((*void*)): size_t
//
// HX-2014-03:
// the size of the underlying array
//
extern
fun get_capacity ((*void*)): size_t
//
(* ****** ****** *)
//
extern
fun search
(
  k0: key, res: &itm? >> opt (itm, b)
) : #[b:bool] bool(b) // endfun
extern
fun search_ref (k0: key): cPtr0 (itm)
extern
fun search_opt (k0: key): Option_vt (itm)
//
(* ****** ****** *)
//
extern
fun insert
(
  k0: key, x0: itm, res: &itm? >> opt (itm, b)
) : #[b:bool] bool (b) // endfun
extern
fun insert_opt (k0: key, x0: itm): Option_vt (itm)
//
extern
fun insert_any (k0: key, x0: itm): void // HX: always inserted
//
(* ****** ****** *)
//
extern
fun takeout
(
  k0: key, res: &itm? >> opt(itm, b)
) : #[b:bool] bool(b) // end-of-fun
extern
fun takeout_opt (k0: key): Option_vt (itm)
//
(* ****** ****** *)

extern
fun remove (k0: key): bool

(* ****** ****** *)

extern
fun listize1 (): List0_vt @(key, itm)

(* ****** ****** *)

extern
fun takeout_all (): List0_vt @(key, itm)

(* ****** ****** *)
//
extern
fun
foreach_cloref
  (fwork: (key, &itm >> _) -<cloref1> void): void
//
(* ****** ****** *)

local
//
staload
UNSAFE = "prelude/SATS/unsafe.sats"
//
staload "libats/SATS/hashtbl_chain.sats"
//
staload _ = "libats/DATS/hashfun.dats"
//
staload _ = "libats/DATS/qlist.dats"
staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/hashtbl_chain.dats"
//
val
the_hashtbl =
hashtbl_make_nil<key,itm>
  (i2sz(CAPACITY))
//
val
the_hashtbl_ptr =
$UNSAFE.castvwtp0{ptr}(the_hashtbl)
//
vtypedef HTBL = hashtbl(key, itm)
//
in (* in-of-local *)

(* ****** ****** *)

implement
get_size () = res where
{
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val res = hashtbl_get_size (htbl)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
} (* end of [get_size] *)

implement
get_capacity () = res where
{
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val res = hashtbl_get_capacity (htbl)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
} (* end of [get_capacity] *)

(* ****** ****** *)

implement
search (k0, res) = ans where
{
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val ans = hashtbl_search (htbl, k0, res)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
} (* end of [search] *)

implement
search_ref (k0) = ref where
{
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val ref = hashtbl_search_ref (htbl, k0)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
} (* end of [search_ref] *)

implement
search_opt (k0) = opt where
{
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val opt = hashtbl_search_opt (htbl, k0)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
} (* end of [search_opt] *)

(* ****** ****** *)

implement
insert (k0, x0, res) = let
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val ans = hashtbl_insert (htbl, k0, x0, res)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
in
  ans
end (* end of [insert] *)

implement
insert_opt (k0, x0) = let
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val opt = hashtbl_insert_opt (htbl, k0, x0)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
in
  opt
end (* end of [insert_opt] *)

(* ****** ****** *)

implement
insert_any (k0, x0) = let
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val ((*void*)) = hashtbl_insert_any (htbl, k0, x0)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
in
  // nothing
end (* end of [insert_any] *)

(* ****** ****** *)

implement
takeout (k0, res) = let
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val ans = hashtbl_takeout (htbl, k0, res)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
in
  ans
end (* end of [takeout] *)

implement
takeout_opt (k0) = let
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val opt = hashtbl_takeout_opt (htbl, k0)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
in
  opt
end (* end of [takeout_opt] *)

(* ****** ****** *)

implement
remove (k0) = ans where
{
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val ans = hashtbl_remove (htbl, k0)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
} (* end of [remove] *)

(* ****** ****** *)

implement
listize1 () = kxs where
{
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val kxs = hashtbl_listize1 (htbl)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
} (* end of [listize1] *)

(* ****** ****** *)

implement
takeout_all () = kxs where
{
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val kxs = hashtbl_takeout_all (htbl)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
} (* end of [takeout_all] *)

(* ****** ****** *)

implement
foreach_cloref(fwork) =
{
//
val htbl =
$UNSAFE.castvwtp0{HTBL}(the_hashtbl_ptr)
val kxs = hashtbl_foreach_cloref (htbl, fwork)
prval ((*void*)) = $UNSAFE.cast2void (htbl)
//
} (* end of [foreach_cloref] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [ghashtbl_chain.hats] *)
