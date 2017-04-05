(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../../basics.sats"
*)

(* ****** ****** *)

#define nil0 list0_nil
#define cons0 list0_cons
#define sing0(x) list0_cons(x, list0_nil)

(* ****** ****** *)
//
fun{}
list0_sing{a:t0p}(x: a): list0(a)
fun{}
list0_pair{a:t0p}(x: a, y: a): list0(a)
//
(* ****** ****** *)
//
fun{}
list0_is_nil
  {a:t0p}(xs: list0(INV(a))): bool
//
fun{}
list0_is_cons
  {a:t0p}(xs: list0(INV(a))): bool
//
overload iseqz with list0_is_nil
overload isneqz with list0_is_cons
//
(* ****** ****** *)
//
fun
list0_head_opt
  {a:t0p}
  (list0(INV(a))): Option_vt(a) = "mac#%"
//
fun
list0_tail_opt
  {a:t0p}
  (list0(INV(a))): Option_vt(list0(a)) = "mac#%"
//
overload .head_opt with list0_head_opt of 100
overload .tail_opt with list0_tail_opt of 100
//
(* ****** ****** *)
//
fun
list0_length
  {a:t0p}
  (xs: list0(a)): intGte(0) = "mac#%"
//
overload length with list0_length of 100
//
(* ****** ****** *)
//
fun
list0_last_opt
  {a:t0p}
