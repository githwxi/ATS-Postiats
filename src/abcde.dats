abst@ype int_t0ype
abst@ype int = int_t0ype
abst@ype intfun = (0, int_t0ype) -> int_t0ype
////
stacst gte_int_int : (int, int) -> bool
stacst >= : (int, int) -> bool
stacst gte_char_char : (char, char) -> bool
stacst >= : (char, char) -> bool
sortdef int1 = int
sortdef intfun = (int, int) -> int1
sortdef tt = {a:bool | a}
sortdef xyz = { f: intfun | f (0, 1) -> f }
////
sortdef nat = {a:int -> int | a -<fun> a }
////
val x = 1: ref@ (int)
////
#define f(n, x) if n > 0 then x * f (n-1, x) else 1
#define x10 f(10, x)
macdef pow10 (x) = f (10, x)
////
#define x 2
#define y 1
#define f (x, y) (if x > 0 then x * f (x-1, y) else y+1)
#print "f (10, 1) = "; #print f (10, 1) ; #print "\n"
#define f (x, y, z) (1000 * (1000 * x * x + y) + z)
#print "f (x, y, 2) = " ; #print f (x, y, 2) #print "\n"
#if f (x, y, 2) > 1001001 #then
#print "Hello, world!\n"
#else
#print "Cruel, world!\n"
#endif

////

#define f (x, y) %(x - y)
// #define f (x) if x > 0 then x * f %(x-1) else 1

#define sing (x) cons (x, nil ())

#if f (1, 1) #then
#endif


val x = if x then (if x then y) else z
val x = try :(i:int) => x; y; z with | A () => 1 | B (x, y, z) => x + y
////
val x = $effmask_ref (x)
////
val x = $A. f< int > (x)
////
val x = $A.f<int> (x)
////
val x = #[x, y, z | xyz]
val x = case+ x of cons (x, nil()) => x | _ => y
val
rec cons (x, xs) = A.x + xs
macdef f {x} (x) {y} (y, z) = x + y
val f = fix f (x) (y, z) => x + x * y * z
val f = lam (x: int) (y: string) : int =<cloref> x + x + y
fun f (x) = if x > x then x + x else y
////
#ifdef XYZ
#print "XYZ is defined\n"
#endif
////
classdec abcde : f (x)

#undef abcde

symintr abcde fghij ;
symelim abcde fghij ;

exception FOO of (msg: string)

#include "abcde1"

extern
fun f (x: int, y: char) (z: double) : bool

extern
fun{X:t@ype}{Y:viewt@ype}
g {a,b:int;c:bool | a >= b} (x: int (a), y: char) (z: double) : bool

////

local

// prefix  00 ! (* static *)

prefix  99 ! (* dynamic *)

// postfix 80  .lab // dynamic
// postfix 80 ->lab // dynamic
// prefix  79  &    // dynamic

// infixl  70 app
// postfix 69 ?

in

prefix  61 ~

infixl 60 * /
infixl ( * ) imul imul1 imul2 nmul umul
infixl ( / ) idiv idiv1 idiv2 idiv3 ndiv udiv

infixl 20 ->
// infixr 20 ->
// infix  20 ->
// nonfix ->

infixl 20 > >= < <=

end

stacst + : (int, int) -> int * int

datasort intlst = intlst_nil of () | intlst_cons of (int, intlst)

sortdef nat = {a: int | a >= 0; a > 0}

stadef xyz (x:int, y) z = int (n)
typedef int2 = int * int
    and int3 = (int, int, int)
    and pair (a: int, b: double): t0ype = @(a | b)
    and intrec (a, b: float) = @{x= a, y= $ABC.b}
    and intext (a) = $extype_struct "foo" of {x= a, y= a, z= @(a, a) }
    and Nat = {a:int} int (a) -> [a,b,c:int | a >= 0] int (a)
typedef xyz = x >> y
typedef xyz = !x >> y
typedef xyz = &x >> y
typedef xyz = x -<0> y
typedef xyz = lam x (x:int, y:int) z => x + y + z
typedef xyz = 'a' -> 'b'

assume f (X) = @(int (X), X) -> X * Y * Z

abstype X (a:t@ype+) = list0

stavar X : int

datasort int = int_Z | int_S of (int)

datatype list (a:t@ype+) = list_nil | list_cons of (a, list (a))
dataviewtype list_vt (a:t@ype+, int) = list_vt_nil (0) | list_vt_cons (i+i) of (a, list (a))
dataview option_v (v:view+) = option_v_none | option_v_some of (v)
dataprop option_p (p:prop+) = option_p_none | option_p_some of (p)

extern fun f (x: int): int

////

fun f (x) = let
implement d0eclst_cons (x, xs) = cons (x, xs)
implement x = y
fun f (x) = x + 1
fun f (x) = x
in

end
////
abstype pair (a:t@ype, t@ype) = {c:type} (c) -> (a, b)
////
val x = let val x = x + y in end
////
val x = A.1 + A.xyz + A->123 + A->[1,2,3] + (addr@(A)+B)->abc
////
val x = $M.A[1,3]
////
stadef t = @{
, type= int : type+
, prop= int : prop+
, view= int : view-
, viewtype= int : viewtype-
}
////
val xyz = $T.f<int> (x)
////
fun f {i:nat | i > 0} (x: int i) = x + x
////
val x = ((*none*) | x, y)
////
val x = scase xs of cons (x, xs) => x + xs | nil () => 0

val x = begin x ; y ; z end
val x = (x; y; z;)
val x = case+ (if x then y else z) of 1 => 1 | _ => 2 | cons (x, _) => x
////
val x = x.1 (1) + y(.abc)(.0) 1.
////
implement{a}{a,c}
f<int,int><list(char)> {n:nat} (x: a): @(a, c) = x + x
val f = fix f (x): int =<> if x > 0 then x * f (x - 1) else 1
val x = lam (x: int, y, z) x y z (x: string): bool =<0,1,!ref> A[x,y][1,2,3,4,5]

exception FOO of (string)
