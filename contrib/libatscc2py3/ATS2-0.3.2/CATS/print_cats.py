######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
#beg of [print_cats.py]
######

############################################
#
def ats2pypre_print_int(i):
  return ats2pypre_fprint_int(sys.__stdout__, i)
def ats2pypre_prerr_int(i):
  return ats2pypre_fprint_int(sys.__stderr__, i)
#
def ats2pypre_fprint_int(out, i): return ats2pypre_fprint_obj(out, i)
#
############################################
#
def ats2pypre_print_bool(b):
  return ats2pypre_fprint_bool(sys.__stdout__, b)
def ats2pypre_prerr_bool(b):
  return ats2pypre_fprint_bool(sys.__stderr__, b)
#
def ats2pypre_fprint_bool(out, b): return ats2pypre_fprint_obj(out, b)
#
############################################
#
def ats2pypre_print_char(c):
  return ats2pypre_fprint_char(sys.__stdout__, c)
def ats2pypre_prerr_char(c):
  return ats2pypre_fprint_char(sys.__stderr__, c)
#
def ats2pypre_fprint_char(out, c): return ats2pypre_fprint_obj(out, c)
#
############################################
#
def ats2pypre_print_double(i):
  return ats2pypre_fprint_double(sys.__stdout__, i)
def ats2pypre_prerr_double(i):
  return ats2pypre_fprint_double(sys.__stderr__, i)
#
def ats2pypre_fprint_double(out, i): return ats2pypre_fprint_obj(out, i)
#
############################################
#
def ats2pypre_print_string(x):
  return ats2pypre_fprint_string(sys.__stdout__, x)
def ats2pypre_prerr_string(x):
  return ats2pypre_fprint_string(sys.__stderr__, x)
#
def ats2pypre_fprint_string(out, x): return ats2pypre_fprint_obj(out, x)
#
############################################
#
def ats2pypre_print_obj(x):
  out = sys.__stdout__
  ats2pypre_fprint_obj(out, x); return
def ats2pypre_println_obj(x):
  out = sys.__stdout__
  ats2pypre_fprintln_obj(out, x); return
#
def ats2pypre_prerr_obj(x):
  out = sys.__stderr__
  ats2pypre_fprint_obj(out, x); return
def ats2pypre_prerrln_obj(x):
  out = sys.__stderr__
  ats2pypre_fprintln_obj(out, x); return
#
def ats2pypre_fprint_obj(out, x):
  print(x, file=out, end=''); return
def ats2pypre_fprintln_obj(out, x):
  print(x, file=out, end='\n'); return
#
############################################
#
def ats2pypre_print_newline():
  out = sys.__stdout__
  ats2pypre_fprint_newline(out); return
def ats2pypre_prerr_newline():
  out = sys.__stderr__
  ats2pypre_fprint_newline(out); return
#
def ats2pypre_fprint_newline(out):
  print(file=out, end='\n'); sys.stdout.flush(); return
#
############################################

###### end of [print_cats.py] ######
