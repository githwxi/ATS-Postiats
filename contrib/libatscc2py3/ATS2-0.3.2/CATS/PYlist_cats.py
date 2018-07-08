######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
# beg of [PYlist_cats.py]
######

######
import functools
######

############################################

def ats2pypre_PYlist_nil(): return []
def ats2pypre_PYlist_sing(x): return [x]
def ats2pypre_PYlist_pair(x1, x2): return [x1, x2]

############################################

def ats2pypre_PYlist_cons(x0, xs): return xs.insert(0, x0)

############################################

def ats2pypre_PYlist_make_elt(n, x):
  res = []
  while (n > 0): n = n - 1; res.append(x)
  return res

############################################

def ats2pypre_PYlist_is_nil(xs): return not(xs)
def ats2pypre_PYlist_is_cons(xs): return True if xs else False
def ats2pypre_PYlist_isnot_nil(xs): return True if xs else False

############################################

def ats2pypre_PYlist_length(xs): return xs.__len__()

############################################

def ats2pypre_PYlist_get_at(xs, ind): return xs[ind]
def ats2pypre_PYlist_set_at(xs, ind, x): xs[ind] = x; return

############################################

def ats2pypre_PYlist_copy(xs):
  res = []
  for x in iter(xs): res.append(x)
  return res

############################################

def ats2pypre_PYlist_append(xs, x): xs.append(x); return
def ats2pypre_PYlist_extend(xs1, xs2): xs1.extend(xs2); return

############################################

def ats2pypre_PYlist_pop_0(xs): return xs.pop()
def ats2pypre_PYlist_pop_1(xs, i): return xs.pop(i)

############################################

def ats2pypre_PYlist_insert(xs, i, x): xs.insert(i, x); return

############################################

def ats2pypre_PYlist_map(xs, f): return list(map(f, xs))
def ats2pypre_PYlist_filter(xs, f): return list(filter(f, xs))

############################################

def ats2pypre_PYlist_string_join(xs): return ''.join(xs)

############################################

def \
ats2pypre_PYlist_reduce(xs, ini, f):
  res = ini
  for x in iter(xs): res = f(res, x)
  return res

############################################

def ats2pypre_PYlist2list_rev(xs):
  res = ats2pypre_list_nil()
  for x in iter(xs): res = ats2pypre_list_cons(x, res)
  return res

############################################
#
def ats2pypre_PYlist_sort_2(xs, cmp):
  xs.sort(key=functools.cmp_to_key(ats2pypre_cloref2fun2(cmp))); return
#
############################################

###### end of [PYlist_cats.py] ######
