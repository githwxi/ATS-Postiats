(*
Author: Artyom Shalkhakov

Hello,

So I have a simple example of a "type pun".

In OpenGL, when using buffer objects (basically, arrays of flat elements
residing in GPU memory), it is necessary to "explain" to the API the layout
of an element in an array.

For instance,

// one vertex is a triple for x-y-z coordinates
// combined with a pair for s-t texture coordinates
struct vertex_s { float position[3]; float texcoord[3]; };
...
// this says that vertex position is given by 3 consecutive floats,
// starting at offset 0, and that the element size is sizeof(vertex_s)
glVertexPointer(3, GL_FLOAT, sizeof(vertex_s), 0);
// this says that texture coordinates are given by 2 consecutive floats,
// starting at the offset of [texcoord] in the [vertex_s] structure
glTexturePointer(2, GL_FLOAT, sizeof(vertex_s), offsetof(vertex_s, texcoord));
// actual drawing calls omitted

So, we just specified that an array of vertices can be seen as two separate
arrays with "holes" between elements. I'm wondering if offsetof can be given
a type in ATS which is not too cumbersome to use?
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
typedef
struct {
  float position[3]; float texcoord[3];
} vertex_s ;

#define vertex_s_get_position(x) (&((vertex_s*)x)->position[0])
#define vertex_s_get_texcoord(x) (&((vertex_s*)x)->texcoord[0])
%}

(* ****** ****** *)

abst@ype vertex_s = $extype"vertex_s"

(* ****** ****** *)
//
(*
vtypedef
vtakeoutptr
  (a:vt@ype) = [l:addr] (a@l, a@l -<lin,prf> void | ptr l)
*)
typedef GL_FLOAT = float
extern
fun vertex_s_get_position
  (vs: &vertex_s): vtakeoutptr (array (GL_FLOAT, 3)) = "mac#"
extern
fun vertex_s_get_texcoord
  (vs: &vertex_s): vtakeoutptr (array (GL_FLOAT, 3)) = "mac#"
//
(* ****** ****** *)

extern
fun{}
position$fwork (&array(GL_FLOAT, 3)): void

extern
fun{}
vertex_foreach_position
  {n:int} (!arrayptr (vertex_s, n), size_t n): void

implement{}
vertex_foreach_position (A, n) = let
//
implement(env)
array_foreach$fwork<vertex_s><env> (x, env) =
{
  val (pf, fpf | p) = vertex_s_get_position (x)
  val () = position$fwork (!p)
  prval () = fpf (pf)
}
//
val _(*asz*) = arrayptr_foreach (A, n)
//
in
  // nothing
end // end of [vertex_foreach_position]

(* ****** ****** *)

extern
fun{}
texcoord$fwork (&array(GL_FLOAT, 3)): void

extern
fun{}
vertex_foreach_texcoord
  {n:int} (!arrayptr (vertex_s, n), size_t n): void

implement{}
vertex_foreach_texcoord (A, n) = let
//
implement(env)
array_foreach$fwork<vertex_s><env> (x, env) =
{
  val (pf, fpf | p) = vertex_s_get_texcoord (x)
  val () = texcoord$fwork (!p)
  prval () = fpf (pf)
}
//
val _(*asz*) = arrayptr_foreach (A, n)
//
in
  // nothing
end // end of [vertex_foreach_texcoord]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [offsetof.dats] *)
