######
#
# HX-2014-08:
# for Python code translated from ATS
#
######

######
#beg of [filebas_cats.py]
######

############################################
#
ats2pypre_stdin = sys.__stdin__
ats2pypre_stdout = sys.__stdout__
ats2pypre_stderr = sys.__stderr__
#
############################################
#
def \
ats2pypre_fileref_open_exn(path, fm):
  return open(path, fm)
def \
ats2pypre_fileref_open_opt(path, fm):
  try:
    filr = open(path, fm)
    return ats2pypre_option_some(filr)
  except IOError:
    return ats2pypre_option_none()
#
def \
ats2pypre_fileref_close(filr): return filr.close()
#
def \
ats2pypre_fileref_get_file_string(filr): return filr.read(-1)
#
############################################

###### end of [filebas_cats.py] ######
