######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
#beg of [integer_cats.py]
######

############################################
#
def ats2pypre_abs_int0(x): return abs(x)
#
############################################
#
def ats2pypre_neg_int0(x): return ( -x )
def ats2pypre_neg_int1(x): return ( -x )
#
############################################
#
def ats2pypre_succ_int0(x): return (x + 1)
def ats2pypre_succ_int1(x): return (x + 1)
#
def ats2pypre_pred_int0(x): return (x - 1)
def ats2pypre_pred_int1(x): return (x - 1)
#
############################################
#
def ats2pypre_add_int0_int0(x, y): return (x + y)
def ats2pypre_add_int1_int1(x, y): return (x + y)
#
def ats2pypre_sub_int0_int0(x, y): return (x - y)
def ats2pypre_sub_int1_int1(x, y): return (x - y)
#
def ats2pypre_mul_int0_int0(x, y): return (x * y)
def ats2pypre_mul_int1_int1(x, y): return (x * y)
#
def ats2pypre_div_int0_int0(x, y): return (x // y)
def ats2pypre_div_int1_int1(x, y): return (x // y)
#
def ats2pypre_mod_int0_int0(x, y): return (x % y)
def ats2pypre_mod_int1_int1(x, y): return (x % y)
def ats2pypre_nmod_int1_int1(x, y): return (x % y)
#
############################################
#
def ats2pypre_lt_int0_int0(x, y): return (x < y)
def ats2pypre_lt_int1_int1(x, y): return (x < y)
#
def ats2pypre_lte_int0_int0(x, y): return (x <= y)
def ats2pypre_lte_int1_int1(x, y): return (x <= y)
#
def ats2pypre_gt_int0_int0(x, y): return (x > y)
def ats2pypre_gt_int1_int1(x, y): return (x > y)
#
def ats2pypre_gte_int0_int0(x, y): return (x >= y)
def ats2pypre_gte_int1_int1(x, y): return (x >= y)
#
def ats2pypre_eq_int0_int0(x, y): return (x == y)
def ats2pypre_eq_int1_int1(x, y): return (x == y)
#
def ats2pypre_neq_int0_int0(x, y): return (x != y)
def ats2pypre_neq_int1_int1(x, y): return (x != y)
#
############################################
#
def ats2pypre_compare_int0_int0(x, y):
  return -1 if (x < y) else (1 if (x > y) else 0)
#
############################################
#
def ats2pypre_max_int0_int0(x, y): return (max(x, y))
def ats2pypre_max_int1_int1(x, y): return (max(x, y))
#
def ats2pypre_min_int0_int0(x, y): return (min(x, y))
def ats2pypre_min_int1_int1(x, y): return (min(x, y))
#
############################################
#
# HX-2016-06
# The code is in print_cats.py:
#
# def ats2pypre_print_int(i):
#   return ats2pypre_fprint_int(sys.__stdout__, i)
# def ats2pypre_prerr_int(i):
#   return ats2pypre_fprint_int(sys.__stderr__, i)
# def ats2pypre_fprint_int(out, i): return ats2pypre_fprint_obj(out, i)
#
############################################

###### end of [integer_cats.py] ######
