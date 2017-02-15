######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
#beg of [string_cats.py]
######

def ats2pypre_strchr_chr(x): return chr(x)
def ats2pypre_strchr_ord(x): return ord(x)

############################################

def ats2pypre_strlen(x): return (x.__len__())

############################################

def ats2pypre_string_length(x): return len(x)

############################################

def ats2pypre_string_get_at(x, i): return(x[i])

############################################

def ats2pypre_string_substring_beg_end(x, i, j): return(x[i:j])
def ats2pypre_string_substring_beg_len(x, i, n): return(x[i:i+n])

############################################
#
def ats2pypre_lt_string_string(x, y): return (x < y)
def ats2pypre_lte_string_string(x, y): return (x <= y)
#
def ats2pypre_gt_string_string(x, y): return (x > y)
def ats2pypre_gte_string_string(x, y): return (x >= y)
#
def ats2pypre_eq_string_string(x, y): return (x == y)
def ats2pypre_neq_string_string(x, y): return (x != y)
#
############################################
#
def ats2pypre_compare_string_string(x, y):
  return -1 if (x < y) else (1 if (x > y) else 0)
#
############################################

def ats2pypre_string_isalnum(x): return (x.isalnum())
def ats2pypre_string_isalpha(x): return (x.isalpha())
def ats2pypre_string_isdecimal(x): return (x.isdecimal())

############################################

def ats2pypre_string_lower(x): return (x.lower())
def ats2pypre_string_upper(x): return (x.upper())

############################################

def ats2pypre_string_append_2(x1, x2): return (x1+x2)
def ats2pypre_string_append_3(x1, x2, x3): return "".join((x1, x2, x3))
def ats2pypre_string_append_4(x1, x2, x3, x4): return "".join((x1, x2, x3, x4))

############################################

###### end of [string_cats.py] ######
