(*
** A package for finite sets of integers
*)

(* ****** ****** *)

abstype intset // this is a boxed abstract type

(* ****** ****** *)

// empty set
val intset_empty : intset

// singleton set of [x]
fun intset_make_sing (x: int): intset

// turning a list into a set
fun intset_make_list (xs: list0 int): intset

// turning a set into a list
fun intset_listize (xs: intset): list0 int

// membership test
fun intset_ismem (xs: intset, x: int): bool

// computing the size of [xs]
fun intset_size (xs: intset): int

// adding [x] into [xs]
fun intset_add (xs: intset, x: int): intset

// deleting [x] from [xs]
fun intset_del (xs: intset, x: int): intset

// union of [xs1] and [xs2]
fun intset_union (xs1: intset, xs2: intset): intset

// intersection of [xs1] and [xs2]
fun intset_inter (xs1: intset, xs2: intset): intset

// difference between [xs1] and [xs2]
fun intset_differ (xs1: intset, xs2: intset): intset

(* ****** ****** *)

(* end of [intset.sats] *)
