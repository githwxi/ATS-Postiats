######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
# beg of [reference_cats.py]
######

############################################

def ats2pypre_ref(x): return [x]
def ats2pypre_ref_make_elt(x): return [x]

############################################
#
def ats2pypre_ref_get_elt(ref): return ref[0]
def ats2pypre_ref_set_elt(ref, x0): ref[0] = x0; return
#
def ats2pypre_ref_exch_elt(ref, x0): x1 = ref[0]; ref[0] = x0; return x1
#
############################################

###### end of [reference_cats.py] ######
