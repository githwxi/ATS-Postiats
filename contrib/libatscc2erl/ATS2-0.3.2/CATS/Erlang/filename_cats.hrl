%%
%%%%%%
%
% HX-2015-09:
% for Erlang code
% translated from ATS
%
%%%%%%
%%

%%
%%%%%%
% beg of [filename_cats.hrl]
%%%%%%
%%

%%fun%%
ats2erlibc_filename_absname_1
  (Filename) -> filename:absname(Filename)
%%fun%%
ats2erlibc_filename_absname_2
  (Filename, Dir) -> filename:absname(Filename, Dir)

%%fun%%
ats2erlibc_filename_absname_join
  (Dir, Filename) -> filename:absname(Dir, Filename)

%% ****** ****** %%

%%fun%%
ats2erlibc_filename_basename(Filename) -> filename:basename(Filename)
%%fun%%
ats2erlibc_filename_basename(Filename, Ext) -> filename:basename(Filename, Ext)

%% ****** ****** %%

%%fun%%
ats2erlibc_filename_join_1
  (Components) -> filename:join(Components)
%%fun%%
ats2erlibc_filename_join_2
  (Filename1, Filename2) -> filename:join(Filename1, Filename2)

%% ****** ****** %%

%%fun%%
ats2erlibc_filename_rootname(Filename) -> filename:rootname(Filename)
%%fun%%
ats2erlibc_filename_rootname(Filename, Ext) -> filename:rootname(Filename, Ext)

%% ****** ****** %%

%%fun%%
ats2erlibc_filename_split(Filename) -> filename:split(Filename)

%% ****** ****** %%

%% end of [filename_cats.hrl] %%
