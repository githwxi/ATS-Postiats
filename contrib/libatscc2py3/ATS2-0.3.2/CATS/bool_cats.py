######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
#beg of [bool_cats.py]
######

############################################
#
def ats2pypre_neg_bool0(x): return(not(x))
def ats2pypre_neg_bool1(x): return(not(x))
#
############################################

def ats2pypre_add_bool0_bool0(x, y): return(x or y)
def ats2pypre_add_bool0_bool1(x, y): return(x or y)
def ats2pypre_add_bool1_bool0(x, y): return(x or y)
def ats2pypre_add_bool1_bool1(x, y): return(x or y)

############################################

def ats2pypre_mul_bool0_bool0(x, y): return(x and y)
def ats2pypre_mul_bool0_bool1(x, y): return(x and y)
def ats2pypre_mul_bool1_bool0(x, y): return(x and y)
def ats2pypre_mul_bool1_bool1(x, y): return(x and y)

############################################
#
def ats2pypre_eq_bool0_bool0(x, y): return(x == y)
def ats2pypre_eq_bool1_bool1(x, y): return(x == y)
#
def ats2pypre_neq_bool0_bool0(x, y): return(x != y)
def ats2pypre_neq_bool1_bool1(x, y): return(x != y)
#
############################################

def ats2pypre_bool2int0(x): return(1 if x else 0)
def ats2pypre_bool2int1(x): return(1 if x else 0) 

############################################

def ats2pypre_int2bool0(x): return(True if x != 0 else False)
def ats2pypre_int2bool1(x): return(True if x != 0 else False)

############################################

###### end of [bool_cats.py] ######
