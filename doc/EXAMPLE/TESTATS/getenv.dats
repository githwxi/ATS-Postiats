(* ****** ****** *)
(*
HX-2018-05-26: 
https://stackoverflow.com/questions/50503884/implementing-getenv-in-ats
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#staload UN = $UNSAFE
//
#staload "prelude/DATS/parray.dats"
//
(* ****** ****** *)

%{^

char*
key2val(char *k, char *kv)
{
  size_t n = strlen(k);
  int cmp = strncmp(k, kv, n);
  if (cmp != 0) return (char*)0;
  return (kv[n] != '=' ? (char*)0 : &kv[n+1]);
}

%}

(* ****** ****** *)

abstype envp = ptr

extern
fun
getenv(key: string, envp: envp): stropt

(* ****** ****** *)

implement
getenv
(key, envp) = let
//
val
envp =
$UN.cast{Ptr1}(envp)
//
prval
(pf, fpf) =
mycast(envp) where {
  extern
  prfun
  mycast{l:addr}(ptr(l)):
  [n:nat] vtakeout0(parray_v(string, l, n))
}
//
fun
loop
{l:addr}{n:nat}
( pf: !
  parray_v
  (string, l, n)
| p0: ptr(l)): stropt =
(
if
parray_isnot_empty(pf | p0)
then let
prval parray_v_cons(pf1, pf2) = pf
  val opt =
  $extfcall(stropt, "key2val", key, !p0)
in
  if
  stropt_is_some(opt)
  then
  (
    pf := parray_v_cons(pf1, pf2); opt
  )
  else let
    val opt =
    loop(pf2 | ptr_succ<string>(p0))
  in
    pf := parray_v_cons(pf1, pf2); opt
  end // end of [else]
end // end of [then]
else stropt_none((*void*))
)
//
in
  let val res = loop(pf | envp); prval () = fpf(pf) in res end
end (* end of [getenv] *)

(* ****** ****** *)

implement
main0
(argc, argv, envp) = {
val () =
println!
("getenv(msg) = ", getenv("msg", $UN.cast{envp}(envp)))
val () =
println!
("getenv(emp) = ", getenv("emp", $UN.cast{envp}(envp)))
}

(* ****** ****** *)

(* end of [getenv.dats] *)
