/*
(*
** ATS2CPP:
** API for STL:deque
*)
(* ****** ****** *)
(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)
*/
/* ****** ****** */
//
// Author: Hongwei Xi
// Authoremal: gmhwxiATgmailDOTcom
// Start Time: December, 2016
//
/* ****** ****** */
//
#ifndef ATS2CPP_STL_CATS_DEQUE
#define ATS2CPP_STL_CATS_DEQUE
//
/* ****** ****** */
//
#include <deque>
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr(elt) std::deque<elt>*
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr_new(elt) \
  new std::deque<elt>(/* empty */)
#define \
ats2cpp_STL_dequeptr_new_fill(elt, asz, val) \
  new std::deque<elt>(asz, *(static_cast<elt*>(val)))
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr_free(elt, p0) \
  delete(static_cast<std::deque<elt>*>(p0))
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr_size(elt, p0) \
  (static_cast<std::deque<elt>*>(p0))->size()
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr_back(elt, p0) \
  (static_cast<std::deque<elt>*>(p0))->back()
//
#define \
ats2cpp_STL_dequeptr_front(elt, p0) \
  (static_cast<std::deque<elt>*>(p0))->front()
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr_pop_back(elt, p0) \
  (static_cast<std::deque<elt>*>(p0))->pop_back()
//
#define \
ats2cpp_STL_dequeptr_pop_front(elt, p0) \
  (static_cast<std::deque<elt>*>(p0))->pop_front()
//
/* ****** ****** */
//
#define \
ats2cpp_STL_dequeptr_push_back(elt, p0, x0) \
  (static_cast<std::deque<elt>*>(p0))->push_back(x0)
//
#define \
ats2cpp_STL_dequeptr_push_front(elt, p0, x0) \
  (static_cast<std::deque<elt>*>(p0))->push_front(x0)
//
/* ****** ****** */
//
#endif // end of ifndef(ATS2CPP_STL_CATS_DEQUE)
//
/* ****** ****** */

/* end of [deque.cats] */
