######
#
# HX-2016-06:
# for Python code translated from ATS
#
######

######
# beg of [datetime_cats.py]
######

######
import datetime
######

############################################
#
# For date objects
#
############################################

def ats2pylibc_datetime_date_ctime(dt): return dt.ctime()

############################################

def ats2pylibc_datetime_date_weekday(dt): return dt.weekday()
def ats2pylibc_datetime_date_isoweekday(dt): return dt.isoweekday()

############################################

def ats2pylibc_datetime_date_replace_day(dt, d): return dt.replace(day=d)
def ats2pylibc_datetime_date_replace_year(dt, y): return dt.replace(year=y)
def ats2pylibc_datetime_date_replace_month(dt, m): return dt.replace(month=m)

############################################

def ats2pylibc_datetime_date_today(): return datetime.date.today()
def ats2pylibc_datetime_date_make_ymd(y, m, d): return datetime.date(y, m, d)

############################################
#
# For datetime objects
#
############################################

def ats2pylibc_datetime_datetime_ctime(dtm): return dtm.ctime()

############################################

def ats2pylibc_datetime_datetime_today(): return datetime.datetime.today()

############################################

###### end of [datetime_cats.py] ######
