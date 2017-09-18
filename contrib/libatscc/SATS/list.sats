(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
macdef
list_sing(x) =
  list_cons(,(x), list_nil)
macdef
list_pair(x1, x2) =
  list_cons(,(x1), list_cons(,(x2), list_nil))
//
(* ****** ****** *)
//
fun{}
list_is_nil
  {a:t0p}{n:int}(list(a, n)): bool(n==0)
fun{}
list_is_cons
  {a:t0p}{n:int}(list(a, n)): bool(n > 0)
//
overload iseqz with list_is_nil of 100
overload isneqz with list_is_cons of 100
//
(* ****** ****** *)
//
fun
list_make_elt
  {x:t0p}{n:nat}
  (n: int n, x: x): list(x, n) = "mac#%"
// end of [list_make_elt]
//
(* ****** ****** *)
//
fun
list_make_intrange_2
  (l: int, r: int): List0(int) = "mac#%"
fun
list_make_intrange_3
  (l: int, r: int, d: int): List0(int) = "mac#%"
//
symintr list_make_intrange
//
overload
list_make_intrange with list_make_intrange_2
overload
list_make_intrange with list_make_intrange_3
//
(* ****** ****** *)
//
fun
{a:t0p}
print_list
  (List(INV(a))): void = "mac#%"
fun
{a:t0p}
print_list_sep
  (List(INV(a)), sep: string): void = "mac#%"
//
overload print with print_list of 100
//
(* ****** ****** *)
//
fun
list_length
  {a:t0p}{n:int}
  (xs: list(a, n)): int(n) = "mac#%"
//
overload length with list_length of 100
//
(* ****** ****** *)
//
fun
list_head
{x:t0p}{n:pos}
(list(INV(x), n)):<> (x) = "mac#%"
fun
list_tail
{x:t0p}{n:pos}
(SHR(list(INV(x), n))):<> list(x, n-1) = "mac#%"
//
(* ****** ****** *)
//
fun
list_last
  {a:t0p}{n:pos}
  (xs: list(INV(a), n)): (a) = "mac#%"
//
(* ****** ****** *)
//
fun
list_get_at
  {a:t0p}{n:int}
  (list(INV(a), n), natLt(n)): a = "mac#%"
//
overload [] with list_get_at of 100
//
(* ****** ****** *)
//
fun
list_snoc
  {a:t0p}{n:int}
  (list(INV(a), n), x0: a): list(a, n+1)= "mac#%"
//
fun
list_extend
  {a:t0p}{n:int}
  (list(INV(a), n), x0: a): list(a, n+1)= "mac#%"
//
(* ****** ****** *)
//
fun
list_append
  {a:t0p}{i,j:int}
  (list(INV(a), i), list(a, j)): list(a, i+j)= "mac#%"
//
overload + with list_append of 100 // infix
//
(* ****** ****** *)
//
fun
mul_int_list
  {a:t0p}
  {m,n:int | m >= 0}
  (m: int(m), xs: list(INV(a), n)): list(a, m*n) = "mac#%"
//
overload * with mul_int_list of 100 // infix
//
(* ****** ****** *)
//
fun
list_reverse
  {a:t0p}{n:int}
  (list(INV(a), n)): list(a, n) = "mac#%"
//
fun
list_reverse_append
  {a:t0p}{i,j:int}
  (list(INV(a), i), list(a, j)): list(a, i+j) = "mac#%"
//
overload reverse with list_reverse of 100
overload revappend with list_reverse_append of 100
//
(* ****** ****** *)
//
fun
list_concat
  {x:t0p}(xss: List(List(INV(x)))): List0(x) = "mac#%"
//
(* ****** ****** *)
//
fun
list_take
  {a:t0p}
  {n:int}
  {i:nat | i <= n}
  (xs: list(INV(a), n), i: int(i)): list(a, i) = "mac#%"
fun
list_drop
  {a:t0p}
  {n:int}
  {i:nat | i <= n}
  (xs: list(INV(a), n), i: int(i)): list(a, n-i) = "mac#%"
//
fun
list_split_at
  {a:t0p}
  {n:int}
  {i:nat | i <= n}
  (list(INV(a), n), int(i)): $tup(list(a, i), list(a, n-i)) = "mac#%"
//
(* ****** ****** *)
//
fun
list_insert_at
  {a:t0p}
  {n:int}
  {i:nat | i <= n}
  (list(INV(a), n), int(i), a): list(a, n+1) = "mac#%"
//
fun
list_remove_at
  {a:t0p}
  {n:int}{i:nat | i < n}
  (xs: list(INV(a), n), i: int(i)): list(a, n-1) = "mac#%"
fun
list_takeout_at
  {a:t0p}
  {n:int}{i:nat | i < n}
  (list(INV(a), n), int(i)): $tup(a, list(a, n-1)) = "mac#%"
//
(* ****** ****** *)
//
fun
list_exists
  {a:t0p}
(
  xs: List(INV(a)), pred: cfun(a, bool)
) : bool = "mac#%" // end-of-function
fun
list_exists_method
  {a:t0p}
(
  xs: List(INV(a)))(pred: cfun(a, bool)
) : bool = "mac#%" // end-of-function
//
overload .exists with list_exists_method
//
fun
list_iexists
  {a:t0p}
(
  xs: List(INV(a)), pred: cfun(Nat, a, bool)
) : bool = "mac#%" // end of [list_iexists]
fun
list_iexists_method
  {a:t0p}
(
  xs: List(INV(a)))(pred: cfun(Nat, a, bool)
) : bool = "mac#%" // end of [list_iexists]
//
overload .iexists with list_iexists_method
//
(* ****** ****** *)
//
fun
list_forall
  {a:t0p}
(
  xs: List(INV(a)), pred: cfun(a, bool)
) : bool = "mac#%" // end-of-function
fun
list_forall_method
  {a:t0p}
(
  List(INV(a)))(pred: cfun(a, bool)
) : bool = "mac#%" // end-of-function
//
overload .forall with list_forall_method
//
fun
list_iforall
  {a:t0p}
(
  xs: List(INV(a)), pred: cfun(Nat, a, bool)
) : bool = "mac#%" // end of [list_iforall]
fun
list_iforall_method
  {a:t0p}
(
  xs: List(INV(a)))(pred: cfun(Nat, a, bool)
) : bool = "mac#%" // end of [list_iforall]
//
overload .iforall with list_iforall_method
//
(* ****** ****** *)
//
fun
list_app
  {a:t0p}
(
  xs: List(INV(a)), fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
fun
list_foreach
  {a:t0p}
(
  xs: List(INV(a))
, fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
//
fun
list_foreach_method
  {a:t0p}
(
  xs: List(INV(a)))(fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
//
overload .foreach with list_foreach_method
//
(* ****** ****** *)
//
fun
list_iforeach
  {a:t0p}
(
  xs: List(INV(a))
, fwork: cfun(Nat, a, void)
) : void = "mac#%" // end-of-function
fun
list_iforeach_method
  {a:t0p}
(
  xs: List(INV(a)))(fwork: cfun(Nat, a, void)
) : void = "mac#%" // end-of-function
//
overload .iforeach with list_iforeach_method
//
(* ****** ****** *)
//
fun
list_rforeach
  {a:t0p}
(
  xs: List(INV(a)), fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
fun
list_rforeach_method
  {a:t0p}
(
  xs: List(INV(a)))(fwork: cfun(a, void)
) : void = "mac#%" // end-of-function
//
overload .rforeach with list_rforeach_method
//
(* ****** ****** *)
//
fun
list_filter
  {a:t0p}{n:int}
(
  xs: list(INV(a), n), pred: cfun(a, bool)
) : listLte(a, n) = "mac#%" // end-of-fun
fun
list_filter_method
  {a:t0p}{n:int}
(
  xs: list(INV(a), n))(pred: cfun(a, bool)
) : listLte(a, n) = "mac#%" // end-of-fun
//
overload .filter with list_filter_method
//
(* ****** ****** *)
//
fun
list_labelize
  {x:t0p}{n:int}
  (xs: list(INV(x), n)): list($tup(int, x), n)
// end of [list_labelize]
//
(* ****** ****** *)
//
fun
list_map
{a:t0p}
{b:t0p}{n:int}
(
  xs: list(INV(a), n), fopr: cfun(a, b)
) : list(b, n) = "mac#%" // end-of-function
fun
list_map_method
{a:t0p}{b:t0p}{n:int}
(
  xs: list(INV(a), n), TYPE(b))(fopr: cfun(a, b)
) : list(b, n) = "mac#%" // end-of-function
//
overload .map with list_map_method // HX: xs.map(TYPE{b})(...)
//
(* ****** ****** *)
//
fun
list_imap
{a:t0p}
{b:t0p}{n:int}
(
  xs: list(INV(a), n), fopr: cfun(Nat, a, b)
) : list(b, n) = "mac#%" // end-of-function
fun
list_imap_method
{a:t0p}{b:t0p}{n:int}
(
  xs: list(INV(a), n), TYPE(b))(fopr: cfun(Nat, a, b)
) : list(b, n) = "mac#%" // end-of-function
//
overload .imap with list_imap_method // HX: xs.imap(TYPE{b})(...)
//
(* ****** ****** *)
//
fun
list_map2
{a1,a2:t0p}
{b:t0p}{n1,n2:int}
(
  xs1: list(INV(a1), n1)
, xs2: list(INV(a2), n2), fopr: cfun(a1, a2, b)
) : list(b, min(n1,n2)) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
fun
list_foldleft
  {res:vt0p}{a:t0p}
(
  List(INV(a)), init: res, fopr: (res, a) -<cloref1> res
) : res = "mac#%" // end of [list_foldleft]
fun
list_foldleft_method
  {res:t@ype}{a:t0p}
(
  xs: List(INV(a)), init: res)(fopr: (res, a) -<cloref1> res
) : res = "mac#%" // end of [list_foldleft_method]
//
overload .foldleft with list_foldleft_method
//
(* ****** ****** *)
//
fun
list_ifoldleft
  {res:vt0p}{a:t0p}
(
  List(INV(a)), init: res, fopr: (Nat, res, a) -<cloref1> res
) : res = "mac#%" // end of [list_foldleft]
fun
list_ifoldleft_method
  {res:t@ype}{a:t0p}
(
  xs: List(INV(a)), init: res)(fopr: (Nat, res, a) -<cloref1> res
) : res = "mac#%" // end of [list_foldleft_method]
//
overload .ifoldleft with list_ifoldleft_method
//
(* ****** ****** *)
//
fun
list_foldright
  {a:t0p}{res:vt0p}
(
  List(INV(a)), fopr: (a, res) -<cloref1> res, sink: res
) : res = "mac#%" // end of [list_foldright]
//
fun
list_foldright_method
  {a:t0p}{res:t@ype}
(
  xs: List(INV(a)), sink: res)(fopr: (a, res) -<cloref1> res
) : res = "mac#%" // end of [list_foldright]
//
overload .foldright with list_foldright_method
//
(* ****** ****** *)
//
fun
list_ifoldright
  {a:t0p}{res:vt0p}
(
  List(INV(a)), fopr: (Nat, a, res) -<cloref1> res, sink: res
) : res = "mac#%" // end of [list_foldright]
//
fun
list_ifoldright_method
  {a:t0p}{res:t@ype}
(
  xs: List(INV(a)), sink: res)(fopr: (Nat, a, res) -<cloref1> res
) : res = "mac#%" // end of [list_foldright]
//
overload .ifoldright with list_ifoldright_method
//
(* ****** ****** *)
//
fun
{a:t0p}
list_sort_1
  {n:int}
  (list(INV(a), n)): list(a, n) = "mac#%"
//
fun
list_sort_2
  {a:t0p}{n:int}
(
  list(INV(a), n), cmp: (a, a) -<cloref1> int
) : list(a, n) = "mac#%"
//
symintr list_sort
overload list_sort with list_sort_1 of 100
overload list_sort with list_sort_2 of 100
//
(* ****** ****** *)
//
fun
list_mergesort
{a:t0p}{n:int}
(
  list(INV(a), n), cmp: (a, a) -<cloref1> int
) : list(a, n) = "mac#%"
//
(* ****** ****** *)
//
fun
streamize_list_elt
  {a:t0p}
(
xs: List(INV(a))
) :<> stream_vt(a) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
fun
streamize_list_zip
  {a,b:t0p}
(
  List(INV(a))
, List(INV(b))
) :<> stream_vt($tup(a,b)) = "mac#%" // end-of-fun
//
fun
streamize_list_cross
  {a,b:t0p}
(
  xs: List(INV(a))
, ys: List(INV(b))
) :<> stream_vt($tup(a,b)) = "mac#%" // end-of-fun
//
(* ****** ****** *)

(* end of [list.sats] *)
