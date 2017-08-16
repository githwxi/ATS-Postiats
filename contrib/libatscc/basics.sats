(*
** libatscc-common
*)
(* ****** ****** *)
//
typedef
fun0 (b:vt0p) = () -<fun1> b
typedef
fun1 (a:t0p, b:vt0p) = (a) -<fun1> b
typedef
fun2 (a1:t0p, a2:t0p, b:vt0p) = (a1, a2) -<fun1> b
typedef
fun3 (a1:t0p, a2:t0p, a3: t0p, b:vt0p) = (a1, a2, a3) -<fun1> b
//
(* ****** ****** *)
//
typedef
cfun0 (b:vt0p) = () -<cloref1> b
typedef
cfun1 (a:t0p, b:vt0p) = (a) -<cloref1> b
typedef
cfun2 (a1:t0p, a2:t0p, b:vt0p) = (a1, a2) -<cloref1> b
typedef
cfun3 (a1:t0p, a2:t0p, a3: t0p, b:vt0p) = (a1, a2, a3) -<cloref1> b
//
stadef cfun = cfun0
stadef cfun = cfun1
stadef cfun = cfun2
stadef cfun = cfun3
//
(* ****** ****** *)
//
fun
cloref2fun0
  {b:vt0p}
  (f: cfun0(b)): fun0(b) = "mac#%"
//
fun
cloref2fun1
  {a:t0p;b:vt0p}
  (f: cfun1(a, b)): fun1(a, b) = "mac#%"
//
fun
cloref2fun2
  {a1,a2:t0p;b:vt0p}
  (cfun2(a1, a2, b)): fun2(a1, a2, b) = "mac#%"
fun
cloref2fun3
  {a1,a2,a3:t0p;b:vt0p}
  (cfun3(a1, a2, a3, b)): fun3(a1, a2, a3, b) = "mac#%"
//
(* ****** ****** *)
//
fun
cloref0_app
  {b:vt0p}
  (f: cfun0(b)): b = "mac#%"
//
fun
cloref1_app
  {a:t0p;b:vt0p}
  (f: cfun1(a, b), a): b = "mac#%"
//
fun
cloref2_app
  {a1,a2:t0p;b:vt0p}
  (f: cfun2(a1, a2, b), a1, a2): b = "mac#%"
//
fun
cloref3_app
  {a1,a2,a3:t0p;b:vt0p}
  (f: cfun3(a1, a2, a3, b), a1, a2, a3): b = "mac#%"
//
symintr cloref_app
overload cloref_app with cloref0_app
overload cloref_app with cloref1_app
overload cloref_app with cloref2_app
overload cloref_app with cloref3_app
//
(* ****** ****** *)
//
// HX-2016-04:
// This is mostly for someone
// not familiar with dependent types
//
datatype
list0_t0ype_type
  (a:t@ype+) =
  | list0_nil of ((*void*))
  | list0_cons of (a, list0(a))
//
where
list0(a:t@ype) = list0_t0ype_type(a)
//
(* ****** ****** *)
//
castfn
g0ofg1_list : 
  {a:t0p}(List(a)) -<fun> list0(a)
castfn
list0_of_list :
  {a:t0p}(List(a)) -<fun> list0(a)
//
castfn
g1ofg0_list : 
  {a:t0p}(list0(a)) -<fun> List0(a)
castfn
list_of_list0 :
  {a:t0p}(list0(a)) -<fun> List0(a)
//
overload g0ofg1 with g0ofg1_list of 100
overload g1ofg0 with g1ofg0_list of 100
//
(* ****** ****** *)
//
castfn
g0ofg1_list_vt :
  {a:t0p}(List_vt(a)) -<fun> list0(a)
castfn
list0_of_list_vt :
  {a:t0p}(List_vt(a)) -<fun> list0(a)
//
overload g0ofg1 with g0ofg1_list_vt of 100
//
(* ****** ****** *)
//
datatype
option0_t0ype_type
(
  a: t@ype+
) = // option0_t0ype_type
  | Some0 of (a) | None0 of ()
//
where option0 = option0_t0ype_type
//
(* ****** ****** *)
//
castfn
g0ofg1_option :
  {a:t0p}(Option(a)) -<fun> option0(a)
castfn
option0_of_option :
  {a:t0p}(Option(a)) -<fun> option0(a)
//
overload g0ofg1 with g0ofg1_option of 100
//
(* ****** ****** *)
//
castfn
g0ofg1_option_vt :
  {a:t0p}(Option_vt(a)) -<fun> option0(a)
castfn
option0_of_option_vt :
  {a:t0p}(Option_vt(a)) -<fun> option0(a)
//
overload g0ofg1 with g0ofg1_option_vt of 100
//
(* ****** ****** *)
//
abstype
array0_vt0ype_type(a:vt@ype) = ptr
typedef
array0(a:vt@ype) = array0_vt0ype_type(a)
//
(* ****** ****** *)

(* end of [basics.sats] *)
