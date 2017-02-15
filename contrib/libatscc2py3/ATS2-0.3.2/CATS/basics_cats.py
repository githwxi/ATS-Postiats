######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
#beg of [basics_cats.py]
######

######
import sys
######

############################################
#
def ATSCKiseqz(x): return (x == 0)
def ATSCKisneqz(x): return (x != 0)
#
def ATSCKptrisnull(xs): return (xs == None)
def ATSCKptriscons(xs): return (xs != None)
#
def ATSCKpat_int(tmp, given): return (tmp == given)
def ATSCKpat_bool(tmp, given): return (tmp == given)
def ATSCKpat_char(tmp, given): return (tmp == given)
def ATSCKpat_float(tmp, given): return (tmp == given)
#
def ATSCKpat_con0 (con, tag): return (con == tag)
def ATSCKpat_con1 (con, tag): return (con[0] == tag)
#
############################################
#
def ats2pypre_list_nil(): return None
def ats2pypre_list_cons(x, xs): return (x, xs)
#
############################################
#
def ATSINScaseof_fail(em):
  print("ATSINScaseof_fail:", em, file=sys.__stderr__); sys.exit(1)
  return
#
def ATSINSdeadcode_fail():
  print("ATSINSdeadcode_fail(", ")", file=sys.__stderr__); sys.exit(1)
  return
#
############################################

def ATSPMVempty(): return

############################################

def ATSPMVlazyval_eval(lazyval):
  flag = lazyval[0]
  if (flag==0):
    lazyval[0] = 1
    mythunk = lazyval[1]
    lazyval[1] = mythunk[0](mythunk)
  else:
    lazyval[0] = flag + 1
  #endif
  return lazyval[1]
#end-of-[ATSPMVlazyval_eval]

############################################
#
def ATSPMVllazyval_eval(llazyval):
  return llazyval[0](llazyval, True)
def atspre_lazy_vt_free(llazyval):
  return llazyval[0](llazyval, False)
#
############################################

def ats2pypre_tostring(x): return str(x)
def ats2pypre_toString(x): return str(x)

############################################

def ats2pypre_lazy2cloref(lazyval): return lazyval[1]

############################################
#
def ats2pypre_exit(ecode):
  sys.exit(ecode); return
#
def ats2pypre_exit_errmsg(ecode, errmsg):
  print(errmsg, file=sys.__stderr__); sys.exit(1); return
#
############################################
#
def ats2pypre_assert_bool0(tfv):
  if not(tfv): sys.exit(1)
  return
def ats2pypre_assert_bool1(tfv):
  if not(tfv): sys.exit(1)
  return
#
def ats2pypre_assert_errmsg_bool0(tfv, errmsg):
  if not(tfv):
    print(errmsg, file=sys.__stderr__); sys.exit(1)
  return
def ats2pypre_assert_errmsg_bool1(tfv, errmsg):
  if not(tfv):
    print(errmsg, file=sys.__stderr__); sys.exit(1)
  return
#
############################################
#
def ats2pypre_cloref0_app(cf): return cf[0](cf)
def ats2pypre_cloref1_app(cf, x): return cf[0](cf, x)
def ats2pypre_cloref2_app(cf, x1, x2): return cf[0](cf, x1, x2)
def ats2pypre_cloref3_app(cf, x1, x2, x3): return cf[0](cf, x1, x2, x3)
#
############################################
#
def ats2pypre_cloref2fun0(cf):
  return lambda: ats2pypre_cloref0_app(cf)
def ats2pypre_cloref2fun1(cf):
  return lambda x: ats2pypre_cloref1_app(cf, x)
def ats2pypre_cloref2fun2(cf):
  return lambda x1, x2: ats2pypre_cloref2_app(cf, x1, x2)
def ats2pypre_cloref2fun3(cf):
  return lambda x1, x2, x3: ats2pypre_cloref3_app(cf, x1, x2, x3)
#
############################################

###### end of [basics_cats.py] ######
