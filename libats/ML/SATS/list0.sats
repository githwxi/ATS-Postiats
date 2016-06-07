(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: gmmhwxiATgmailDOTcom *)
(* Start time: May, 2012 *)

(* ****** ****** *)
//
// HX-2013-01:
// A rule of thumb for effect-annotation is that
// higher-order functions should not be annotated!
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

(*
typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose
*)

(* ****** ****** *)

#define nil0 list0_nil
#define cons0 list0_cons

(* ****** ****** *)
//
#define
list0_sing(x) list0_cons(x, list0_nil())
//
#define
list0_pair(x1, x2)
list0_cons(x1, list0_cons (x2, list0_nil()))
//
(* ****** ****** *)
//
castfn
list0_cast{x:t0p} (xs: list0(INV(x))):<> list0(x)
//
(* ****** ****** *)
//
castfn
list0_of_list
  {a:t@ype}(List(INV(a))):<> list0(a)
castfn
list0_of_list_vt
  {a:t@ype}(List_vt(INV(a))):<> list0(a)
//
(* ****** ****** *)
//
castfn
g0ofg1_list{a:t@ype}(List(INV(a))):<> list0(a)
castfn
g0ofg1_list_vt{a:t@ype}(List_vt(INV(a))):<> list0(a)
//
overload g0ofg1 with g0ofg1_list
overload g0ofg1 with g0ofg1_list_vt
//
(* ****** ****** *)
//
castfn
g1ofg0_list{a:t@ype}(list0(INV(a))):<> List0(a)
//
overload g1ofg0 with g1ofg0_list
//
(* ****** ****** *)

fun{a:t0p}
list0_make_sing (x: a):<> list0(a)
fun{a:t0p}
list0_make_pair (x1: a, x2: a):<> list0(a)

(* ****** ****** *)

fun{a:t0p}
list0_make_elt (n: int, x: a):<!exn> list0(a)

(* ****** ****** *)
//
symintr list0
//
fun{a:t0p}
list0_make_arrpsz{n:int}
  (psz: arrpsz(INV(a), n)):<!wrt> list0(a)
//
overload list0 with list0_make_arrpsz
//
(* ****** ****** *)
//
fun{}
list0_make_intrange_lr
  (l: int, r: int):<> list0(int)
fun{}
list0_make_intrange_lrd
  (l: int, r: int, d: int):<!exn> list0(int)
//
symintr list0_make_intrange
//
overload list0_make_intrange with list0_make_intrange_lr
overload list0_make_intrange with list0_make_intrange_lrd
//
(* ****** ****** *)

fun{a:t0p}
list0_is_nil (list0(a)):<> bool
fun{a:t0p}
list0_is_cons (list0(a)):<> bool

(* ****** ****** *)
//
fun{a:t0p}
list0_is_empty (list0(a)):<> bool
fun{a:t0p}
list0_isnot_empty (list0(a)):<> bool
//
overload iseqz with list0_is_empty
overload isneqz with list0_isnot_empty
//
(* ****** ****** *)
//
fun{a:t0p}
list0_head_exn
  (xs: list0(INV(a))):<!exn> (a)
fun{a:t0p}
list0_head_opt
  (xs: list0(INV(a))):<> Option_vt(a)
//
(* ****** ****** *)
//
fun{a:t0p}
list0_tail_exn
  (xs: SHR(list0(INV(a)))):<!exn> list0(a)
fun{a:t0p}
list0_tail_opt
  (xs: SHR(list0(INV(a)))):<> Option_vt(list0(a))
//
(* ****** ****** *)
//
overload .head with list0_head_exn
overload .tail with list0_tail_exn
//
(* ****** ****** *)
//
fun{a:t0p}
list0_length(list0(INV(a))):<> int
//
overload length with list0_length of 0
//
(* ****** ****** *)

fun{a:t0p}
list0_last_exn (xs: list0(INV(a))):<!exn> (a)
fun{a:t0p}
list0_last_opt (xs: list0(INV(a))):<> Option_vt(a)

(* ****** ****** *)
//
fun{a:t0p}
list0_nth_exn
  (xs: list0(INV(a)), i: int):<!exn> (a)
fun{a:t0p}
list0_nth_opt
  (xs: list0(INV(a)), i: int):<> Option_vt(a)
//
(* ****** ****** *)
//
fun{a:t0p}
list0_get_at_exn
  (xs: list0(INV(a)), index: int):<!exn> (a)
