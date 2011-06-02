extern
fun{a,b:t@ype} f (x: a, y: b): (a, b)

implement{a,b} f (x, y) = (x, y)
implement(a,b) f<a,b> (x, y) = (x, y)

////

extern fun{a,b:t@ype} f (x: a): b
implement(
a:t@ype,b:t@ype
) fgh<a,b> (x) = x
implement{a}{b} fgh (x) = ...