(
xs: list0(INV(a))
) : Option_vt(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
list0_init_opt
  {a:t0p}
(
xs: list0(INV(a))
) : Option_vt(list0(a)) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
list0_get_at_opt
  {a:t0p}
(
xs: list0(INV(a)), i: intGte(0)
) : Option_vt(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
list0_make_elt
  {a:t0p}
  (n: intGte(0), x: a): list0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
list0_make_intrange_2
  (l0: int, r0: int): list0(int) = "mac#%"
fun
list0_make_intrange_3
  (l0: int, r0: int, d: int): list0(int) = "mac#%"
//
symintr list0_make_intrange
//
overload
list0_make_intrange with list0_make_intrange_2
overload
list0_make_intrange with list0_make_intrange_3
//
(* ****** ****** *)
//
fun
{a:t0p}
print_list0
  (xs: list0(INV(a))): void = "mac#%"
fun
{a:t0p}
print_list0_sep
  (xs: list0(INV(a)), sep: string): void = "mac#%"
//
overload
print with print_list0 of 100
//
(* ****** ****** *)
//
fun
list0_snoc
  {a:t0p}
  (list0(INV(a)), x0: a): list0(a)= "mac#%"
//
fun
list0_extend
  {a:t0p}
  (list0(INV(a)), x0: a): list0(a)= "mac#%"
//
(* ****** ****** *)
//
fun
list0_append
  {a:t0p}
(
  xs: list0(INV(a)), ys: list0(a)
) : list0(a) = "mac#%" // end-of-fun
//
overload + with list0_append of 100 // infix
//
(* ****** ****** *)
//
fun
mul_int_list0
  {a:t0p}
(
m0: intGte(0), xs: list0(a)
) : list0(a) = "mac#%" // end-of-function
//
overload * with mul_int_list0 of 100 // infix
//
(* ****** ****** *)
//
fun
list0_reverse
  {a:t0p}
  (xs: list0(INV(a))): list0(a) = "mac#%"
fun
list0_reverse_append
  {a:t0p}
  (xs: list0(INV(a)), ys: list0(a)): list0(a) = "mac#%"
//
overload reverse with list0_reverse of 100
overload revappend with list0_reverse_append of 100
//
(* ****** ****** *)
//
fun
list0_concat
  {a:t0p}(xs: list0(list0(a))): list0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
list0_remove_at_opt
  {a:t0p}
(
  xs: list0(INV(a)), i: intGte(0)
) : Option_vt(list0(a)) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
list0_exists
  {a:t0p}
  (list0(INV(a)), pred: cfun(a, bool)): bool = "mac#%"
fun
list0_exists_method
  {a:t0p}
  (list0(INV(a)))(pred: cfun(a, bool)): bool = "mac#%"
//
overload .exists with list0_exists_method
//
fun
list0_iexists
  {a:t0p}
(
  xs: list0(INV(a)), pred: cfun(intGte(0), a, bool)
) : bool = "mac#%" // end of [list0_iexists]
fun
list0_iexists_method
  {a:t0p}
(
  xs: list0(INV(a)))(pred: cfun(intGte(0), a, bool)
) : bool = "mac#%" // end of [list0_iexists]
//
overload .iexists with list0_iexists_method
//
(* ****** ****** *)
//
fun
list0_forall
  {a:t0p}
  (list0(INV(a)), pred: cfun(a, bool)): bool = "mac#%"
fun
list0_forall_method
  {a:t0p}
  (list0(INV(a)))(pred: cfun(a, bool)): bool = "mac#%"
//
overload .forall with list0_forall_method
//
fun
list0_iforall
  {a:t0p}
(
  xs: list0(INV(a)), pred: cfun(intGte(0), a, bool)
) : bool = "mac#%" // end of [list0_iforall]
fun
list0_iforall_method
  {a:t0p}
(
  xs: list0(INV(a)))(pred: cfun(intGte(0), a, bool)
) : bool = "mac#%" // end of [list0_iforall]
//
overload .iforall with list0_iforall_method
//
(* ****** ****** *)
//
fun
list0_app
  {a:t0p}
(
  xs: list0(INV(a)), fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
fun
list0_foreach
  {a:t0p}
(
  xs: list0(INV(a)), fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
fun
list0_foreach_method
  {a:t0p}
(
  xs: list0(INV(a)))(fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
//
overload .foreach with list0_foreach_method
//
(* ****** ****** *)
//
fun
list0_iforeach
  {a:t0p}
(
  xs: list0(INV(a)), fwork: cfun(int, a, void)
) : void = "mac#%" // end-of-function
fun
list0_iforeach_method
  {a:t0p}
(
  xs: list0(INV(a)))(fwork: cfun(int, a, void)
) : void = "mac#%" // end-of-function
//
overload .iforeach with list0_iforeach_method
//
(* ****** ****** *)
//
fun
list0_rforeach
  {a:t0p}
  (xs: list0(INV(a)), fwork: cfun(a, void)): void = "mac#%"
fun
list0_rforeach_method
  {a:t0p}
  (xs: list0(INV(a)))(fwork: cfun(a, void)): void = "mac#%"
//
overload .rforeach with list0_rforeach_method
//
(* ****** ****** *)
//
fun
list0_filter
  {a:t0p}
(
  xs: list0(INV(a)), pred: cfun(a, bool)
) : list0(a) = "mac#%" // end-of-function
fun
list0_filter_method
  {a:t0p}
(
  xs: list0(INV(a)))(pred: cfun(a, bool)
) : list0(a) = "mac#%" // end-of-function
//
overload .filter with list0_filter_method
//
(* ****** ****** *)
//
fun
list0_map
  {a:t0p}{b:t0p}
  (list0(INV(a)), fopr: cfun(a, b)): list0(b) = "mac#%"
fun
list0_map_method
  {a:t0p}{b:t0p}
  (list0(INV(a)), TYPE(b))(fopr: cfun(a, b)): list0(b) = "mac#%"
//
overload .map with list0_map_method
//
(* ****** ****** *)
//
fun
list0_mapcons
  {a:t0p}
  (x0: a, xss: list0(list0(INV(a)))): list0(list0(a)) = "mac#%"
//
(* ****** ****** *)
//
fun
list0_find_opt
  {a:t0p}
(
  xs: list0(INV(a)), pred: cfun(a, bool)
) : Option_vt(a) = "mac#%" // end-of-fun
fun
list0_find_opt_method
  {a:t0p}
(
  xs: list0(INV(a)))(pred: cfun(a, bool)
) : Option_vt(a) = "mac#%" // end-of-fun
//
overload .find_opt with list0_find_opt_method
//
(* ****** ****** *)
//
fun
list0_zip
  {a1,a2:t0p}
(
  xs: list0(INV(a1)), ys: list0(INV(a2))
) :<> list0($tup(a1, a2)) = "mac#%" // end-of-fun
//
fun
list0_zipwith
  {a1,a2:t0p}{b:t0p}
(
  xs: list0(INV(a1)), ys: list0(INV(a2)), fopr: cfun(a1, a2, b)
) :<1> list0(b) = "mac#%" // end of [list0_zipwith]
//
fun
list0_zipwith_method
  {a1,a2:t0p}{b:t0p}
(
  xs: list0(INV(a1)), ys: list0(INV(a2)))(fopr: cfun(a1, a2, b)
) :<1> list0(b) = "mac#%" // end of [list0_zipwith_method]
//
overload .map2 with list0_zipwith_method
overload .zipwith with list0_zipwith_method
//
(* ****** ****** *)
//
fun
list0_foldleft
  {res:t0p}{a:t0p}
(
  list0(INV(a)), init: res, fopr: cfun(res, a, res)
) : res = "mac#%" // end-of-function
fun
list0_foldright
  {a:t0p}{res:t0p}
(
  list0(INV(a)), fopr: cfun(a, res, res), sink: res
) : res = "mac#%" // end-of-function
//
fun
list0_foldleft_method
  {res:t0p}{a:t0p}
(
  list0(INV(a)), init: res)(fopr: cfun(res, a, res)
) : res = "mac#%" // end-of-function
fun
list0_foldright_method
  {a:t0p}{res:t0p}
(
  list0(INV(a)), sink: res)(fopr: cfun(a, res, res)
) : res = "mac#%" // end-of-function
//
overload .foldleft with list0_foldleft_method
overload .foldright with list0_foldright_method
//
(* ****** ****** *)
//
fun
{a:t0p}
list0_sort_1
  (list0(INV(a))): list0(a) = "mac#%"
//
fun
list0_sort_2
  {a:t0p}
(
  list0(INV(a)), cmp: (a, a) -<cloref1> int
) : list0(a) = "mac#%"
//
symintr list0_sort
overload list0_sort with list0_sort_1 of 100
overload list0_sort with list0_sort_2 of 100
//
(* ****** ****** *)
//
fun
streamize_list0_zip
  {a,b:t0p}
(
  xs: list0(INV(a))
, ys: list0(INV(b))
) :<>
  stream_vt($tup(a,b)) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
streamize_list0_cross
  {a,b:t0p}
(
  xs: list0(INV(a))
, ys: list0(INV(b))
) :<>
  stream_vt($tup(a,b)) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
streamize_list0_nchoose
  {a:t0p}
(
  xs: list0(INV(a)), n: intGte(0)
) :<> stream_vt(list0(a)) = "mac#%" // end-of-fun
fun
streamize_list0_nchoose_rest
  {a:t0p}
(
  xs: list0(INV(a)), n: intGte(0)
) :<> stream_vt($tup(list0(a), list0(a))) = "mac#%"
//
(* ****** ****** *)

(* end of [list0.sats] *)