//
overload [] with list0_get_at_exn
//
(* ****** ****** *)
//
fun{a:t0p}
print_list0 (xs: list0(INV(a))): void
fun{a:t0p}
prerr_list0 (xs: list0(INV(a))): void
//
overload print with print_list0
overload prerr with prerr_list0
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_list0
(
  out: FILEref, xs: list0(INV(a))
) : void // end of [fprint_list0]
fun{a:t0p}
fprint_list0_sep
(
  out: FILEref, xs: list0(INV(a)), sep: string
) : void // end of [fprint_list0_sep]
//
overload fprint with fprint_list0
overload fprint with fprint_list0_sep
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_listlist0_sep
( out: FILEref
, xss: list0(list0(INV(a))), sep1: string, sep2: string
) : void // end of [fprint_list0_sep]
//
overload fprint with fprint_listlist0_sep
//
(* ****** ****** *)

fun{a:t0p}
list0_insert_at_exn
(
  SHR(list0(INV(a))), i: int, x: a
) :<!exn> list0(a) // endfun

(* ****** ****** *)
//
fun{a:t0p}
list0_remove_at_exn
  (SHR(list0(INV(a))), int):<!exn> list0(a)
// end of [list0_remove_at_exn]
//
fun{a:t0p}
list0_takeout_at_exn
(
  xs: SHR(list0(INV(a))), i: int, x: &a? >> a
) :<!exnwrt> list0(a) // end-of-function
//
overload remove_at with list0_remove_at_exn
overload takeout_at with list0_takeout_at_exn
//
(* ****** ****** *)
//
fun{a:t0p}
list0_append
(
  xs: NSH(list0(INV(a))), ys: SHR(list0(a))
) :<> list0(a)
//
overload + with list0_append
//
(* ****** ****** *)
//
fun{a:t0p}
list0_extend
  (xs: NSH(list0(INV(a))), y: a):<> list0(a)
//
macdef list0_snoc = list0_extend
//
(* ****** ****** *)

fun{a:t0p}
list0_reverse (xs: list0(INV(a))):<> list0(a)

fun{a:t0p}
list0_reverse_append
  (xs: list0(INV(a)), ys: list0(a)):<> list0(a)
// end of [list0_reverse_append]

macdef list0_revapp = list_reverse_append

(* ****** ****** *)
//
fun{a:t0p}
list0_concat
  (xss: NSH(list0(list0(INV(a))))):<> list0(a)
//
overload concat with list0_concat
//
(* ****** ****** *)

fun{a:t0p}
list0_take_exn
  (xs: NSH(list0(INV(a))), i: int):<!exn> list0(a)
// end of [list0_take_exn]

fun{a:t0p}
list0_drop_exn
  (xs: SHR(list0(INV(a))), i: int):<!exn> list0(a)
// end of [list0_drop_exn]

(* ****** ****** *)

fun
{a:t0p}
list0_app
(
  xs: list0(INV(a)), fwork: cfun(a, void)
) : void // end of [list0_app]

(* ****** ****** *)

fun{a:t0p}
list0_foreach
(
  xs: list0(INV(a)), fwork: cfun(a, void)
) : void // end of [list0_foreach]

fun{a:t0p}
list0_iforeach
(
 xs: list0(INV(a)), fwork: cfun2(int, a, void)
) : int(*length*) // end of [list0_iforeach]

(* ****** ****** *)

fun
{a1,a2:t0p}
list0_foreach2
(
  xs1: list0(INV(a1))
, xs2: list0(INV(a2))
, fwork: cfun2(a1, a2, void)
) : void // end of [list0_foreach2]

fun{a1,a2:t0p}
list0_foreach2_eq
(
  xs1: list0(INV(a1))
, xs2: list0(INV(a2))
, fwork: cfun2(a1, a2, void), sgn: &int? >> int
) : void // end of [list0_foreach2_eq]

(* ****** ****** *)
//
fun{
a:t0p}{res:t0p
} list0_foldleft
  (xs: list0(INV(a)), ini: res, fopr: cfun2(res, a, res)): res
//
fun{
a:t0p}{res:t0p
} list0_ifoldleft
  (xs: list0(INV(a)), ini: res, fopr: cfun3(res, int, a, res)): res
// end of [list0_ifoldleft]
//
(* ****** ****** *)

fun{
a1,a2:t0p}{res:t0p
} list0_foldleft2 (
  xs1: list0(INV(a1))
, xs2: list0(INV(a2))
, ini: res, fopr: cfun3(res, a1, a2, res)
) : res // end of [list0_foldleft2]

(* ****** ****** *)
//
fun{
a:t0p}{res:t0p
} list0_foldright
  (xs: list0(INV(a)), fopr: cfun2(a, res, res), snk: res): res
//
(*
fun{
a:t0p}{res:t0p
} list0_ifoldright
  (xs: list0(INV(a)), fopr: cfun3(int, a, res, res), snk: res): res
// end of [list0_ifoldright]
*)
//
(* ****** ****** *)
//
fun
{a:t0p}
list0_exists
  (xs: list0(INV(a)), p: cfun(a, bool)): bool
//
fun
{a1,a2:t0p}
list0_exists2
(
  xs1: list0(INV(a1))
, xs2: list0(INV(a2))
, pred: cfun2(a1, a2, bool)
) : bool // end of [list0_exists2]
//
(* ****** ****** *)
//
fun
{a:t0p}
list0_forall
  (xs: list0(INV(a)), p: cfun(a, bool)): bool
//
fun
{a1,a2:t0p}
list0_forall2 (
  xs1: list0(INV(a1))
, xs2: list0(INV(a2))
, pred: cfun2(a1, a2, bool)
) : bool // end of [list0_forall2]
fun
{a1,a2:t0p}
list0_forall2_eq
(
  xs1: list0(INV(a1))
, xs2: list0(INV(a2))
, p: cfun2(a1, a2, bool), sgn: &int? >> int
) : bool // end of [list0_forall2_eq]
//
(* ****** ****** *)

fun
{a:t0p}
list0_equal
(
  xs1: list0(INV(a))
, xs2: list0(INV(a)), eqfn: cfun2(a, a, bool)
) : bool // end of [list0_equal]

(* ****** ****** *)
//
fun
{a:t0p}
list0_find_exn
  (xs: list0(INV(a)), p: cfun(a, bool)): (a)
//
fun
{a:t0p}
list0_find_opt
  (xs: list0(INV(a)), p: cfun(a, bool)): Option_vt(a)
//
(* ****** ****** *)
//
fun{
a,b:t0p
} list0_assoc_exn
(
  list0 @(INV(a), b), x0: a, eq: cfun(a, a, bool)
) : (b) // end-of-function
fun{
a,b:t0p
} list0_assoc_opt
(
  list0 @(INV(a), b), x0: a, eq: cfun(a, a, bool)
) : Option_vt (b) // end-of-function
//
(* ****** ****** *)
//
fun{a:t0p}
list0_filter
  (list0(INV(a)), pred: cfun(a, bool)): list0(a)
//
(* ****** ****** *)
//
fun{
a:t0p}{b:t0p
} list0_map
(
  xs: list0(INV(a)), fopr: cfun(a, b)
) : list0(b) // end-of-function
//
fun{
a:t0p}{b:t0p
} list0_mapopt
(
  xs: list0(INV(a)), fopr: cfun(a, Option_vt(b))
) : list0(b) // end-of-function
//
(* ****** ****** *)
//
fun{a:t0p}
list0_mapcons
  (x0: a, xss: list0(list0(INV(a)))): list0(list0(a))
//
overload * with list0_mapcons
//
(* ****** ****** *)
//
fun{
a:t0p}{b:t0p
} list0_imap
  (xs: list0(INV(a)), fopr: cfun2(int, a, b)): list0(b)
//
(* ****** ****** *)

fun{
a1,a2:t0p}{b:t0p
} list0_map2
(
  xs: list0(INV(a1)), ys: list0(INV(a2)), fopr: cfun2(a1, a2, b)
) : list0(b) // end of [list0_map2]

(* ****** ****** *)
//
fun{a:t0p}
list0_tabulate
  (n: int, fopr: cfun(int, a)): list0(a)
fun{a:t0p}
list0_tabulate_opt
  (n: int, fopr: cfun(int, Option_vt(a))): list0(a)
//
(* ****** ****** *)
//
fun
{x,y:t0p}
list0_zip
(
  list0(INV(x)), list0(INV(y))
) :<> list0 @(x, y) // end-of-fun
//
(*
fun{
x,y:t0p}{z:t0p
} list0_zipwith
  (list0(INV(x)), list0(INV(y)), fopr: cfun2(x, y, z)): list0(z)
*)
macdef list0_zipwith = list0_map2
//
(* ****** ****** *)
//
fun
{x,y:t0p}
list0_cross
(
  list0(INV(x)), list0(INV(y))
) :<> list0 @(x, y) // end-of-fun
//
overload * with list0_cross
//
(* ****** ****** *)
//
fun{
x,y:t0p}{z:t0p
} list0_crosswith
(
  list0(INV(x)), list0(INV(y)), fopr: cfun2(x, y, z)
) : list0(z) // end of [list0_crosswith]
//
(* ****** ****** *)

fun{a:t0p}
list0_quicksort
  (xs: NSH(list0(INV(a))), cmp: (a, a) -<cloref> int):<> list0(a)
// end of [list0_quicksort]

(* ****** ****** *)

fun{a:t0p}
list0_mergesort
  (xs: NSH(list0(INV(a))), cmp: (a, a) -<cloref> int):<> list0(a)
// end of [list0_mergesort]

(* ****** ****** *)

(* end of [list0.sats] *)
